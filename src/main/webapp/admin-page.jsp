<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet">
    <title>Library Management System - Admin Page</title>
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
        <h2>Admin Page</h2>

        <div class="button-group">
            <a href="add-book.jsp" class="btn btn-primary">Add Book</a>
            <a href="view-transaction.jsp" class="btn btn-success">View Transaction</a>
            <a href="member-view" class="btn btn-info">View Member</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Book Id</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Year</th>
                    <th>Stock</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>001</td>
                    <td>Atomic Habits</td>
                    <td>James Clear</td>
                    <td>2018</td>
                    <td>100</td>
                    <td><a href="#">Edit</a></td>
                    <td><a href="#" style="color:red;">Delete</a></td>
                </tr>
                <tr>
                    <td>002</td>
                    <td>Tiny Habits</td>
                    <td>BJ Fogg PhD</td>
                    <td>2021</td>
                    <td>100</td>
                    <td><a href="#">Edit</a></td>
                    <td><a href="#" style="color:red;">Delete</a></td>
                </tr>
            </tbody>
        </table>
    </main>
</body>
</html>