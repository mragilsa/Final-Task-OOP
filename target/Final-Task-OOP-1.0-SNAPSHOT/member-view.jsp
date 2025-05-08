<%@ page import="java.util.List" %>
<%@ page import="com.main.app.model.Member" %>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;600&display=swap" rel="stylesheet">
    <title>Library Management System - Admin Page</title>
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
        <h2>View Members</h2>

        <table>
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Government ID</th>
                    <th>Phone Number</th>
                    <th>Gender</th>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Member> members = (List<Member>) request.getAttribute("members");
                    if (members != null && !members.isEmpty()) {
                        for (Member member : members) {
                %>
                <tr>
                    <td><%= member.getUsername() %></td>
                    <td><%= member.getGovernmentId() %></td>
                    <td><%= member.getPhoneNumber() %></td>
                    <td><%= member.getGender() %></td>
                    <td><%= member.getEmail() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5">No members found</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </main>
</body>
</html>