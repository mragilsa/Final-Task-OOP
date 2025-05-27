package com.main.app.model;

import java.sql.Date;

public class Transaction {
    private int transactionId;
    private String username;
    private int bookId;
    private String bookTitle; 
    private Date borrowDate;
    private Date returnDate;
    private int duration;

    public Transaction() {}

    public Transaction(String username, int bookId, Date borrowDate, Date returnDate, int duration) {
        this.username = username;
        this.bookId = bookId;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.duration = duration;
    }

    public Transaction(int transactionId, String username, int bookId, Date borrowDate, Date returnDate, int duration) {
        this.transactionId = transactionId;
        this.username = username;
        this.bookId = bookId;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.duration = duration;
    }
    
    public Transaction(int transactionId, String username, int bookId, String bookTitle, Date borrowDate, Date returnDate, int duration) {
        this.transactionId = transactionId;
        this.username = username;
        this.bookId = bookId;
        this.bookTitle = bookTitle;  // Mengisi bookTitle
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.duration = duration;
    }
    
    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public int getTransactionId() { return transactionId; }
    public String getUsername() { return username; }
    public int getBookId() { return bookId; }
    public Date getBorrowDate() { return borrowDate; }
    public Date getReturnDate() { return returnDate; }
    public int getDuration() { return duration; }

    public void setTransactionId(int transactionId) { this.transactionId = transactionId; }
    public void setUsername(String username) { this.username = username; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    public void setBorrowDate(Date borrowDate) { this.borrowDate = borrowDate; }
    public void setReturnDate(Date returnDate) { this.returnDate = returnDate; }
    public void setDuration(int duration) { this.duration = duration; }
}