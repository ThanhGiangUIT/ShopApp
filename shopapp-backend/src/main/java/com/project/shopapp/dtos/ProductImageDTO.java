package com.project.shopapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Size;
import lombok.*;

@Table(name ="product_images")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class ProductImageDTO {

    @JsonProperty("product_id")
    @Min(value = 1, message = "Product's Id must be > 0")
    private Long productId;

    @Size(min = 5, max = 200, message = "Image's name must be between 3 and 200 characters")
    @JsonProperty("image_URL")
    private String imageUrl;
}
