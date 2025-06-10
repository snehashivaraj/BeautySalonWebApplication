<%@ page import="java.sql.*" %>

<%@ page import="javax.servlet.http.*" %>
<%
    // Get the user's email from the session
    HttpSession session1 = request.getSession();
    String userEmail = (String) session.getAttribute("email");

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/salon";
    String user = "root";
    String password = "root";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String tokenid = "";
    String date = "";
    String time = "";
    boolean hasActiveAppointment = false;
    
    try {
    	Class.forName("com.mysql.cj.jdbc.Driver");
    	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");


        stmt = conn.createStatement();
        String sql = "SELECT tokenid, date, time FROM appo WHERE status = 'ACTIVE' AND email = ? ORDER BY date DESC, time DESC LIMIT 1";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userEmail);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            tokenid = rs.getString("tokenid");
            date = rs.getString("date");
            time = rs.getString("time");
            hasActiveAppointment = true;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <style>
    .carousel, .carousel-inner, .item {
      width: 100%;
    }
    .carousel-caption {
    	left: 30%;
    	transform: translateX(-50%);
    	bottom: 190px; /* Adjust this value as needed */
    	text-align: center;
    	 /* Set text color */
    	background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
    	padding: 5px; /* Add padding for better readability */
	}
    
    header {
            position: absolute;
            top: 0;
            left: 0;
            bottom:40em;
            width: 100%;
            color: darkmagenta;
            text-align: center;
            padding: 0.5em;
            z-index: 2; /* Ensure the header is above the carousel */
            display: flex;
            justify-content: space-between; /* Align items horizontally */
            align-items: center; /* Align items vertically */
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
		p {
			font-style: italic;
			font-family: Times;
			font-size: 40px;
			border-radius: 6px 2px;
			position: right;
		}
		h5 {
			background-color: rgb(0.5,1,0.5,0.2);
			font-family: serif;
			z-index:2;
			font-size: 50px;
			font-style: bold;
			font-family: Serif;
			font-size: 60px;
			color: darkgreen;
			border-radius: 6px 2px;
			font-style: obligue;
			text-shadow: 2px 1px pink;
			
			}
	.appointment-details {
     		position: absolute;
     		right: 0;
      		top: 50%;
     		transform: translateY(-50%);
      		width: 20%;
 	     	background-color: rgba(0, 0, 0, 0.5);
      		color: white;
     	 	padding: 20px;
      		border-radius: 10px;
      		z-index: 3;
      		text-align: center;
  	  }
	</style>
</head>
<body>
	<header>
		<nav>
            <a href="Servicesl.jsp">Services</a>
            <a href="contactl.jsp">Contact</a>
            <a href="Home.jsp"> Logout </a>
            <a href="Appointment.jsp"> Appointment </a>
            <a href="booking.jsp"> Recent appointment </a>
        </nav>
    </header>
<div class="container-fluid"> <!-- Change container to container-fluid -->
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <div class="item active">
        <img src="images/beauty1.jpg" alt="Los Angeles" style="width:100%;">
        <div class="carousel-caption d-none d-md-block">
         	<h5> Welcome to VS <br> Beauty Saloon </h5>
         </div>
       </div>
      <div class="item">
        <img src="images/beauty2.jpg" alt="Chicago" style="width:100%;">
      </div>
      <div class="item">
        <img src="images/beauty3.jpg" alt="New york" style="width:100%;">
        	<div class="carousel-caption d-none d-md-block">
         		<p> Indulge in the ultimate escape at our salon, where every visit promises a journey into pure relaxation and rejuvenation.</p>
         	</div>
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>
<div class="appointment-details">
    <% if (hasActiveAppointment) { %>
        <h4> Active Appointment</h4>
        <p>Token ID: <%= tokenid %></p>
        <p>Date: <%= date %></p>
        <p>Time: <%= time %></p>
    <% } else { %>
        <h4>No Appointment</h4>
        <a href="Appointment.jsp"> Book Now </a>
    <% } %>
</div>

</body>
</html>


