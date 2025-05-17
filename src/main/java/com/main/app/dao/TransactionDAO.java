/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.main.app.dao;

/**
 *
 * @author Alvito
 */
import com.main.app.db.DatabaseConnection;
import com.main.app.model.Book;
import com.main.app.model.Member;
import com.main.app.model.Transaction;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TransactionDAO {

    private final Connection connection;

    public TransactionDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean insertTransaction(Transaction transaction) throws SQLException {
        String query = "INSERT INTO transactions (transaction_id, member_username, book_title, borrow_date, return_date, status) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, transaction.getId());
            stmt.setString(2, transaction.getMember().getUsername());
            stmt.setString(3, transaction.getBook().getTitle());
            stmt.setDate(4, new java.sql.Date(transaction.getBorrowDate().getTime()));
            if (transaction.getReturnDate() != null) {
                stmt.setDate(5, new java.sql.Date(transaction.getReturnDate().getTime()));
            } else {
                stmt.setNull(5, Types.DATE);
            }
            stmt.setString(6, transaction.getStatus());
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Transaction> getAllTransactions() throws SQLException {
        String query = "SELECT * FROM transactions ORDER BY borrow_date DESC";
        List<Transaction> list = new ArrayList<>();

        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Member member = new Member();
                member.setUsername(rs.getString("member_username"));

                Book book = new Book();
                book.setTitle(rs.getString("book_title"));

                Transaction transaction = new Transaction(
                        rs.getString("transaction_id"),
                        member,
                        book,
                        rs.getDate("borrow_date"),
                        rs.getDate("return_date"),
                        rs.getString("status")
                );
                list.add(transaction);
            }
        }

        return list;
    }

    public List<Transaction> getTransactionsByMember(String username) throws SQLException {
        String query = "SELECT * FROM transactions WHERE member_username = ? ORDER BY borrow_date DESC";
        List<Transaction> list = new ArrayList<>();

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Member member = new Member();
                    member.setUsername(rs.getString("member_username"));

                    Book book = new Book();
                    book.setTitle(rs.getString("book_title"));

                    Transaction transaction = new Transaction(
                            rs.getString("transaction_id"),
                            member,
                            book,
                            rs.getDate("borrow_date"),
                            rs.getDate("return_date"),
                            rs.getString("status")
                    );
                    list.add(transaction);
                }
            }
        }

        return list;
    }

    public boolean updateReturnDate(String transactionId, Date returnDate, String status) throws SQLException {
        String query = "UPDATE transactions SET return_date = ?, status = ? WHERE transaction_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setDate(1, new java.sql.Date(returnDate.getTime()));
            stmt.setString(2, status);
            stmt.setString(3, transactionId);
            return stmt.executeUpdate() > 0;
        }
    }
}
