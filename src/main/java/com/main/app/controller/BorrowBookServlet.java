package com.main.app.controller;

import com.main.app.dao.TransactionDAO;
import com.main.app.model.Transaction;
import com.main.app.model.Member;
import com.main.app.db.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.util.Calendar;

@WebServlet("/borrow-book")
public class BorrowBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookIdParam = request.getParameter("bookId");
        String durationParam = request.getParameter("duration");

        // Validasi input dari request
        if (bookIdParam == null || bookIdParam.isEmpty() || durationParam == null || durationParam.isEmpty()) {
            response.sendRedirect("borrow-book.jsp?message=Parameter tidak valid.");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdParam);
            int duration = Integer.parseInt(durationParam);

            // Validasi session dan ambil data member
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("member") == null) {
                response.sendRedirect("member-login.jsp?message=Silakan login terlebih dahulu.");
                return;
            }

            Member member = (Member) session.getAttribute("member");
            String username = member.getUsername();

            // Hitung tanggal pinjam dan kembali
            java.util.Date today = new java.util.Date();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(today);
            calendar.add(Calendar.DAY_OF_MONTH, duration);

            Date borrowDate = new Date(today.getTime());
            Date returnDate = new Date(calendar.getTimeInMillis());

            // Simpan ke database
            try (Connection connection = DatabaseConnection.getConnection()) {
                Transaction transaction = new Transaction(username, bookId, borrowDate, returnDate, duration);
                TransactionDAO dao = new TransactionDAO(connection);

                boolean success = dao.insertTransaction(transaction);
                if (success) {
                    response.sendRedirect("member-page.jsp?message=Berhasil meminjam buku.");
                } else {
                    response.sendRedirect("borrow-book.jsp?message=Gagal meminjam buku.");
                }
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("borrow-book.jsp?message=Format angka salah.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("borrow-book.jsp?message=Terjadi kesalahan server.");
        }
    }
}