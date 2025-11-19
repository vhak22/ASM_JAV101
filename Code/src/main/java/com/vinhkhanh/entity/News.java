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
public class News {
	private String id;
    private String title;
    private String content;
    private String image;
    private LocalDateTime postedDate;
    private Integer viewCount;
    private Boolean home;
    private Boolean isActive;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
