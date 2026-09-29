package vn.iotstar.baitap09_vd3.service;

public interface EmailService {
    void sendOtp(String email, String otp, String subject);
}