<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/styles.css">       
        <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet">
        <title>Return Book Page - Library Management System</title>
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
            <h2>Return Book Page</h2>

            <c:if test="${not empty errorMessage}">
                <p class="error">${errorMessage}</p>
            </c:if>

            <c:if test="${not empty successMessage}">
                <p class="success">${successMessage}</p>
            </c:if>

            <form action="return-page" method="post">
                <label for="transactionId">Select Book to Return:</label><br>
                <select name="transactionId" id="transactionId" required>
                    <c:forEach var="transaction" items="${transactions}">
                        <option value="${transaction.id}">
                            ${transaction.book.title} — Borrowed on: ${transaction.borrowDate}
                        </option>
                    </c:forEach>
                </select><br>

                <button type="submit">Return Book</button>
                <a href="member-page.jsp" class="cancel-link">Back to Member Page</a>
            </form>
        </main>
    </body>
</html>
