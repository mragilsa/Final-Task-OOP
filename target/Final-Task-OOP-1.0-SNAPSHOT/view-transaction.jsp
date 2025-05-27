<%@ page import="java.util.List" %>
<%@ page import="com.main.app.model.Transaction" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    java.sql.Date sqlToday = new java.sql.Date(System.currentTimeMillis());
    LocalDate today = sqlToday.toLocalDate();

    List<Transaction> borrowedBooks = (List<Transaction>) request.getAttribute("borrowed_books");
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8" />
    <title>Library Management System - View Transactions</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Dosis', sans-serif;
        }
        th, td {
            vertical-align: middle;
        }
        .btn-member {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background-color: transparent;
            color: #2563eb;
            font-weight: 600;
            font-size: 1rem;
            padding: 0.4rem 0.6rem;
            border-radius: 0.5rem;
            border: none;
            cursor: pointer;
            transition: background-color 0.2s ease;
            text-decoration: none;
        }
        .btn-member:hover {
            background-color: rgba(37, 99, 235, 0.1);
        }
        .btn-member svg {
            width: 20px;
            height: 20px;
            stroke-width: 2;
        }
    </style>
</head>
<body class="bg-gray-100 text-gray-800">

    <div class="container mx-auto px-6 py-4 flex justify-end">
        <a href="admin-page.jsp" class="btn-member" title="Back to Admin Login">
            <!-- Arrow Left Icon -->
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
            </svg>
            Back to Admin
        </a>
    </div>

    <main class="container mx-auto px-6 py-6">
        <h2 class="text-3xl font-semibold mb-8 text-center text-gray-800">View Transactions</h2>

        <div class="bg-white rounded-2xl shadow-sm p-8">
            <div class="overflow-x-auto">
                <table class="min-w-full table-auto border border-gray-200 rounded-xl overflow-hidden shadow">
                    <thead class="bg-gray-100 text-gray-700 uppercase text-sm">
                        <tr>
                            <th class="px-6 py-4 text-left">Title</th>
                            <th class="px-6 py-4 text-left">Username</th>
                            <th class="px-6 py-4 text-left">Borrow Date</th>
                            <th class="px-6 py-4 text-left">Return Date</th>
                            <th class="px-6 py-4 text-left">Duration (days)</th>
                            <th class="px-6 py-4 text-left">Fine</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200 bg-white">
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
                        <tr class="hover:bg-gray-50 transition">
                            <td class="px-6 py-4"><%= t.getBookTitle() %></td>
                            <td class="px-6 py-4"><%= t.getUsername() %></td>
                            <td class="px-6 py-4"><%= t.getBorrowDate() %></td>
                            <td class="px-6 py-4"><%= t.getReturnDate() %></td>
                            <td class="px-6 py-4"><%= t.getDuration() %></td>
                            <td class="px-6 py-4 font-semibold <%= fine > 0 ? "text-red-600" : "text-green-600" %>">
                                <%= fine == 0 ? "0 USD" : fine + " USD" %>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center py-6 text-gray-500">There are no books currently on loan.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>