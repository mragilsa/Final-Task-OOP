package com.main.app.controller;

import com.main.app.dao.BookDAO;
import com.main.app.dao.TransactionDAO;
import com.main.app.model.Book;
import com.main.app.model.Member;
import com.main.app.model.Transaction;
import com.main.app.db.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/borrow-page")
public class BorrowBookServlet extends HttpServlet {

    private BookDAO bookDAO;
    private TransactionDAO transactionDAO;
    private static final Logger LOGGER = Logger.getLogger(BorrowBookServlet.class.getName());

    @Override
    public void init() throws ServletException {
        super.init();
        Connection connection = DatabaseConnection.getConnection();
        bookDAO = new BookDAO(connection);
        transactionDAO = new TransactionDAO(connection);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Member member = (Member) session.getAttribute("member");

        if (member == null) {
            response.sendRedirect("member-login.jsp");
            return;
        }

        try {
            List<Book> availableBooks = bookDAO.getAllBooks();
            request.setAttribute("books", availableBooks);
            request.getRequestDispatcher("/borrow-page.jsp").forward(request, response);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving books", e);
            request.setAttribute("errorMessage", "Error retrieving books: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Member member = (Member) session.getAttribute("member");

        if (member == null) {
            response.sendRedirect("member-login.jsp");
            return;
        }

        String bookId = request.getParameter("bookId");

        if (bookId == null || bookId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Book ID is required");
            doGet(request, response);
            return;
        }

        try {
            Book book = bookDAO.getBookById(bookId);
            if (book == null) {
                request.setAttribute("errorMessage", "Book not found");
                doGet(request, response);
                return;
            }

            if (book.getStock() <= 0) {
                request.setAttribute("errorMessage", "Book is out of stock");
                doGet(request, response);
                return;
            }

            String transactionId = "TRX" + UUID.randomUUID().toString().substring(0, 8);

            Transaction transaction = new Transaction();
            transaction.setId(transactionId);
            transaction.setMember(member);
            transaction.setBook(book);
            transaction.setBorrowDate(new Date());
            transaction.setStatus("Borrowed");

            boolean success = transactionDAO.insertTransaction(transaction);

            if (success) {
                book.setStock(book.getStock() - 1);
                bookDAO.updateBook(book, book.getId());

                response.sendRedirect("member-page.jsp?message=borrowSuccess");
            } else {
                request.setAttribute("errorMessage", "Failed to borrow book");
                doGet(request, response);
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error during book borrowing", e);
            request.setAttribute("errorMessage", "Error during book borrowing: " + e.getMessage());
            doGet(request, response);
        }
    }
}
