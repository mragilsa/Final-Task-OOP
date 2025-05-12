/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.main.app.dao;


import com.main.app.model.Book;
import java.sql.*;
import java.util.*;

/**
 *
 * @author Farriz
 */
public class BookDAO {
    private final Connection connection;
    
    public BookDAO(Connection connection) {
        this.connection = connection;
    }
    
    public void addBook(Book book) throws SQLException {
        String sql = "INSERT INTO books (title, author, year, stock) values (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getYear());
            stmt.setInt(4, book.getStock());
            stmt.executeUpdate();
        }
    }
    
    public List<Book> getAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * from books";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Book book = new Book (
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
        String sql = "SELECT * FROM books where id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
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
    
    public void UpdateBook(Book book) throws SQLException {
        String sql = "UPDATE books SET title= ?, author = ?, year = ?, stock = ?, WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getYear());
            stmt.setInt(4, book.getStock());
            stmt.setString(5,book.getId());
            stmt.executeUpdate();
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

