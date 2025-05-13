package com.main.app.controller;

import com.main.app.dao.BookDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/addBook")
public class AddBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int year = Integer.parseInt(request.getParameter("year"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        BookDAO bookDAO = new BookDAO();
        try {
            bookDAO.addBook(title, author, year, stock);  // Add the book to the DB
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("admin-page.jsp");  // Redirect after adding the book
    }
}