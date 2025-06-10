<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Beauty Salon Appointment Form</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            padding: 20px;
            background-image: url('images/background.jpg');
            background-size: 100%;
            background-attachment: scroll;
        }
        form {
            font-family: 'Poppins', sans-serif;
            max-width: 600px;
            margin: 2em auto;
            background-color: #fff;
            padding: 1em;
            border-radius: 30px;
            box-sizing: border-box;
            box-shadow: 0px 0px 10px 2px rgba(0,0,0,1.9);
        }
        display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            padding-top: 60px;
        }
        /* Modal content */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 70%; /* Could be more or less, depending on screen size */
        }
        /* Close button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        header {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            color: darkmagenta;
            text-align: center;
            padding: 0.5em;
            z-index: 2; /* Ensure the header is above the carousel */
            display: flex;
            justify-content: space-between; /* Align items horizontally */
            align-items: center; /* Align items vertically */
        }
        h1 {
            font-size:4em; /* Font size */
            font-family: "Times New Roman", Times, serif; /* Change font family */
            font-style: italic; /* Change font style */
            text-shadow: 2px 1px pink;
       }
       .line-break {
            display: block; /* Display as block to force line break */
            margin-right: 5em; 
        }
        dropdown-menu-up {
            top: auto;
            bottom: 100%;
        }

        h2 {
            color: ghostwhite;
            text-align: center; /* Center align the text */
            margin: 2em auto; /* Center the element horizontally and add some margin */
            max-width: 400px; /* Limit the width of the element */
            padding: 0.5em; /* Add padding */
            background-color: #333; /* Background color for the <h2> */
            border-radius: 2px 40px; /* Optional border-radius for rounded corners */
            display: block; /* Ensures that it takes the full width available */
            box-shadow: 1px 4px whitesmoke;
        }
        }
        .services {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .service {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 1em;
            margin: 1em;
            width: 30%;
            box-sizing: border-box;
            background-color: #fff;
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
        nav a:hover {
                background-color: aliceblue;
        }
        .dropdown-menu-up {
            top: auto;
            bottom: 100%;
        }
        label {
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="date"], input[type="time"], select, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            height: 100px;
        }
        input[type="submit"] {
            background-color: darkmagenta;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #8b008b;
        }
        button {
            background-color:royalblue;
            color: #fff;
            border: none;
            padding: 0.5em 1em;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            width:100%;
            box-sizing: border-box;
        }
        button:hover {
            background-color: #555;
        }
        .dropdown-menu {
            background-color: #444;
            color: #fff;
        }
    </style>
</head>
<body>
    <header>
        <h1>Classy<span class="line-break"></span>Salon </h1>
        <nav>
            <a href="Servicesl.jsp">Services</a>
            <a href="Homel.jsp"> Home </a>
            <a href="Contact.jsp"> Contact </a>
        </nav>
    </header>
    <div class="container mt-5">
    <h2 class="mb-4">Appointment</h2>

    <form action="appointment" method="post">
        <div class="form-group">
        <label for="name">Full Name:</label>
        <input type="text" class="form-control" id="name" name="name" oninput="this.value = this.value.replace(/[^a-zA-Z\s]/g, '')" required>
    </div>

     <div class="form-group">
        <label for="email">Email:</label>
         <input type="email" class="form-control" id="email" name="email" value="<%= session.getAttribute("email") %>" disabled>
          <input type="hidden" name="email" value="<%= session.getAttribute("email") %>">
    </div>

     <div class="form-group">
    <label for="phone">Phone Number:</label>
        <input type="text" class="form-control" id="phone" name="phone" maxlength="10" oninput="this.value=this.value.replace(/[^0-9]/g,'')" required>
    </div>

<div class="form-group">
        <label for="services">Select Service:</label><br>
        <% 
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Establish a connection to the database
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");

                // Query to fetch services from the database
                String query = "SELECT category_name FROM category";
                PreparedStatement ps = conn.prepareStatement(query);
                ResultSet rs = ps.executeQuery();

                // Iterate over the fetched services and generate checkboxes
                while (rs.next()) {
                    String serviceName = rs.getString("category_name");
        %>
        <input type="checkbox" id="<%= serviceName %>" name="services" value="<%= serviceName %>">
        <label for="<%= serviceName %>"><%= serviceName %></label><br>
        <%
                }
                rs.close();
                ps.close();
                conn.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
    <div class="form-group">
        <label for="date">Date:</label>
        <input type="date" class="form-control"id="date" name="date" required>
    </div>

        <label for="time">Time:</label> 
        <select id="time" name="time" required>
            <option value="">Select Time</option>
            <!-- Predefined time slots -->
            <option value="10:00 AM">10:00 AM</option>
            <option value="11:00 AM">11:00 AM</option>
            <option value="12:00 PM">12:00 PM</option>
            <option value="01:00 PM">01:00 PM</option>
            <option value="03:00 PM">03:00 PM</option>
            <option value="04:00 PM">04:00 PM</option>
            <option value="05:00 PM">05:00 PM</option>
            <option value="06:00 PM">06:00 PM</option>
            <option value="07:00 PM">07:00 PM</option>
            <option value="08:00 PM">08:00 PM</option>
            <!-- Add more options as needed -->
        </select>

    <div class="form-group">
        <label for="message">Message (optional):</label>
        <textarea id="message" class="form-control" name="message"></textarea>
    </div>
    <div class="button-container">
        <button type="submit" class="btn btn-primary">Submit</button>
    </div>
    </form>
     <% 
        // Display the error message if it exists
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) { 
    %>
        <div id="myModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <p><%= errorMessage %></p>
            </div>
        </div>
        <script>
            // JavaScript function to display modal dialog
            function showModal() {
                document.getElementById('myModal').style.display = 'block';
            }
            // JavaScript function to close modal dialog
            function closeModal() {
                document.getElementById('myModal').style.display = 'none';
            }
            // Call JavaScript function to display modal dialog after page load
            window.onload = function() {
                showModal();
            };
        </script>
    <% } %>
    </div>
    
</body>
</html>

