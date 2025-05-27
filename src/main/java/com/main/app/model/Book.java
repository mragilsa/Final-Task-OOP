package com.main.app.model;

public class Book {

    private int id;
    private String title;
    private String author;
    private int year;
    private int stock;

    public Book(int id, String title, String author, int year, int stock) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.year = year;
        this.stock = stock;
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }
    
    public void setAuthor(String author) {
        this.author = author;
    }

    public int getYear() {
        return year;
    }
    
    public void setYear(int year) {
        this.year = year;
    }

    public int getStock() {
        return stock;
    }
}