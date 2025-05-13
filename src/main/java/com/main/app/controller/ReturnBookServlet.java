package com.main.app.controller;

import com.main.app.dao.TransactionDAO;
import com.main.app.model.Transaction;
import com.main.app.db.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/return-book")
public class ReturnBookServlet extends HttpServlet {

    private TransactionDAO transactionDAO;

    @Override
    public void init() {
        Connection conn = DatabaseConnection.getConnection();
        transactionDAO = new TransactionDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("return".equals(action)) {
                int transactionId = Integer.parseInt(request.getParameter("transactionId"));
                int bookId = Integer.parseInt(request.getParameter("bookId"));

                boolean deleted = transactionDAO.deleteTransaction(transactionId);
                boolean updated = transactionDAO.increaseBookStock(bookId);

                if (deleted && updated) {
                    System.out.println("Berhasil mengembalikan buku.");
                }
                response.sendRedirect("return-book");
                return;

            } else if ("view_all".equals(action)) {
                // Ini untuk admin, ambil semua transaksi
                List<Transaction> allTransactions = transactionDAO.getAllTransactions();
                request.setAttribute("borrowed_books", allTransactions);
                RequestDispatcher dispatcher = request.getRequestDispatcher("view-transaction.jsp");
                dispatcher.forward(request, response);
                return;

            } else {
                // default: member hanya melihat transaksi miliknya
                String username = (String) session.getAttribute("username");
                List<Transaction> userTransactions = transactionDAO.getTransactionsByUsername(username);
                request.setAttribute("borrowed_books", userTransactions);
                RequestDispatcher dispatcher = request.getRequestDispatcher("return-book.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Terjadi kesalahan.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}