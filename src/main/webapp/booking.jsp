<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Get the user's email from the session
    HttpSession session1 = request.getSession();
    String userEmail = (String) session1.getAttribute("email");

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/salon";
    String user = "root";
    String password = "root";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    // Create a list to store appointment details
    List<Map<String, String>> appointments = new ArrayList<>();
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT tokenid, date, time FROM appo WHERE email = ? ORDER BY date DESC, time DESC";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userEmail);
        rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, String> appointment = new HashMap<>();
            appointment.put("tokenid", rs.getString("tokenid"));
            appointment.put("date", rs.getString("date"));
            appointment.put("time", rs.getString("time"));
            appointments.add(appointment);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Appointment Details</title>
    <style>
        div {
            font-family: 'Poppins', sans-serif;
            width: 80%;
            margin: 2em auto;
            background-color: #fff;
            padding: 1em;
            border-radius: 30px;
            box-sizing: border-box;
            box-shadow: 0px 0px 10px 2px rgba(0,0,0,1.9);
        }
        body{
    		background-image: url('images/back3.jpg');
    		background-size:100%;
    		background-attachment: scrool;
        }
         nav {
            padding: 1em;
            text-align: right; /* Align navigation items to the right */
            }
        nav a {
            color: white;
            text-decoration: none;
            padding: 0.2em 0.5em;
            margin: 0.1em;
            border-radius: 10px 1px;
            background-color: #444; /* Background color only till text */
            display: inline-block; /* Display as inline-block to apply background only to the text */
        }
        nav a:hover {
    		color: pink; /* Reset the color to inherit from the parent */
    /* Optionally, you can also reset any other styles that may be applied */
		}
        </style>
</head>
<body>
	<header>
		<nav>
            <a href="Homel.jsp"> Back </a>
        </nav>
     </header>
 <div>
        <h1>Appointment Details</h1>
        <% for (Map<String, String> appointment : appointments) { %>
            <p><strong>Token ID:</strong> <%= appointment.get("tokenid") %></p>
            <p><strong>Date:</strong> <%= appointment.get("date") %></p>
            <p><strong>Time:</strong> <%= appointment.get("time") %></p>
            <hr>
        <% } %>
  </div>
</body>
</html>
