package com.vinhkhanh.entity;

import java.time.LocalDateTime;


public class News {
	private String id;
    private String title;
    private String content;
    private String image;
    private LocalDateTime postedDate;
    private String authorId;
    private Integer viewCount;
    private Boolean home;
    private Boolean isActive;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Getters and Setters  
    public String getAuthorId() {
        return authorId;
    }
    public void setAuthorId(String authorId) {
        this.authorId = authorId;
    }
    public String getId() {
        return id;
    }       
    public void setId(String id) {
        this.id = id;
    }
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
    public LocalDateTime getPostedDate() {
        return postedDate;
    }
    public void setPostedDate(LocalDateTime postedDate) {
        this.postedDate = postedDate;
    }
    public Integer getViewCount() {
        return viewCount;
    }
    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }
    public Boolean getHome() {
        return home;
    }
    public void setHome(Boolean home) {
        this.home = home;
    }
    public Boolean getIsActive() {
        return isActive;
    }
    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    //constructors
    public News() {
        super();
    }
    public News(String id, String title, String content, String image, LocalDateTime postedDate, Integer viewCount,
            Boolean home, Boolean isActive, LocalDateTime createdAt, LocalDateTime updatedAt, String authorId) {
        super();
        this.id = id;
        this.title = title;
        this.content = content;
        this.image = image;
        this.postedDate = postedDate;
        this.viewCount = viewCount;
        this.home = home;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.authorId = authorId;
    }
}
