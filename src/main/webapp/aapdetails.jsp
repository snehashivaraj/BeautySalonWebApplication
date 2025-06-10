<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Beauty Salon Appointment Form</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background-image: url('images/adminback.jpg');
            background-size: 100%;
            background-attachment: scroll;
        }
        label {
            font-weight: bold;
        }
        .appointment-form {
            font-family: 'Poppins', sans-serif;
            max-width: 500px;
            margin: 2em auto;
            background-color: #fff;
            padding: 1em;
            border-radius: 30px;
            box-sizing: border-box;
            box-shadow: 0px 0px 10px 2px rgba(0,0,0,1.9);
        }
        table {
            background-color: ghostwhite;
        }
        section {
            padding: 2em;
            background-color: rgb(0,1,0,0.3);
        }
        nav {
            padding: 1em;
            text-align: right; /* Align navigation items to the right */
        }
        nav a {
            color: #fff;
            text-decoration: none;
            padding: 0.2em 0.5em;
            margin: 0.1em;
            border-radius: 10px 1px;
            background-color: #444; /* Background color only till text */
            display: inline-block; /* Display as inline-block to apply background only to the text */
        }
        h2 {
            color: blue;
            text-align: center; /* Center align the text */
            margin: 2em auto; /* Center the element horizontally and add some margin */
            /* Limit the width of the element */
            padding: 0.5em; /* Add padding */
            /* Optional border-radius for rounded corners */
            display: block; /* Set to inline-block to only cover the width of the text */
            box-shadow: 1px 4px whitesmoke;
            background-color: rgb(1,1,1,0.2);
            font-size: 40px;
        }
        h3 {
            text-align: center; /* Center align the text */
            margin: 2em auto; /* Center the element horizontally and add some margin */
            max-width: 400px; /* Limit the width of the element */
            padding: 0.5em; /* Add padding */
            font-size: 30px;
        }
        .billing-form {
            display: inline; /* Ensure the billing form styles do not affect the main form */
        }
        .billing-form button {
            margin-top: 0; /* Adjust margin if needed */
            padding: 5px 10px; /* Adjust padding if needed */
        }
    </style>
</head>
<body>
<nav>
    <a href="appadd.jsp">Update Services </a>
    <a href="dashboard.jsp"> Dashboard </a>
    <a href="Home.jsp"> Logout </a>
</nav>
    <div class="container mt-5">
        <h2> Appointment Details </h2>
        <form class="appointment-form" action="" method="get">
            <div class="form-group">
                <label for="tokenId">Enter Token ID:</label>
                <input type="text" class="form-control" id="tokenId" name="tokenId" required>
            </div>
            <button type="submit" class="btn btn-primary"> Search </button>
        </form>
        <% 
        String tokenId = request.getParameter("tokenId");
        if (tokenId != null && !tokenId.isEmpty()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM appo WHERE tokenid = ?");
                pstmt.setString(1, tokenId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) { 
                    %>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Token Id</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone Number</th>
                                <th>Service</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Message</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><%= rs.getString("tokenid") %></td>
                                <td><%= rs.getString("name") %></td>
                                <td><%= rs.getString("email") %></td>
                                <td><%= rs.getString("phone") %></td>
                                <td><%= rs.getString("service") %></td>
                                <td><%= rs.getString("date") %></td>
                                <td><%= rs.getString("time") %></td>
                                <td><%= rs.getString("msg") %></td>
                                <td><%= rs.getString("status") %></td>
                                <td>  <button type="button" class="btn btn-info" onclick="completeAppointment('<%= rs.getString("tokenid") %>')">Complete</button> </td>
                                <td>
                                    <form class="billing-form" action="Ret.jsp" method="post">
                                        <input type="hidden" name="token_id" value="<%= rs.getString("tokenid") %>">
                                        <button type="submit" class="btn btn-info">Bill Generate</button>
                                    </form>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <% 
                } else {
                    out.println("<p>No appointment found for token ID: " + tokenId + "</p>");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
        %>
    </div>

    <!-- JavaScript to redirect to billing.jsp -->
    <script>
        function redirectToBilling() {
            window.location.href = "Ret.jsp";
        }
        function completeAppointment(tokenId) {
            if (confirm("Are you sure you want to mark this appointment as completed?")) {
                <% 
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");
                    PreparedStatement pstmt = conn.prepareStatement("UPDATE appo SET status = 'completed' WHERE tokenid = ?");
                    pstmt.setString(1, tokenId);
                    int rowsUpdated = pstmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.println("alert('Appointment marked as completed.');");
                        out.println("window.location.reload();");
                    } else {
                        out.println("alert('Failed to update appointment status.');");
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                    out.println("alert('Error occurred while updating appointment status.');");
                }
                %>
            }
        }
    </script>
</body>
</html>
