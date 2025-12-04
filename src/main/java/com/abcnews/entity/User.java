package com.abcnews.entity;

public class User {

    private String id;
    private String password;
    private String fullname;
    private String birthday;
    private boolean gender;
    private String mobile;
    private String email;
    private boolean role; 

    public User() {
    }

    public User(String id, String password, String fullname, String birthday,
                boolean gender, String mobile, String email, boolean role) {
        this.id = id;
        this.password = password;
        this.fullname = fullname;
        this.birthday = birthday;
        this.gender = gender;
        this.mobile = mobile;
        this.email = email;
        this.role = role;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getBirthday() { return birthday; }
    public void setBirthday(String birthday) { this.birthday = birthday; }

    public boolean isGender() { return gender; }
    public void setGender(boolean gender) { this.gender = gender; }

    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public boolean isRole() {
        return role;
    }

    public void setRole(boolean role) {
        this.role = role;
    }
    public String getRole() { return email; }
}
