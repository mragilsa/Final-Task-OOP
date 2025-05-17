<%@ page import="java.util.*, java.sql.Connection" %>
<%@ page import="com.main.app.model.Transaction, com.main.app.dao.TransactionDAO, com.main.app.db.DatabaseConnection" %>
<%
    List<Transaction> transactions = new ArrayList<>();
    try {
        Connection conn = DatabaseConnection.getConnection(); 
        TransactionDAO dao = new TransactionDAO(conn);                      
        transactions = dao.getAllTransactions();                            
        request.setAttribute("transactions", transactions);
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
    <title>Library Management System - View All Transactions</title>
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
    <h2>Transactions Page</h2>

    <div class="button-group">
        <a href="admin-page" class="btn btn-primary">Admin Page</a>
    </div>

    <table>
        <thead>
        <tr>
            <th>Transaction ID</th>
            <th>Member Username</th>
            <th>Book Title</th>
            <th>Borrow Date</th>
            <th>Return Date</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="trx" items="${transactions}">
            <tr>
                <td>${trx.id}</td>
                <td>${trx.member.username}</td>
                <td>${trx.book.title}</td>
                <td>${trx.borrowDate}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty trx.returnDate}">
                            ${trx.returnDate}
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <td>${trx.status}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</main>
</body>
</html>
