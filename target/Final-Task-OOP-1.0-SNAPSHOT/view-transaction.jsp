<%@ page import="java.util.List" %>
<%@ page import="com.main.app.model.Transaction" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>

<%
    java.sql.Date sqlToday = new java.sql.Date(System.currentTimeMillis());
    LocalDate today = sqlToday.toLocalDate();

    List<Transaction> borrowedBooks = (List<Transaction>) request.getAttribute("borrowed_books");
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet">
    <title>Return Book</title>
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
        <h2>View Transaction</h2>
        
        <div class="button-group">
            <a href="admin-page.jsp" class="btn btn-success">Back to Admin Page</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Title</th>
                    <th>Username</th>
                    <th>Borrow Date</th>
                    <th>Return Date</th>
                    <th>Duration (days)</th>
                    <th>Fine</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (borrowedBooks != null && !borrowedBooks.isEmpty()) {
                        for (Transaction t : borrowedBooks) {
                            LocalDate borrowDate = t.getBorrowDate().toLocalDate();
                            LocalDate returnDate = t.getReturnDate().toLocalDate();
                            long daysBetween = ChronoUnit.DAYS.between(borrowDate, today);

                            long fine = 0;
                            if (daysBetween > t.getDuration()) {
                                fine = (daysBetween - t.getDuration()) * 2; // 2 USD per hari keterlambatan
                            }
                %>
                <tr>
                    <td><%= t.getBookId() %></td>
                    <td><%= t.getBookTitle() %></td>
                    <td><%= t.getUsername() %></td>
                    <td><%= t.getBorrowDate() %></td>
                    <td><%= t.getReturnDate() %></td>
                    <td><%= t.getDuration() %></td>
                    <td><%= fine == 0 ? "0 USD" : fine + " USD" %></td>
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