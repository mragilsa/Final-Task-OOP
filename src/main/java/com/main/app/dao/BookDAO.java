package com.main.app.dao;

import com.main.app.model.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/oop_db";  // DB URL
    private static final String DB_USER = "root";  // DB username
    private static final String DB_PASSWORD = "";  // DB password

    // Method to add a book to the database
    public void addBook(String title, String author, int year, int stock) throws SQLException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(
                 "INSERT INTO books (title, author, year, stock) VALUES (?, ?, ?, ?)")) {

            stmt.setString(1, title);
            stmt.setString(2, author);
            stmt.setInt(3, year);
            stmt.setInt(4, stock);
            stmt.executeUpdate();
        }
    }

    // Method to get all books from the database
    public List<Book> getAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();

        String sql = "SELECT * FROM books";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Book book = new Book(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getInt("year"),
                        rs.getInt("stock")
                );
                books.add(book);
            }
        }

        return books;
    }
    
    // Method to update a book in the database
    public void updateBook(int id, String title, String author, int year, int stock) throws SQLException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE books SET title = ?, author = ?, year = ?, stock = ? WHERE id = ?")) {

            stmt.setString(1, title);
            stmt.setString(2, author);
            stmt.setInt(3, year);
            stmt.setInt(4, stock);
            stmt.setInt(5, id);

            stmt.executeUpdate();
        }
    }

    // Optional: Get a book by ID (useful for pre-filling form)
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
    
    public void deleteBook(int id) throws SQLException {
        String sql = "DELETE FROM books WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
    
    public void incrementStock(int bookId) throws SQLException {
        String sql = "UPDATE books SET stock = stock + 1 WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            stmt.executeUpdate();
        }
    }
    
    public void deleteBorrowRecord(int bookId) throws Exception {
        String sql = "DELETE FROM borrowed_books WHERE book_id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            stmt.executeUpdate();
        }
    }
}