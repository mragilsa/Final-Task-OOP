<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.main.app.model.Book" %>
<%
    Book book = (Book) request.getAttribute("book");
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Library Management System - Edit Book</title>
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
<body class="bg-gray-100 text-gray-800 min-h-screen flex flex-col">

    <div class="container mx-auto px-6 py-4 flex justify-end">
        <a href="admin-page.jsp" class="btn-member" title="Back to Admin Page">
            <!-- Arrow Left Icon -->
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
            </svg>
            Back to Admin
        </a>
    </div>

    <main class="flex-grow container mx-auto px-6 py-6 max-w-xl">
        <div class="bg-white rounded-2xl shadow-sm p-8 transition">
            <h2 class="text-3xl font-semibold mb-8 text-center text-gray-800 flex items-center justify-center gap-3">
                Edit Book
            </h2>

            <form action="editBook" method="post" class="space-y-6">
                <input type="hidden" name="id" value="<%= book.getId() %>">

                <input
                    type="text"
                    name="title"
                    value="<%= book.getTitle() %>"
                    placeholder="Book Title"
                    required
                    autofocus
                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-600 transition duration-150"
                />
                <input
                    type="text"
                    name="author"
                    value="<%= book.getAuthor() %>"
                    placeholder="Author"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-600 transition duration-150"
                />
                <input
                    type="number"
                    name="year"
                    value="<%= book.getYear() %>"
                    placeholder="Publication Year"
                    min="1000"
                    max="2099"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-600 transition duration-150"
                />
                <input
                    type="number"
                    name="stock"
                    value="<%= book.getStock() %>"
                    placeholder="Stock"
                    min="0"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-600 transition duration-150"
                />

                <div class="flex justify-between items-center pt-4">
                    <button
                        type="submit"
                        class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-xl transition"
                    >
                        Update
                    </button>
                </div>
            </form>
        </div>
    </main>

</body>
</html>