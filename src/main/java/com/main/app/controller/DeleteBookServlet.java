package com.main.app.controller;

import com.main.app.dao.BookDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteBook")
public class DeleteBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("id"));
        BookDAO dao = new BookDAO();

        try {
            dao.deleteBook(bookId);
        } catch (Exception e) {
            e.printStackTrace(); // atau log error
        }

        response.sendRedirect("admin-page.jsp");
    }
}