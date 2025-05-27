/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.main.app.controller;

import com.main.app.dao.MemberDAO;
import com.main.app.model.Member;
import com.main.app.db.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/member-signup")
public class MemberSignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String governmentId = request.getParameter("governmentId");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Member member = new Member(username, password, governmentId, phoneNumber, gender, email);

        try (Connection connection = DatabaseConnection.getConnection()) {
            MemberDAO memberDAO = new MemberDAO(connection);
            boolean isRegistered = memberDAO.registerMember(member);

            if (isRegistered) {
                response.sendRedirect("member-login.jsp");
            } else {
                response.getWriter().println("Signup Failed");
            }
        } catch (Exception e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}