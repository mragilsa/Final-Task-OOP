<%@ page import="java.util.List" %>
<%@ page import="com.main.app.model.Transaction" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>

<%
    java.sql.Date sqlToday = new java.sql.Date(System.currentTimeMillis());
    LocalDate today = sqlToday.toLocalDate();
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet">
    <title>Return Book</title>
    <script>
        function confirmReturn(transactionId, bookId) {
            if (confirm("Are you sure you want to return this book?")) {
                window.location.href = "return-book-action?transactionId=" + transactionId + "&bookId=" + bookId;
            }
        }
    </script>
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
        
        <div class="button-group">
            <a href="member-page.jsp" class="btn btn-success">Back to Member Page</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Title</th>
                    <th>Borrow Date</th>
                    <th>Return Date</th>
                    <th>Duration (days)</th>
                    <th>Fine</th>
                    <th>Return</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Transaction> borrowedBooks = (List<Transaction>) request.getAttribute("borrowed_books");
                    if (borrowedBooks != null && !borrowedBooks.isEmpty()) {
                        for (Transaction t : borrowedBooks) {
                            LocalDate borrowDate = t.getBorrowDate().toLocalDate();
                            LocalDate returnDate = t.getReturnDate().toLocalDate();
                            long daysBetween = ChronoUnit.DAYS.between(borrowDate, today);
                            
                            long fine = 0;
                            if (daysBetween > t.getDuration()) {
                                fine = (daysBetween - t.getDuration()) * 2; // 2 USD per day
                            }
                            String fineStatus = fine == 0 ? "0 USD" : fine + " USD";
                %>
                <tr>
                    <td><%= t.getBookId() %></td>
                    <td><%= t.getBookTitle() %></td>
                    <td><%= t.getBorrowDate() %></td>
                    <td><%= t.getReturnDate() %></td>
                    <td><%= t.getDuration() %></td>
                    <td><%= fineStatus %></td>
                    <td>
                        <a href="return-book?action=return&transactionId=<%= t.getTransactionId() %>&bookId=<%= t.getBookId() %>" onclick="return confirm('Are you sure you want to return this book?')">Return</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7">There are no books currently on loan.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </main>
</body>
</html>