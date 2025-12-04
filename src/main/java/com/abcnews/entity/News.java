package com.abcnews.entity;

import java.sql.Date;

public class News {
    private String id;
    private String title;
    private String content;
    private String image;
    private Date postedDate;
    private String author;        
    private int viewCount;
    private String categoryId;
    private boolean home;
    private String reporterId;

    public String getId() {
        return id;
    }

    public void setId(String string) {
        this.id = string;
    }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public Date getPostedDate() { return postedDate; }
    public void setPostedDate(Date postedDate) {
        this.postedDate = postedDate;
    }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public int getViewCount() { return viewCount; }
    public void setViewCount(int viewCount) { this.viewCount = viewCount; }

    public boolean isHome() { return home; }
    public void setHome(boolean home) { this.home = home; }
    public String getReporterId() {
        return reporterId;
    }

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId2)
 {		this.categoryId = categoryId2;
	}
  
}
