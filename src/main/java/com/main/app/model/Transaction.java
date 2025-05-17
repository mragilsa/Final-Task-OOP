/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.main.app.model;
import java.util.Date;

import java.util.Date;

public class Transaction {
   private String id;
    private Member member;
    private Book book;
    private Date borrowDate;
    private Date returnDate;
    private String status;

    public Transaction() {}

    public Transaction(String id, Member member, Book book, Date borrowDate, Date returnDate, String status) {
        this.id = id;
        this.member = member;
        this.book = book;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void getDetails() {
        System.out.println("Transaction ID: " + id);
        System.out.println("Member: " + member.getUsername());
        System.out.println("Book: " + book.getTitle());
        System.out.println("Borrow Date: " + borrowDate);
        System.out.println("Return Date: " + returnDate);
        System.out.println("Status: " + status);
    }
    
}
