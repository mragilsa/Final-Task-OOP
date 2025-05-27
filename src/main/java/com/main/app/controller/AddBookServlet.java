// File: com/main/app/controller/AddBookServlet.java
package com.main.app.controller;

import com.main.app.dao.BookDAO;
import com.main.app.model.Book;

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
            bookDAO.addBook(new Book(0, title, author, year, stock));
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("admin-page.jsp");
    }
}