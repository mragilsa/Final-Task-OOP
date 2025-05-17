package com.main.app.dao;

import com.main.app.model.Book;
import java.sql.*;
import java.util.*;

public class BookDAO {

    private final Connection connection;

    public BookDAO(Connection connection) {
        this.connection = connection;
    }

    public void addBook(Book book) throws SQLException {
        String sql = "INSERT INTO books (id, title, author, year, stock) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, book.getId());
        stmt.setString(2, book.getTitle());
        stmt.setString(3, book.getAuthor());
        stmt.setString(4, book.getYear());
        stmt.setInt(5, book.getStock());
        stmt.executeUpdate();
    }

    public List<Book> getAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Book book = new Book(
                        rs.getString("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("year"),
                        rs.getInt("stock")
                );
                books.add(book);
            }
        }
        return books;
    }

    public Book getBookById(String id) throws SQLException {
        String sql = "SELECT * FROM books WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Book(
                            rs.getString("id"),
                            rs.getString("title"),
                            rs.getString("author"),
                            rs.getString("year"),
                            rs.getInt("stock")
                    );
                } else {
                    return null; // Data gak ketemu
                }
            }
        }
    }

    public Book getBookByTitle(String title) throws SQLException {
        String query = "SELECT * FROM books WHERE title = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, title);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Book(
                            rs.getString("id"),
                            rs.getString("title"),
                            rs.getString("author"),
                            rs.getString("year"),
                            rs.getInt("stock")
                    );
                }
            }
        }
        return null;
    }

    public void updateBook(Book book, String oldId) throws SQLException {
        String sql = "UPDATE books SET id = ?, title = ?, author = ?, year = ?, stock = ? WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, book.getId());     // new ID
        stmt.setString(2, book.getTitle());
        stmt.setString(3, book.getAuthor());
        stmt.setString(4, book.getYear());
        stmt.setInt(5, book.getStock());
        stmt.setString(6, oldId);            // old ID
        stmt.executeUpdate();
    }

    public boolean reduceStock(String bookId) throws SQLException {
        String sql = "UPDATE books SET stock = stock - 1 WHERE id = ? AND stock > 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, bookId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        }
    }

    public void deleteBook(String id) throws SQLException {
        String sql = "DELETE FROM books WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, id);
            stmt.executeUpdate();
        }
    }
}
