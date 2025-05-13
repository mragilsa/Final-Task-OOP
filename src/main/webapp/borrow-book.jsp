<%@ page import="java.util.*, java.sql.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Ambil parameter dan validasi
    String message = request.getParameter("message") != null ? request.getParameter("message") : "";
    String bookIdParam = request.getParameter("bookId");
    boolean bookIdValid = bookIdParam != null && !bookIdParam.isEmpty();
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pinjam Buku - Library Management System</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles.css">
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
    <h2>Borrow Book Page</h2>

    <% if (!bookIdValid) { %>
        <div class="form-message">
            <p><strong>Book ID not found. Please return to the previous page.</strong></p>
            <a href="member-page.jsp" class="cancel-link">Back to Member Page</a>
        </div>
    <% } else { %>
        <form method="post" action="borrow-book" class="form">
            <input type="hidden" name="bookId" value="<%= bookIdParam %>">

            <div class="input-form">
                <label for="duration">Select loan duration:</label>
                <select name="duration" id="duration" required>
                    <option value="7">7 Day</option>
                    <option value="14">14 Day</option>
                    <option value="30">30 Day</option>
                </select>
            </div>

            <div class="form-actions">
                <button type="submit">Loan Confirmation</button>
                <a href="member-page.jsp" class="cancel-link">Back to Member Page</a>
            </div>

            <% if (!message.isEmpty()) { %>
                <div class="form-message">
                    <p><strong><%= message %></strong></p>
                </div>
            <% } %>
        </form>
    <% } %>
</main>
</body>
</html>