package vn.iotstar.baitap09_vd3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.iotstar.baitap09_vd3.entity.OtpToken;
import java.util.Optional;

@Repository 
public interface OtpTokenRepository extends JpaRepository<OtpToken, Long> {
    Optional<OtpToken> findTopByEmailAndTypeAndUsedFalseOrderByCreatedAtDesc(String email, String type);
    void deleteByEmailAndType(String email, String type);
    Optional<OtpToken> findTopByEmailAndTypeOrderByCreatedAtDesc(String email, String type);
}