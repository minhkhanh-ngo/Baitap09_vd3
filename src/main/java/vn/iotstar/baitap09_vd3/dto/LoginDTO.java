package vn.iotstar.baitap09_vd3.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class LoginDTO {
    @NotBlank
    private String username;
    
    @NotBlank
    private String password;
}