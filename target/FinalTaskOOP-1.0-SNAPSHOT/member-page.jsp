<%@ page import="java.util.*, java.sql.Connection" %>
<%@ page import="com.main.app.model.Book, com.main.app.dao.BookDAO, com.main.app.db.DatabaseConnection" %>
<%
    List<Book> books = new ArrayList<>();
    try {
        Connection conn = DatabaseConnection.getConnection(); 
        BookDAO dao = new BookDAO(conn);                      
        books = dao.getAllBooks();                            
        request.setAttribute("books", books);
    } catch (Exception e) {
        out.println("Gagal mengambil data: " + e.getMessage());
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <title>Library Management System - Member Page</title>
        <link rel="stylesheet" href="<%= request.getContextPath()%>/styles.css">
        <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet">
    </head>
    <body>
        <header>
            <h1>Library Management System</h1>
            <nav>
                <ul>
                    <li><a href="admin-login.jsp">Admin Login</a></li>
                    <li><a href="member-signup.jsp">Member Signup</a></li>
                    <li><a href="member-login.jsp">Member Login</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <h2>Member Page</h2>

            <c:if test="${param.message == 'borrowSuccess'}">
                <div class="alert alert-success">Book borrowed successfully!</div>
            </c:if>

            <c:if test="${param.message == 'returnSuccess'}">
                <div class="alert alert-success">Book returned successfully!</div>
            </c:if>


            <div class="button-group">
                <a href="return-page" class="btn btn-primary">Return Book</a>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Book Id</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Year</th>
                        <th>Stock</th>
                        <th>Borrow</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="book" items="${books}">
                        <tr>
                            <td>${book.id}</td>
                            <td>${book.title}</td>
                            <td>${book.author}</td>
                            <td>${book.year}</td>
                            <td>${book.stock}</td>
                            <td><a href="borrow-page.jsp?bookId=${book.id}">Borrow</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
    </body>
</html>