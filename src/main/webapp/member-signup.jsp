<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Library Management System - Member Signup</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet" />
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        dosis: ['Dosis', 'sans-serif'],
                    }
                }
            }
        }
    </script>
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
                Join our digital library today. Sign up as a member to borrow books, track your history, and manage your reading.
            </p>
            <ul class="mt-8 space-y-2 font-medium text-white text-lg">
                <li class="flex items-center gap-3">
                    → Easy online book access
                </li>
                <li class="flex items-center gap-3">
                    → Personalized member dashboard
                </li>
                <li class="flex items-center gap-3">
                    → Secure and fast registration
                </li>
            </ul>
        </div>

        <div class="flex flex-col justify-center px-6 sm:px-12 py-12">
            <h2 class="text-3xl font-bold mb-6 text-gray-800 text-center">Member Signup</h2>

            <form action="member-signup" method="post" class="space-y-6">
                <div>
                    <label for="username" class="block mb-2 text-sm font-medium">Username</label>
                    <input type="text" id="username" name="username" required
                        class="w-full py-3 px-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition"
                        placeholder="Enter your username" />
                </div>

                <div>
                    <label for="governmentId" class="block mb-2 text-sm font-medium">Government ID</label>
                    <input type="text" id="governmentId" name="governmentId" required
                        class="w-full py-3 px-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition"
                        placeholder="e.g., ID12345678" />
                </div>

                <div>
                    <label for="phoneNumber" class="block mb-2 text-sm font-medium">Phone Number</label>
                    <input type="number" id="phoneNumber" name="phoneNumber" required
                        class="w-full py-3 px-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition"
                        placeholder="e.g., 08123456789" />
                </div>

                <div>
                    <label for="gender" class="block mb-2 text-sm font-medium">Gender</label>
                    <select id="gender" name="gender" required
                        class="w-full py-3 px-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition">
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                    </select>
                </div>

                <div>
                    <label for="email" class="block mb-2 text-sm font-medium">Email</label>
                    <input type="email" id="email" name="email" required
                        class="w-full py-3 px-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition"
                        placeholder="you@example.com" />
                </div>

                <div>
                    <label for="password" class="block mb-2 text-sm font-medium">Password</label>
                    <input type="password" id="password" name="password" required
                        class="w-full py-3 px-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition"
                        placeholder="Create a strong password" />
                </div>

                <button type="submit"
                    class="w-full py-3 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-semibold transition duration-300">
                    Signup
                </button>
            </form>

            <div class="text-md text-center mt-6 text-gray-500">
                <span>Already have an account? </span><a href="member-login.jsp"
                    class="hover:underline text-blue-600 font-medium">Login Here</a>
            </div>
        </div>
    </div>

</body>

</html>