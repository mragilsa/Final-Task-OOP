// File: com/main/app/interfaces/Manageable.java
package com.main.app.interfaces;

import com.main.app.model.Book;
import java.sql.SQLException;
import java.util.List;

public interface Manageable {
    void addBook(Book book) throws SQLException;
    void editBook(Book book) throws SQLException;
    void deleteBook(int bookId) throws SQLException;
    Book getBookById(int bookId) throws SQLException;
    List<Book> getAllBooks() throws SQLException;
}