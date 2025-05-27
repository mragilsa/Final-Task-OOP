<%@ page import="java.util.List" %>
<%@ page import="com.main.app.model.Member" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Library Management System - View Members</title>
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
        <h2 class="text-3xl font-semibold mb-8 text-center text-gray-800">View Members</h2>

        <div class="bg-white rounded-2xl shadow-sm p-8">
            <div class="overflow-x-auto">
                <table class="min-w-full table-auto border border-gray-200 rounded-xl overflow-hidden shadow">
                    <thead class="bg-gray-100 text-gray-700 uppercase text-sm">
                        <tr>
                            <th class="px-6 py-4 text-left">Username</th>
                            <th class="px-6 py-4 text-left">Government ID</th>
                            <th class="px-6 py-4 text-left">Phone Number</th>
                            <th class="px-6 py-4 text-left">Gender</th>
                            <th class="px-6 py-4 text-left">Email</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200 bg-white">
                        <%
                            List<Member> members = (List<Member>) request.getAttribute("members");
                            if (members != null && !members.isEmpty()) {
                                for (Member member : members) {
                        %>
                        <tr class="hover:bg-gray-50 transition">
                            <td class="px-6 py-4"><%= member.getUsername() %></td>
                            <td class="px-6 py-4"><%= member.getGovernmentId() %></td>
                            <td class="px-6 py-4"><%= member.getPhoneNumber() %></td>
                            <td class="px-6 py-4"><%= member.getGender() %></td>
                            <td class="px-6 py-4"><%= member.getEmail() %></td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="5" class="text-center px-6 py-4 text-gray-500">No members found</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>