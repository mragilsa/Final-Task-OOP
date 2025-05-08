/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.main.app.model;

public class Member extends User {
    private String governmentId;
    private String phoneNumber;
    private String gender;
    private String email;

    public Member() {
        super();
    }

    public Member(String username, String password, String governmentId, String phoneNumber, String gender, String email) {
        super(username, password);
        this.governmentId = governmentId;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.email = email;
    }

    public String getGovernmentId() {
        return governmentId;
    }

    public void setGovernmentId(String governmentId) {
        this.governmentId = governmentId;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}