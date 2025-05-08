/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.main.app.model;

public class Admin extends User {

    public Admin() {
        this.username = "admin";
        this.password = "admin";
    }

    public Admin(String username, String password) {
        super(username, password);
    }
}
