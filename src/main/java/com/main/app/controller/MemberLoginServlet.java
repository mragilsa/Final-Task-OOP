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

@WebServlet("/member-login")
public class MemberLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection connection = DatabaseConnection.getConnection()) {
            MemberDAO memberDAO = new MemberDAO(connection);
            Member member = memberDAO.loginMember(username, password);
            
            if (member != null) {
                HttpSession session = request.getSession();
                session.setAttribute("member", member);
                session.setAttribute("username", member.getUsername()); // <--- ini penting untuk ReturnBookServlet
                
                response.sendRedirect("member-page.jsp");
            } else {
                response.getWriter().println("Login Failed. Please check your credentials.");
            }
        } catch (Exception e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}
