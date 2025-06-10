<%@ page import="java.util.Enumeration" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.StringTokenizer" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Billing Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 400px;
        }
        h2 {
            color: #333;
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        input[type="text"] {
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
        }
        input[type="submit"], input[type="button"] {
            padding: 10px 20px;
            margin: 10px 0;
            border: none;
            border-radius: 4px;
            background-color: #5cb85c;
            color: white;
            cursor: pointer;
        }
        input[type="submit"]:hover, input[type="button"]:hover {
            background-color: #4cae4c;
        }
        h3 {
            color: #555;
            margin: 10px 0 5px;
        }
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .result {
            margin-top: 20px;
        }
        .error, .message {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
    		String tokenId = request.getParameter("token_id");
    		if (tokenId == null || tokenId.isEmpty()) {
        		out.println("<p class='error'>Token ID not provided.</p>");
    		} else {
                Connection conn = null;
                PreparedStatement psAppo = null;
                PreparedStatement psCategory = null;
                PreparedStatement psServices = null;
                ResultSet rsAppo = null;
                ResultSet rsCategory = null;
                ResultSet rsServices = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver"); // Adjust according to your JDBC driver
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");

                    // Fetch services from appo table
                    String queryAppo = "SELECT service FROM appo WHERE tokenid = ?";
                    psAppo = conn.prepareStatement(queryAppo);
                    psAppo.setString(1, tokenId);
                    rsAppo = psAppo.executeQuery();

                    if (rsAppo.next()) {
                        String servicesString = rsAppo.getString("service");

                        // Split the services string into individual service names
                        String[] serviceNames = servicesString.split(",\\s*");

                        // Map to hold category and its services
                        Map<String, List<String[]>> categoryServicesMap = new HashMap<>();

                        for (String serviceName : serviceNames) {
                            // Fetch cid and category_name from category table
                            String queryCategory = "SELECT cid, category_name FROM category WHERE category_name = ?";
                            psCategory = conn.prepareStatement(queryCategory);
                            psCategory.setString(1, serviceName);
                            rsCategory = psCategory.executeQuery();

                            if (rsCategory.next()) {
                                int cid = rsCategory.getInt("cid");
                                String categoryName = rsCategory.getString("category_name");

                                // Fetch services from serv table
                                String queryServices = "SELECT * FROM serv WHERE cid = ?";
                                psServices = conn.prepareStatement(queryServices);
                                psServices.setInt(1, cid);
                                rsServices = psServices.executeQuery();

                                List<String[]> servicesList = new ArrayList<>();
                                while (rsServices.next()) {
                                    String[] serviceDetails = new String[3];
                                    serviceDetails[0] = String.valueOf(rsServices.getInt("sid"));
                                    serviceDetails[1] = rsServices.getString("serv_name");
                                    serviceDetails[2] = rsServices.getString("price");
                                    servicesList.add(serviceDetails);
                                }

                                // Add the services list to the category
                                categoryServicesMap.put(categoryName, servicesList);
                            } else {
                                out.println("<p class='error'>Category not found for the service: " + serviceName + "</p>");
                            }
                        }

                        if (!categoryServicesMap.isEmpty()) {
                            double totalPrice = 0.0;
                            out.println("<div class='result'><h2>Services for Token ID: " + tokenId + "</h2>");
                            out.println("<form method='post' action=''>");
                            out.println("<input type='hidden' name='token_id' value='" + tokenId + "'>");

                            for (Map.Entry<String, List<String[]>> entry : categoryServicesMap.entrySet()) {
                                String categoryName = entry.getKey();
                                List<String[]> services = entry.getValue();

                                out.println("<h3>" + categoryName + "</h3>");
                                out.println("<select name='selected_services'>");

                                for (String[] service : services) {
                                    out.println("<option value='" + service[2] + "'>" + service[1] + " - $" + service[2] + "</option>");
                                }

                                out.println("</select>");
                            }

                            out.println("<br>");
                            out.println("<input type='submit' value='Calculate Total'>");
                            out.println("</form>");

                            // Processing form submission
                            if ("POST".equalsIgnoreCase(request.getMethod())) {
                                String[] selectedServices = request.getParameterValues("selected_services");
                                if (selectedServices != null) {
                                    for (String priceStr : selectedServices) {
                                        try {
                                            double price = Double.parseDouble(priceStr);
                                            totalPrice += price;
                                        } catch (NumberFormatException e) {
                                            // Handle invalid price input
                                            out.println("<p class='error'>Invalid price: " + priceStr + "</p>");
                                        }
                                    }
                                    out.println("<h3>Total Price: $" + totalPrice + "</h3></div>");
                                } else {
                                    out.println("<p class='message'>No services selected.</p></div>");
                                }
                            }
                        } else {
                            out.println("<p class='message'>No services found for the given token ID.</p>");
                        }
                    } else {
                        out.println("<p class='message'>Invalid token ID.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace(new PrintWriter(out));
                } finally {
                    try {
                        if (rsAppo != null) rsAppo.close();
                        if (rsCategory != null) rsCategory.close();
                        if (rsServices != null) rsServices.close();
                        if (psAppo != null) psAppo.close();
                        if (psCategory != null) psCategory.close();
                        if (psServices != null) psServices.close();
                        if (conn != null) conn.close();
                    } catch (Exception e) {
                        out.println("<p class='error'>Error closing resources: " + e.getMessage() + "</p>");
                        e.printStackTrace(new PrintWriter(out));
                    }
                }
            }
        %>
    </div>
</body>
</html>
