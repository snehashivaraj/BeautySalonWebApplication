<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<html>
<head>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <title>Admin Login</title>
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
    	form {
            font-family: 'Poppins', sans-serif;
            max-width: 500px;
            margin: 2em auto;
            background-color: #fff;
            padding: 1em;
            border-radius: 30px;
            box-sizing: border-box;
            box-shadow: 0px 0px 10px 2px rgba(0,0,0,1.9);
        }
        </style>
</head>
<body>
<%
    String admid = request.getParameter("admid");
    String password = request.getParameter("password");

    if (admid != null && password != null) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection blood = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");

            PreparedStatement ps = blood.prepareStatement("SELECT * FROM alogin WHERE admid=? AND password=?");
            ps.setString(1, admid);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                // Removing the duplicate declaration of session
                session.setAttribute("admin id",admid);
                response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Invalid username or password');");
                out.println("location='Alogin.jsp';");
                out.println("</script>");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
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
<h2>Admin Login</h2>
<form action="" method="post">
    Admin id : <input type="text" name="admid"><br>
    Password: <input type="password" name="password"><br>
    <input type="submit" value="Login">
</form>
</body>
</html>
