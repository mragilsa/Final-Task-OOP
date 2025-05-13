<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.main.app.model.Book" %>
<%
    Book book = (Book) request.getAttribute("book");
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet">
    <title>Library Management System - Edit Book</title>
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
    <h2>Edit Book Page</h2>
    <form action="editBook" method="post" class="form">
        <input type="hidden" name="id" value="<%= book.getId() %>">
        <div class="input-form">
            <input type="text" name="title" value="<%= book.getTitle() %>" placeholder="Title" required><br>
            <input type="text" name="author" value="<%= book.getAuthor() %>" placeholder="Author" required><br>
            <input type="number" name="year" value="<%= book.getYear() %>" placeholder="Year" required><br>
            <input type="number" name="stock" value="<%= book.getStock() %>" placeholder="Stock" required><br>
        </div>
        <div class="form-actions">
            <button type="submit">Update</button>
            <a href="admin-page.jsp" class="cancel-link">Back to Admin Page</a>
        </div>
    </form>
</main>
</body>
</html>