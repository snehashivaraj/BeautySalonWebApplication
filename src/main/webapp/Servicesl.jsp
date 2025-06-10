<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<html>
<head>
    <title>Our Services</title>
    <style>
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
        nav {
            padding: 1em;
            text-align: right; /* Align navigation items to the right */
        }
        body {
            background-image: url(images/background.jpg);
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #9a90f5;
            background-size: 100%;
            background-attachment: fixed;
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
        h1 {
            font-size: 4em; /* Font size */
            font-family: "Times New Roman", Times, serif; /* Change font family */
            font-style: italic; /* Change font style */
            text-shadow: 2px 1px pink;
        }

        h2 {
            color: ghostwhite;
            text-align: center; /* Center align the text */
            margin: 2em auto; /* Center the element horizontally and add some margin */
            max-width: 400px; /* Limit the width of the element */
            padding: 0.5em; /* Add padding */
            background-color: lightgray; /* Background color for the <h2> */
            /* Optional border-radius for rounded corners */
            display: block; /* Set to inline-block to only cover the width of the text */
            box-shadow: 1px 4px darkmagenta;
        }
        h3 {
            text-align: center;
            border-bottom: 1px solid #ccc;
            padding-bottom: 10px;
            margin-bottom: 20px;
            cursor: pointer; /* Add cursor pointer */
        }

        ol { 
            list-style: none;
            padding: 0;
            margin: 0;
            
        }

        li {
            margin-bottom: 10px;
            background-color: skyblue;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        footer {
            text-align: center;
            padding: 20px;
            background-color: #f0f0f0;
        }
        .line-break {
            display: block; /* Display as block to force line break */
            margin-right: 5em; 
        }
        .hidden { /* Add a class for hiding the list */
            display: none;
        }
        .dropdown {
            display: none;
            padding: 10px;
            background-color: white;
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .dropdown-item {
            cursor: pointer;
        }
        main {
            background-color: white;
            padding: 20px;
            margin-top: 100px; /* Ensure it doesn't overlap with header */
        }
    </style>
    <script>
        function toggleServices(category) {
            var dropdown = document.getElementById(category + "-dropdown");
            if (dropdown.style.display === "none") {
                dropdown.style.display = "block";
            } else {
                dropdown.style.display = "none";
            }
        }
    </script>
</head>
<body>
    <header>
        <nav>
            <a href="contactl.jsp"> Need Help</a>
            <a href="Homel.jsp"> Home </a>
        </nav>
    </header>
    <main>
        <ol>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");

                    // Fetching data for categories
                    PreparedStatement categoryStmt = connection.prepareStatement("SELECT * FROM category");
                    ResultSet categoryResultSet = categoryStmt.executeQuery();

                    // Iterate over categories
                    while (categoryResultSet.next()) {
                        String categoryName = categoryResultSet.getString("category_name");
            %>
                        <li onclick="toggleServices('<%= categoryName %>')"><%= categoryName %></li>
                        <div id="<%= categoryName %>-dropdown" class="dropdown">
                            <% // Fetching data for services of the current category
                            PreparedStatement serviceStmt = connection.prepareStatement("SELECT * FROM serv WHERE cid = ?");
                            serviceStmt.setInt(1, categoryResultSet.getInt("cid"));
                            ResultSet serviceResultSet = serviceStmt.executeQuery();

                            // Iterate over services of the current category
                            while (serviceResultSet.next()) { %>
                                <div class="dropdown-item">
                                    <%= serviceResultSet.getString("serv_name") %> - <%= serviceResultSet.getDouble("price") %>
                                </div>
                            <% }
                            // Close service statement and result set
                            serviceResultSet.close();
                            serviceStmt.close(); %>
                        </div>
            <%          }
                    // Close category statement and result set
                    categoryResultSet.close();
                    categoryStmt.close();

                    // Close connection
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </ol>
    </main>
</body>
</html>
