// File: com/main/app/controller/EditBookServlet.java
package com.main.app.controller;

import com.main.app.dao.BookDAO;
import com.main.app.model.Book;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/editBook")
public class EditBookServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        BookDAO bookDAO = new BookDAO();

        try {
            Book book = bookDAO.getBookById(id);
            request.setAttribute("book", book);
            RequestDispatcher dispatcher = request.getRequestDispatcher("edit-book.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin-page.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int year = Integer.parseInt(request.getParameter("year"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        BookDAO bookDAO = new BookDAO();
        try {
            bookDAO.editBook(new Book(id, title, author, year, stock));
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("admin-page.jsp");
    }
}