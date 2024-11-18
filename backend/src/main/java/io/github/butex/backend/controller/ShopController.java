package io.github.butex.backend.controller;

import io.github.butex.backend.dal.entity.Shop;
import io.github.butex.backend.dal.repository.ShopRepository;
import io.github.butex.backend.dto.ShopDTO;
import io.github.butex.backend.service.ShopService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequestMapping("/api/v1/shop")
@RestController
@RequiredArgsConstructor
public class ShopController {

    private final ShopService shopService;

    @GetMapping
    public List<ShopDTO> getAllShops(){
        return shopService.getAllShops();
    }

}
