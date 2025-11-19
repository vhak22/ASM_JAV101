package com.vinhkhanh.entity;

import java.time.LocalDateTime;

public class Newsletters {
	private String email;
    private Boolean enabled;
    private LocalDateTime subscribedAt;
    // Getters and Setters  
    public String getEmail() {
        return email;
    }   
    public void setEmail(String email) {
        this.email = email;
    }
    public Boolean getEnabled() {
        return enabled;
    }
    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }
    public LocalDateTime getSubscribedAt() {
        return subscribedAt;
    }
    public void setSubscribedAt(LocalDateTime subscribedAt) {
        this.subscribedAt = subscribedAt;
    }
    // You can add constructors
    public Newsletters() {
        super();
    }
    public Newsletters(String email, Boolean enabled, LocalDateTime subscribedAt) {
        super();
        this.email = email;
        this.enabled = enabled;
        this.subscribedAt = subscribedAt;
    }
}
