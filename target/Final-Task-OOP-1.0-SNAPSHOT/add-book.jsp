<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet">
    <title>Library Management System - Add Book</title>
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
        <h2>Add Book Page</h2>
        <form action="addBook" method="post" class="form">
            <div class="input-form">
                <input type="text" name="title" placeholder="Title" required><br>
                <input type="text" name="author" placeholder="Author" required><br>
                <input type="number" name="year" placeholder="Year" required><br>
                <input type="number" name="stock" placeholder="Stock" required><br>
            </div>
            <div class="form-actions">
                <button type="submit">Save</button>
                <a href="admin-page.jsp" class="cancel-link">Back to Admin Page</a>
            </div>
        </form>
    </main>
</body>
</html>