package io.github.butex.backend.client;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.github.butex.backend.dto.furgonetka.FurgonetkaPackageRequestDTO;
import io.github.butex.backend.dto.furgonetka.FurgonetkaTokenResponseDTO;
import io.github.butex.backend.exception.FurgonetkaException;
import okhttp3.FormBody;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.Objects;

@Component
public class FurgonetkaClient {

    private static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");

    @Value("${furgonetka.environment-url}")
    private String environmentUrl;

    @Value("${furgonetka.endpoint.package-validate}")
    private String packageValidateUrl;

    @Value("${furgonetka.endpoint.package-create}")
    private String packageCreate;

    @Value("${furgonetka.api-token}")
    private String apiToken;

    public void createOrderPackage(FurgonetkaPackageRequestDTO furgonetkaPackageRequestDTO) {
        String body;
        try {
            body = new ObjectMapper().writeValueAsString(furgonetkaPackageRequestDTO);
        } catch (Exception e) {
            throw new FurgonetkaException("Nie udało się utworzyć przesyłki");
        }

        String apiKey = provideApiKey();
        if (StringUtils.isEmpty(apiKey)) {
            throw new FurgonetkaException("Błąd podczas łączenia z serwisem dostaw");
        }

        String apiAccessToken = "Bearer " + apiKey;

        RequestBody requestBody = RequestBody.create(body, JSON);
        Request request = new Request.Builder()
                .url(environmentUrl + packageCreate)
                .addHeader("Authorization", apiAccessToken)
                .post(requestBody)
                .build();

        try {
            Response response = new OkHttpClient().newCall(request).execute();
            if (!response.isSuccessful()) {
                throw new FurgonetkaException("Nie udało się utworzyć przesyłki");
            }
        } catch (Exception ignored) {
            throw new FurgonetkaException("Nie udało się utworzyć przesyłki");
        }
    }

    public void validateOrderPackage(FurgonetkaPackageRequestDTO furgonetkaPackageRequestDTO) {
        String body;
        try {
            body = new ObjectMapper().writeValueAsString(furgonetkaPackageRequestDTO);
        } catch (Exception e) {
            throw new FurgonetkaException("Nie udało się utworzyć przesyłki");
        }

        String apiKey = provideApiKey();
        if (StringUtils.isEmpty(apiKey)) {
            throw new FurgonetkaException("Błąd podczas łączenia z serwisem dostaw");
        }

        String apiAccessToken = "Bearer " + apiKey;

        RequestBody requestBody = RequestBody.create(body, JSON);
        Request request = new Request.Builder()
                .url(environmentUrl + packageValidateUrl)
                .addHeader("Authorization", apiAccessToken)
                .post(requestBody)
                .build();

        try {
            Response response = new OkHttpClient().newCall(request).execute();
            if (!response.isSuccessful() || !StringUtils.isEmpty(response.body().string())) {
                throw new FurgonetkaException("Nie udało się utworzyć przesyłki");
            }
        } catch (Exception ignored) {
            throw new FurgonetkaException("Nie udało się utworzyć przesyłki");
        }
    }

    private String provideApiKey() {
        FormBody body = new FormBody.Builder()
                .addEncoded("grant_type", "password")
                .addEncoded("scope", "api")
                .addEncoded("username", "240788@edu.p.lodz.pl")
                .addEncoded("password", "testowehaslo123")
                .build();

        Request request = new Request.Builder()
                .url("https://api.sandbox.furgonetka.pl/oauth/token")
                .addHeader("Authorization", "Basic " + apiToken)
                .post(body)
                .build();

        try {
            Response response = new OkHttpClient().newCall(request).execute();
            return new ObjectMapper().readValue(Objects.requireNonNull(response.body()).string(), FurgonetkaTokenResponseDTO.class).getAccessToken();
        } catch (Exception sa) {
            return null;
        }
    }
}
