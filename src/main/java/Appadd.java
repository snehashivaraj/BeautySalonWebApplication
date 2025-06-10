import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Appadd extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addCategoryAndService(request, response);
        } else if ("remove".equals(action)) {
            removeCategoryAndService(request, response);
        } else if ("update".equals(action)) {
            updateServicePrice(request, response);
        }
    }

    private void addCategoryAndService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");
        String serviceName = request.getParameter("serviceName");
        double price = Double.parseDouble(request.getParameter("price"));

        if (categoryName == null || categoryName.isEmpty() || serviceName == null || serviceName.isEmpty()) {
            response.sendRedirect("appadd.jsp?error=Please fill out all fields");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");

            // Check if the category already exists
            String checkCategoryQuery = "SELECT * FROM category WHERE category_name = ?";
            PreparedStatement checkCategoryStatement = conn.prepareStatement(checkCategoryQuery);
            checkCategoryStatement.setString(1, categoryName);
            ResultSet categoryResultSet = checkCategoryStatement.executeQuery();

            int categoryId;
            if (!categoryResultSet.next()) {
                // If the category does not exist, insert it into the category table
                String insertCategoryQuery = "INSERT INTO category (category_name) VALUES (?)";
                PreparedStatement insertCategoryStatement = conn.prepareStatement(insertCategoryQuery, PreparedStatement.RETURN_GENERATED_KEYS);
                insertCategoryStatement.setString(1, categoryName);
                insertCategoryStatement.executeUpdate();

                ResultSet generatedKeys = insertCategoryStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    categoryId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Failed to get the generated category ID.");
                }
            } else {
                categoryId = categoryResultSet.getInt("cid");
            }

            // Insert the service into the serv table
            String insertServiceQuery = "INSERT INTO serv (cid, serv_name, price) VALUES (?, ?, ?)";
            PreparedStatement insertServiceStatement = conn.prepareStatement(insertServiceQuery);
            insertServiceStatement.setInt(1, categoryId);
            insertServiceStatement.setString(2, serviceName);
            insertServiceStatement.setDouble(3, price);
            insertServiceStatement.executeUpdate();

            response.sendRedirect("dashboard.jsp?message=Category and service added successfully!");

            conn.close();
        } catch (ClassNotFoundException | SQLException ex) {
            response.sendRedirect("appadd.jsp?error=Failed to add category and service. Please try again.");
            ex.printStackTrace();
        }
    }

    private void removeCategoryAndService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");
        String serviceName = request.getParameter("serviceName");

        if (categoryName == null || categoryName.isEmpty() || serviceName == null || serviceName.isEmpty()) {
            response.sendRedirect("appadd.jsp?error=Please provide both category name and service name");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");

            // Get category ID
            String getCategoryIDQuery = "SELECT cid FROM category WHERE category_name = ?";
            PreparedStatement getCategoryIDStatement = conn.prepareStatement(getCategoryIDQuery);
            getCategoryIDStatement.setString(1, categoryName);
            ResultSet categoryResultSet = getCategoryIDStatement.executeQuery();

            int categoryId;
            if (categoryResultSet.next()) {
                categoryId = categoryResultSet.getInt("cid");

                // Delete service
                String deleteServiceQuery = "DELETE FROM serv WHERE cid = ? AND serv_name = ?";
                PreparedStatement deleteServiceStatement = conn.prepareStatement(deleteServiceQuery);
                deleteServiceStatement.setInt(1, categoryId);
                deleteServiceStatement.setString(2, serviceName);
                int rowsAffected = deleteServiceStatement.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("dashboard.jsp?message=Service removed successfully!");
                } else {
                    response.sendRedirect("appadd.jsp?error=Service not found for the specified category and service name");
                }
            } else {
                response.sendRedirect("appadd.jsp?error=Category not found");
            }

            conn.close();
        } catch (ClassNotFoundException | SQLException ex) {
            response.sendRedirect("appadd.jsp?error=Failed to remove service. Please try again.");
            ex.printStackTrace();
        }
    }

    private void updateServicePrice(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String serviceName = request.getParameter("serviceName");
        double newPrice = Double.parseDouble(request.getParameter("newPrice"));

        if (serviceName == null || serviceName.isEmpty()) {
            response.sendRedirect("appadd.jsp?error=Please provide the service name");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");

            // Update the price of the service
            String updatePriceQuery = "UPDATE serv SET price = ? WHERE serv_name = ?";
            PreparedStatement updatePriceStatement = conn.prepareStatement(updatePriceQuery);
            updatePriceStatement.setDouble(1, newPrice);
            updatePriceStatement.setString(2, serviceName);
            int rowsAffected = updatePriceStatement.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("dashboard.jsp?message=Service price updated successfully!");
            } else {
                response.sendRedirect("appadd.jsp?error=Service not found for the specified service name");
            }

            conn.close();
        } catch (ClassNotFoundException | SQLException ex) {
            response.sendRedirect("appadd.jsp?error=Failed to update service price. Please try again.");
            ex.printStackTrace();
        }
    }
}
