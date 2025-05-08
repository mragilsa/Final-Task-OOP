/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.main.app.controller;

import com.main.app.dao.MemberDAO;
import com.main.app.model.Member;
import com.main.app.db.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/member-view")
public class MemberViewServlet extends HttpServlet {

    private MemberDAO memberDAO;
    private static final Logger LOGGER = Logger.getLogger(MemberViewServlet.class.getName());

    @Override
    public void init() throws ServletException {
        super.init();
        Connection connection = DatabaseConnection.getConnection();
        memberDAO = new MemberDAO(connection);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username != null) {  // Pastikan admin sudah login
            try {
                List<Member> members = memberDAO.getAllMembers();
                request.setAttribute("members", members);
                // Pastikan view-member.jsp ada di lokasi yang benar
                request.getRequestDispatcher("/member-view.jsp").forward(request, response);
            } catch (SQLException e) {
                LOGGER.severe("Error retrieving members: " + e.getMessage());
                request.setAttribute("errorMessage", "Error retrieving members.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("admin-login.jsp");
        }
    }
}