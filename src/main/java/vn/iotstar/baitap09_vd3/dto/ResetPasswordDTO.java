package vn.iotstar.baitap09_vd3.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class ResetPasswordDTO {
    @NotBlank @Email
    private String email;
    
    @NotBlank
    @Size(min = 6)
    private String password;
    
    @NotBlank
    private String confirmPassword;
}