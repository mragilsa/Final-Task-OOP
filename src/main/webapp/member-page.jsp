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
        out.println("Failed to retrieve data: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Library Management System - Member Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Dosis', sans-serif;
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
        <a href="admin-login.jsp" class="btn-member" title="Switch to Admin">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" d="M7 8l-4 4m0 0l4 4m-4-4h14" />
            </svg>
            Switch to Admin
        </a>
    </div>

    <main class="container mx-auto px-6 py-6">
        <h2 class="text-3xl font-semibold mb-8 text-center text-gray-800">Member Page</h2>

        <div class="bg-white rounded-2xl shadow-sm p-8">
            <div class="w-full mb-6">
                <a href="return-book" class="block w-full bg-blue-600 hover:bg-blue-700 text-white py-3 text-center font-semibold rounded-lg transition shadow">
                    Return Book
                </a>
            </div>

            <div class="overflow-x-auto">
                <table class="min-w-full table-auto border border-gray-200 rounded-xl overflow-hidden shadow">
                    <thead class="bg-gray-100 text-gray-700 uppercase text-sm">
                        <tr>
                            <th class="px-6 py-4 text-left">Title</th>
                            <th class="px-6 py-4 text-left">Author</th>
                            <th class="px-6 py-4 text-left">Year</th>
                            <th class="px-6 py-4 text-left">Stock</th>
                            <th class="px-6 py-4 text-center">Borrow</th>
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
                                <td class="px-6 py-4 text-center">
                                    <a href="borrow-book.jsp?bookId=${book.id}" class="text-green-600 hover:underline font-semibold">Borrow</a>
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