<%@ page import="java.util.*, com.main.app.model.Book, com.main.app.dao.BookDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<Book> books = new ArrayList<>();
    try {
        BookDAO dao = new BookDAO();
        books = dao.getAllBooks();
        request.setAttribute("books", books);
    } catch (Exception e) {
        out.println("Failed to fetch data: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Library Management System - Admin Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Dosis', sans-serif;
        }
        table {
            font-size: 1.125rem;
        }
        th, td {
            vertical-align: middle;
        }
        .action-links a {
            font-size: 1.125rem;
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
        <a href="member-login.jsp" class="btn-member" title="Switch to Member">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" >
                <path stroke-linejoin="round" stroke-linecap="round" d="M17 16l4-4m0 0l-4-4m4 4H7" />
                <path stroke-linejoin="round" stroke-linecap="round" d="M7 16v1a2 2 0 002 2h6a2 2 0 002-2v-1" />
            </svg>
            Switch to Member
        </a>
    </div>

    <main class="container mx-auto px-6 py-6">
        <h2 class="text-3xl font-semibold mb-8 text-center text-gray-800">Admin Dashboard</h2>

        <div class="bg-white rounded-2xl shadow-sm p-8">
            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
                <a href="add-book.jsp" class="bg-blue-600 hover:bg-blue-700 text-white text-center py-3 rounded-xl shadow-md transition">Add Book</a>
                <a href="return-book?action=view_all" class="bg-green-600 hover:bg-green-700 text-white text-center py-3 rounded-xl shadow-md transition">View Transactions</a>
                <a href="member-view" class="bg-indigo-600 hover:bg-indigo-700 text-white text-center py-3 rounded-xl shadow-md transition">View Members</a>
            </div>

            <div class="overflow-x-auto">
                <table class="min-w-full table-auto border border-gray-200 rounded-xl overflow-hidden shadow">
                    <thead class="bg-gray-100 text-gray-700 uppercase text-sm">
                        <tr>
                            <th class="px-6 py-4 text-left">Title</th>
                            <th class="px-6 py-4 text-left">Author</th>
                            <th class="px-6 py-4 text-left">Year</th>
                            <th class="px-6 py-4 text-left">Stock</th>
                            <th class="px-6 py-4 text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200 bg-white">
                        <c:forEach var="book" items="${books}">
                            <tr class="hover:bg-gray-50 transition">
                                <td class="px-6 py-4">${book.title}</td>
                                <td class="px-6 py-4">${book.author}</td>
                                <td class="px-6 py-4">${book.year}</td>
                                <td class="px-6 py-4">
                                    <span class="inline-block px-3 py-1 rounded-full bg-blue-100 text-blue-700 text-sm font-semibold">${book.stock}</span>
                                </td>
                                <td class="px-6 py-4 flex gap-6 justify-center action-links">
                                    <a href="editBook?id=${book.id}" class="text-blue-600 hover:underline">Edit</a>
                                    <a href="deleteBook?id=${book.id}" class="text-red-600 hover:underline"
                                       onclick="return confirm('Are you sure you want to delete this book?');">
                                        Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>