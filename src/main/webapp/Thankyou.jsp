<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Appointment Details</title>
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <style>
    	h1{
            color: pink;
            text-align: center; /* Center align the text */
            margin: 2em auto; /* Center the element horizontally and add some margin */
            max-width: 400px; /* Limit the width of the element */
            padding: 0.5em; /* Add padding */
            border-radius: 2px 40px; /* Optional border-radius for rounded corners */
            display: block; /* Ensures that it takes the full width available */
        }
    	form {
    		font-family: 'Poppins', sans-serif;
            max-width: 500px;
            margin: 2em auto;
            background-color: rgb(0,0,3,0.1);
            padding: 1em;
            border-radius: 30px;
            box-sizing: border-box;
            box-shadow: 0px 0px 10px 2px rgba(0,0,0,);
        }
        button {
  			background-color: #04AA6D; /* Green */
  			border: none;
  			color: white;
  			padding: 15px 32px;
  			text-align: center;
  			text-decoration: none;
  			display: inline-block;
  			font-size: 16px;
		}
        
      </style>
</head>
<body>
    <h1> Thanks for visiting...... </h1>
    
    <form action="Homel.jsp" method="post">
    	<h2> Booking details </h2>
        <!-- Replace input fields with fetched appointment details -->
        <% 
            // Define your database connection parameters
            String dbURL = "jdbc:mysql://localhost:3306/salon";
            String dbUser = "root";
            String dbPassword = "root";

            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a database connection
            Connection conn = null;
            try {
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if(conn != null) {
                // Fetch data from the database
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    stmt = conn.createStatement();
                    String sql = "SELECT tokenid, name, email, phone, service, date, time, msg FROM appo ORDER BY tokenid DESC LIMIT 1";
                    rs = stmt.executeQuery(sql);
                    
                    // Display the fetched data within the form
                    if (rs.next()) {
                        int tokenId = rs.getInt("tokenid");
                        String name = rs.getString("name");
                        String email = rs.getString("email");
                        String phonenumber = rs.getString("phone");
                        String services = rs.getString("service");
                        String date = rs.getString("date");
                        String time = rs.getString("time");
                        String msg = rs.getString("msg");
        %>
        <!-- Display appointment details within the form -->
        Token ID: <%= tokenId %><br>
        Name: <%= name %><br>
        Email: <%= email %><br>
        Phone Number: <%= phonenumber %><br>
        Services: <%= services %><br>
        Date: <%= date %><br>
        Time: <%= time %><br>
        Message: <%= msg %><br>
        <%  
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    // Close the resources
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
      <button>  Ok </button>      
    </form>
</body>
</html>
