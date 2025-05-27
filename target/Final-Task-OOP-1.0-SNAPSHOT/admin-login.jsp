<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Library Management System - Admin Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Dosis', sans-serif;
        }
    </style>
</head>
<body class="bg-white text-gray-900">

    <div class="min-h-screen grid md:grid-cols-2">

        <div class="bg-blue-600 text-white flex flex-col justify-center px-12 py-20">
            <h1 class="text-4xl font-bold mb-4">Library Management System</h1>
            <p class="text-lg font-medium leading-relaxed">
                Welcome to the digital library management system. Log in as an admin to manage books, members, and loan records.
            </p>
            <ul class="mt-8 space-y-2 font-medium text-white text-lg">
                <li class="flex items-center gap-3">
                    → Easily manage books
                </li>
                <li class="flex items-center gap-3">
                    → Monitor active members
                </li>
                <li class="flex items-center gap-3">
                    → Track borrowing status
                </li>
            </ul>
        </div>

        <div class="flex flex-col justify-center px-6 sm:px-12 py-12">
            <h2 class="text-3xl font-bold mb-6 text-gray-800 text-center">Admin Login</h2>

            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
                <p class="text-red-600 font-semibold mb-4 text-center"><%= errorMessage %></p>
            <% } %>

            <form action="admin-login" method="post" class="space-y-6">
                <div>
                    <label for="username" class="block mb-2 text-sm font-medium">Username</label>
                    <div class="relative">
                        <input type="text" id="username" name="username" required
                            class="w-full py-3 pl-12 pr-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition"
                            placeholder="Enter your username" />
                        <svg class="w-5 h-5 absolute left-4 top-3.5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M5.121 17.804A4 4 0 018 16h8a4 4 0 012.879 1.804M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                        </svg>
                    </div>
                </div>

                <div>
                    <label for="password" class="block mb-2 text-sm font-medium">Password</label>
                    <div class="relative">
                        <input type="password" id="password" name="password" required
                            class="w-full py-3 pl-12 pr-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition"
                            placeholder="Enter your password" />
                        <svg class="w-5 h-5 absolute left-4 top-3.5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M12 11c0-.828-.448-1.5-1-1.5s-1 .672-1 1.5 1 1.5 1 1.5 1-.672 1-1.5zM4 11V9a4 4 0 018 0v2m0 0v2m0 4v1a2 2 0 01-2 2H6a2 2 0 01-2-2v-1m10-6v2m0 0v4" />
                        </svg>
                    </div>
                </div>

                <button type="submit"
                    class="w-full py-3 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-semibold transition duration-300">
                    Login as Admin
                </button>
            </form>
            
            <div class="text-md text-center mt-6 text-gray-500">
                <span>Not an admin? </span><a href="member-login.jsp" class="hover:underline text-blue-600 font-medium">Login as a member</a>
            </div>
        </div>
    </div>

</body>
</html>