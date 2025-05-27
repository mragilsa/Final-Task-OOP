// File: com/main/app/model/Admin.java
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