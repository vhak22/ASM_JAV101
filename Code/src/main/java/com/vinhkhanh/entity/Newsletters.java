package com.vinhkhanh.entity;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class Newsletters {
	private String email;
    private Boolean enabled;
    private LocalDateTime subscribedAt;
}
