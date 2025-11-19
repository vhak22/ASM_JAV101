package com.vinhkhanh.entity;
import java.time.LocalDate;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class Users {
	private String id;
    private String password;
    private String fullname;
    private LocalDate birthday;
    private Boolean gender;
    private String mobile;
    private String email;
    private Boolean role;
    private LocalDateTime createdAt;
}
