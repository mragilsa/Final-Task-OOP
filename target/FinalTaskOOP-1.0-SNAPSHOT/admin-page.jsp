<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/styles.css">
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
                <a href="books?mode=add" class="btn btn-primary">Add Book</a>
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
                    <c:forEach var="book" items="${books}">
                        <tr>
                            <td>${book.id}</td>
                            <td>${book.title}</td>
                            <td>${book.author}</td>
                            <td>${book.year}</td>
                            <td>${book.stock}</td>
                            <td>
                                <a href="books?mode=edit&id=${book.id}&title=${book.title}&author=${book.author}&year=${book.year}&stock=${book.stock}">
                                    Edit
                                </a>
                            </td>
                            <td>
                                <a href="books?mode=delete&id=${book.id}" style="color:red;" onclick="return confirm('Are you sure you want to delete this book?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
        <script>
            var success = '${success}';
            if (success === 'add') {
                alert('Book successfully added!');
            } else if (success === 'edit') {
                alert('Book successfully updated!');
            } else if (success === 'delete') {
                alert('Book successfully deleted!');
            }
        </script>

        <c:if test="${param.mode == 'add' || param.mode == 'edit'}">
            <jsp:include page="bookForm-popup.jsp"/>
        </c:if>


    </body>
</html>