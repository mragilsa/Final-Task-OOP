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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/return-page")
public class ReturnBookServlet extends HttpServlet {

    private BookDAO bookDAO;
    private TransactionDAO transactionDAO;
    private static final Logger LOGGER = Logger.getLogger(ReturnBookServlet.class.getName());

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

        String memberUsername = member.getUsername();

        try {
            List<Transaction> borrowedBooks = transactionDAO.getTransactionsByMember(memberUsername);
            borrowedBooks.removeIf(transaction -> !"Borrowed".equals(transaction.getStatus()));

            request.setAttribute("transactions", borrowedBooks);
            request.getRequestDispatcher("/return-page.jsp").forward(request, response);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving borrowed books", e);
            request.setAttribute("errorMessage", "Error retrieving borrowed books: " + e.getMessage());
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

        String memberUsername = member.getUsername();
        String transactionId = request.getParameter("transactionId");

        if (transactionId == null || transactionId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Transaction ID is required");
            doGet(request, response);
            return;
        }

        try {
            List<Transaction> borrowedBooks = transactionDAO.getTransactionsByMember(memberUsername);

            Transaction transactionToReturn = null;
            for (Transaction trx : borrowedBooks) {
                if (trx.getId().equals(transactionId) && "Borrowed".equals(trx.getStatus())) {
                    transactionToReturn = trx;
                    break;
                }
            }

            if (transactionToReturn == null) {
                request.setAttribute("errorMessage", "Invalid transaction or book already returned");
                doGet(request, response);
                return;
            }

            Date returnDate = new Date();
            boolean updateSuccess = transactionDAO.updateReturnDate(transactionId, returnDate, "Returned");

            if (updateSuccess) {
                Book book = bookDAO.getBookByTitle(transactionToReturn.getBook().getTitle());
                if (book != null) {
                    book.setStock(book.getStock() + 1);
                    bookDAO.updateBook(book, book.getId());
                    response.sendRedirect("member-page.jsp?message=returnSuccess");
                } else {
                    LOGGER.log(Level.WARNING, "Book not found when returning: {0}", transactionToReturn.getBook().getTitle());
                    response.sendRedirect("member-page.jsp?message=returnSuccess");
                }
            } else {
                request.setAttribute("errorMessage", "Failed to return book");
                doGet(request, response);
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error during book return", e);
            request.setAttribute("errorMessage", "Error during book return: " + e.getMessage());
            doGet(request, response);
        }
    }
}
