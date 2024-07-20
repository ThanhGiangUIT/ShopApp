package com.project.shopapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import jakarta.validation.constraints.*;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;

@Data //toString
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class ProductDTO {
    @NotBlank(message = "Sản phẩm phải có tên")
    @Size(min = 3, max = 200, message = "Sản phẩm phải có tên từ 3 đến 200 ký tự")
    private String name;

    @Min(value = 0,message = "Gía của sản phẩm phải lớn hơn hoặc bằng 0")
    @Max(value = 10000000, message = "Gía của sản phẩm không được vượt quá 10,000,000")
    private Float price;

    private String thumbnail;

    private String description;

    @JsonProperty("category_id")
    private Long categoryId;

}
