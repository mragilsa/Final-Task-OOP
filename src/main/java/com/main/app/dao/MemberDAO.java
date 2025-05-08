/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.main.app.dao;

import com.main.app.model.Member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {

    private final Connection connection;

    public MemberDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean registerMember(Member member) throws SQLException {
        String query = "INSERT INTO members (username, password, government_id, phone_number, gender, email) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, member.getUsername());
            stmt.setString(2, member.getPassword());
            stmt.setString(3, member.getGovernmentId());
            stmt.setString(4, member.getPhoneNumber());
            stmt.setString(5, member.getGender());
            stmt.setString(6, member.getEmail());
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        }
    }

    public Member loginMember(String username, String password) throws SQLException {
        String query = "SELECT * FROM members WHERE username = ? AND password = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Member(
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("government_id"),
                        rs.getString("phone_number"),
                        rs.getString("gender"),
                        rs.getString("email")
                    );
                } else {
                    return null;
                }
            }
        }
    }

    public List<Member> getAllMembers() throws SQLException {
        String query = "SELECT * FROM members";
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            List<Member> members = new ArrayList<>();
            while (rs.next()) {
                members.add(new Member(
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("government_id"),
                    rs.getString("phone_number"),
                    rs.getString("gender"),
                    rs.getString("email")
                ));
            }
            return members;
        }
    }
}
