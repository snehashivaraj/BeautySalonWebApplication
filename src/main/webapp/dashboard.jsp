<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
     body{
     		background-image:url('images/adminback1.jpeg');
     		background-size: 100%;
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
    		max-width: 400px; /* Limit the width of the element */
    		padding: 0.5em; /* Add padding */
    		border-radius: 2px 40px; /* Optional border-radius for rounded corners */
    		display: block; /* Set to inline-block to only cover the width of the text */
    		box-shadow: 1px 4px whitesmoke;
    		background-color: rgb(1,1,1,0.2);
    		font-size: 40px;
    	}
    	h3{
    		text-align: center; /* Center align the text */
    		margin: 2em auto; /* Center the element horizontally and add some margin */
    		max-width: 400px; /* Limit the width of the element */
    		padding: 0.5em; /* Add padding */
    		font-size:30px;
    		}
        </style>
</head>

<body>
<%
    // Get admin name from the database based on admin ID
    String adminID = (String) session.getAttribute("admid");
    String admName = " ";

    if (adminID != null) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");

            // Query to fetch admin name based on admin ID
            String query = "SELECT admname FROM alogin WHERE admid = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, adminID);
            rs = stmt.executeQuery();

            // If admin name found, set it
            if (rs.next()) {
                admName = rs.getString("admname");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
%>
<nav>
	<a href="appadd.jsp">Update Services </a>
	<a href="aapdetails.jsp">Appointment Details </a>
	<a href="Home.jsp"> Logout </a>
</nav>
<h2> Dashboard </h2>
<section>
<h3>Welcome, <%= admName %>!</h3>
</section>

</body>
</html>
