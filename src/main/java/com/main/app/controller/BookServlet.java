package com.main.app.controller;

import com.main.app.dao.BookDAO;
import com.main.app.db.DatabaseConnection;
import com.main.app.model.Book;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/books")
public class BookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String mode = request.getParameter("mode");

        if ("delete".equals(mode)) {
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                try (Connection conn = DatabaseConnection.getConnection()) {
                    BookDAO bookDAO = new BookDAO(conn);
                    bookDAO.deleteBook(id);
                    // simpan ke session
                    HttpSession session = request.getSession();
                    session.setAttribute("success", "delete");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete book.");
                    return;
                }
            }
            response.sendRedirect("books");
            return;
        }

        // tampilkan daftar buku
        try (Connection conn = DatabaseConnection.getConnection()) {
            BookDAO bookDAO = new BookDAO(conn);
            List<Book> books = bookDAO.getAllBooks();
            request.setAttribute("books", books);

            // pindahkan success dari session ke request
            HttpSession session = request.getSession();
            String success = (String) session.getAttribute("success");
            if (success != null) {
                request.setAttribute("success", success);
                session.removeAttribute("success"); // biar gak ke-trigger terus
            }

            request.getRequestDispatcher("admin-page.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to load book data.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String mode = request.getParameter("mode");
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String year = request.getParameter("year");
        String stockStr = request.getParameter("stock");

        try (Connection conn = DatabaseConnection.getConnection()) {
            BookDAO bookDAO = new BookDAO(conn);

            int stock = 0;
            if (stockStr != null && !stockStr.isEmpty()) {
                stock = Integer.parseInt(stockStr);
            }

            HttpSession session = request.getSession();

            if ("add".equals(mode)) {
                Book book = new Book(id, title, author, year, stock);
                bookDAO.addBook(book);
                session.setAttribute("success", "add");
                response.sendRedirect("books");
                return;

            } else if ("edit".equals(mode)) {
                String oldId = request.getParameter("oldId");
                Book book = new Book(id, title, author, year, stock);
                bookDAO.updateBook(book, oldId);
                session.setAttribute("success", "edit");
                response.sendRedirect("books");
                return;

            } else if ("delete".equals(mode)) {
                bookDAO.deleteBook(id);
                session.setAttribute("success", "delete");
                response.sendRedirect("books");
                return;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred.");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Stock must be a valid number.");
        }

        response.sendRedirect("books");
    }
}
