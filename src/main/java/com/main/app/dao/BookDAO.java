// File: com/main/app/dao/BookDAO.java
package com.main.app.dao;

import com.main.app.interfaces.Manageable;
import com.main.app.model.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO implements Manageable {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/oop_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    public void addBook(Book book) throws SQLException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO books (title, author, year, stock) VALUES (?, ?, ?, ?)")) {

            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setInt(3, book.getYear());
            stmt.setInt(4, book.getStock());
            stmt.executeUpdate();
        }
    }

    @Override
    public void editBook(Book book) throws SQLException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE books SET title = ?, author = ?, year = ?, stock = ? WHERE id = ?")) {

            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setInt(3, book.getYear());
            stmt.setInt(4, book.getStock());
            stmt.setInt(5, book.getId());
            stmt.executeUpdate();
        }
    }

    @Override
    public void deleteBook(int id) throws SQLException {
        String sql = "DELETE FROM books WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    @Override
    public Book getBookById(int id) throws SQLException {
        Book book = null;
        String sql = "SELECT * FROM books WHERE id = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                book = new Book(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getInt("year"),
                        rs.getInt("stock")
                );
            }
        }
        return book;
    }

    @Override
    public List<Book> getAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                books.add(new Book(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getInt("year"),
                        rs.getInt("stock")
                ));
            }
        }
        return books;
    }

    public void incrementStock(int bookId) throws SQLException {
        String sql = "UPDATE books SET stock = stock + 1 WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            stmt.executeUpdate();
        }
    }

    public void deleteBorrowRecord(int bookId) throws SQLException {
        String sql = "DELETE FROM borrowed_books WHERE book_id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            stmt.executeUpdate();
        }
    }
}