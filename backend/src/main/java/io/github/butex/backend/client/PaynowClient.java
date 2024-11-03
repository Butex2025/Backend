package io.github.butex.backend.client;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.github.butex.backend.dto.paynow.PaynowRequestDTO;
import io.github.butex.backend.dto.paynow.PaynowResponseDTO;
import io.github.butex.backend.dto.paynow.PaynowStatusResponseDTO;
import io.github.butex.backend.exception.PaynowException;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;
import java.util.Objects;
import java.util.Random;

@Component
public class PaynowClient {

    private static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
    private static final String HMAC_SHA256_ALGORITHM_NAME = "HmacSHA256";

    @Value("${paynow.api-token}")
    private String apiToken;

    @Value("${paynow.signature-token}")
    private String signatureToken;

    @Value("${paynow.environment-url}")
    private String environmentUrl;

    @Value("${paynow.endpoint.payment-create}")
    private String paymentCreate;

    @Value("${paynow.endpoint.payment-status}")
    private String paymentStatus;

    public PaynowStatusResponseDTO getPaymentStatus(String paymentId) {
        String fixedPaymentStatus = StringUtils.replace(paymentStatus, "{paymentId}", paymentId);

        Request request = new Request.Builder()
                .url(environmentUrl + fixedPaymentStatus)
                .addHeader("Api-Key", apiToken)
                .build();

        try {
            Response response = new OkHttpClient().newCall(request).execute();
            if (!response.isSuccessful()) {
                throw new PaynowException("Nie udało się potwierdzić statusu płatności");
            }

            return new ObjectMapper().readValue(Objects.requireNonNull(response.body()).string(), PaynowStatusResponseDTO.class);
        } catch (Exception ignored) {
            throw new PaynowException("Nie udało się potwierdzić statusu płatności");
        }
    }

    public PaynowResponseDTO createPayment(PaynowRequestDTO paynowRequestDTO) {
        String body;
        try {
            body = new ObjectMapper().writeValueAsString(paynowRequestDTO);
        } catch (Exception e) {
            throw new PaynowException("Nie udało się utworzyć płatności");
        }

        String calculatedSignature = calculateHMAC(body.getBytes(), this.signatureToken.getBytes());

        RequestBody requestBody = RequestBody.create(body, JSON);
        Request request = new Request.Builder()
                .url(environmentUrl + paymentCreate)
                .addHeader("Api-Key", apiToken)
                .addHeader("Signature", calculatedSignature)
                .addHeader("Idempotency-Key", generateRandomString())
                .post(requestBody)
                .build();

        try {
            Response response = new OkHttpClient().newCall(request).execute();
            if (!response.isSuccessful()) {
                throw new PaynowException("Nie udało się utworzyć płatności");
            }

            return new ObjectMapper().readValue(Objects.requireNonNull(response.body()).string(), PaynowResponseDTO.class);
        } catch (Exception ignored) {
            throw new PaynowException("Nie udało się utworzyć płatności");
        }
    }

    private String calculateHMAC(byte[] data, byte[] key) {
        try {
            SecretKeySpec signingKey = new SecretKeySpec(key, HMAC_SHA256_ALGORITHM_NAME);
            Mac mac = Mac.getInstance(HMAC_SHA256_ALGORITHM_NAME);
            mac.init(signingKey);
            byte[] hashedBytes = mac.doFinal(data);
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (Exception e) {
            return null;
        }
    }

    public String generateRandomString() {
        int leftLimit = 97;
        int rightLimit = 122;
        int targetStringLength = 15;
        Random random = new Random();
        StringBuilder buffer = new StringBuilder(targetStringLength);
        for (int i = 0; i < targetStringLength; i++) {
            int randomLimitedInt = leftLimit + (int)
                    (random.nextFloat() * (rightLimit - leftLimit + 1));
            buffer.append((char) randomLimitedInt);
        }
        return buffer.toString();
    }
}