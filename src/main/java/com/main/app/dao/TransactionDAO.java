package com.main.app.dao;

import com.main.app.model.Transaction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {
    private Connection conn;

    public TransactionDAO(Connection conn) {
        this.conn = conn;
    }

    // Menambahkan transaksi peminjaman buku
    public boolean insertTransaction(Transaction tx) throws SQLException {
        String insertSQL = "INSERT INTO borrowed_books (username, book_id, borrow_date, return_date, duration) VALUES (?, ?, ?, ?, ?)";
        String updateStockSQL = "UPDATE books SET stock = stock - 1 WHERE id = ? AND stock > 0";

        try (
            PreparedStatement updateStockStmt = conn.prepareStatement(updateStockSQL);
            PreparedStatement insertStmt = conn.prepareStatement(insertSQL)
        ) {
            // Update stok buku
            updateStockStmt.setInt(1, tx.getBookId());
            int affectedRows = updateStockStmt.executeUpdate();

            if (affectedRows == 0) {
                return false;  // Jika stok 0, peminjaman gagal
            }

            // Simpan data peminjaman
            insertStmt.setString(1, tx.getUsername());
            insertStmt.setInt(2, tx.getBookId());
            insertStmt.setDate(3, tx.getBorrowDate());
            insertStmt.setDate(4, tx.getReturnDate());
            insertStmt.setInt(5, tx.getDuration());

            return insertStmt.executeUpdate() > 0;
        }
    }
    
    public List<Transaction> getTransactionsByUsername(String username) throws SQLException {
        String query = "SELECT bb.transaction_id, bb.username, bb.book_id, b.title, bb.borrow_date, bb.return_date, bb.duration " +
                       "FROM borrowed_books bb " +
                       "JOIN books b ON bb.book_id = b.id " +
                       "WHERE bb.username = ?";

        List<Transaction> list = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Menambahkan bookTitle untuk memasukkan data judul buku
                    Transaction tx = new Transaction(
                        rs.getInt("transaction_id"),
                        rs.getString("username"),
                        rs.getInt("book_id"),
                        rs.getString("title"),  // Menambahkan judul buku
                        rs.getDate("borrow_date"),
                        rs.getDate("return_date"),
                        rs.getInt("duration")
                    );
                    list.add(tx);
                }
            }
        }
        return list;
    }

    // Method untuk menghapus transaksi (saat pengembalian buku)
    public boolean deleteTransaction(int transactionId) throws SQLException {
        String query = "DELETE FROM borrowed_books WHERE transaction_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, transactionId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Method untuk menambah stock buku setelah dikembalikan
    public boolean increaseBookStock(int bookId) throws SQLException {
        String query = "UPDATE books SET stock = stock + 1 WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, bookId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public List<Transaction> getAllTransactions() throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT bb.transaction_id, bb.username, bb.book_id, b.title, bb.borrow_date, bb.return_date, bb.duration " +
                     "FROM borrowed_books bb " +
                     "JOIN books b ON bb.book_id = b.id";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Transaction t = new Transaction(
                    rs.getInt("transaction_id"),
                    rs.getString("username"),
                    rs.getInt("book_id"),
                    rs.getString("title"), // book title dari tabel books
                    rs.getDate("borrow_date"),
                    rs.getDate("return_date"),
                    rs.getInt("duration")
                );
                transactions.add(t);
            }
        }
        return transactions;
    }
    
}