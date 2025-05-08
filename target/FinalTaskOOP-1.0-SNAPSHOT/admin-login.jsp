<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles.css">        
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet">
    <title>Library Management System - Admin Login</title>
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
        <h2>Admin Login Form</h2>

        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <p style="color: red; font-weight: bold;"><%= errorMessage %></p>
        <%
            }
        %>

        <form action="admin-login" method="post">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required>
            
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
            
            <button type="submit">Login</button>
        </form>
    </main>
</body>
</html>