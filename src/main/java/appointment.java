import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class appointment extends HttpServlet {

    // Method to insert appointment information into the database
    private void insertAppointment(String name, String email, String phoneNumber, String[] services, String date, String time, String message, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Establish database connection (replace connection details with yours)
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");
            conn.setAutoCommit(true); // Ensure autocommit is enabled

            // SQL query to check the number of appointments for the given date and time
            String checkQuery = "SELECT COUNT(*) FROM appo WHERE date = ? AND time = ?";
            ps = conn.prepareStatement(checkQuery);
            ps.setString(1, date);
            ps.setString(2, time);

            rs = ps.executeQuery();
            int existingAppointments = 0;
            if (rs.next()) {
                existingAppointments = rs.getInt(1);
            }

            if (existingAppointments < 2) {
                // Proceed with inserting the new appointment
                String query = "INSERT INTO appo (name, email, phone, service, date, time, msg) VALUES (?, ?, ?, ?, ?, ?, ?)";
                ps = conn.prepareStatement(query);

                // Set parameters for the query
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, phoneNumber);

                // Concatenate selected services into a single string
                StringBuilder selectedServices = new StringBuilder();
                for (String service : services) {
                    selectedServices.append(service).append(", ");
                }
                // Remove the trailing comma and space
                if (selectedServices.length() > 0) {
                    selectedServices.delete(selectedServices.length() - 2, selectedServices.length());
                }
                ps.setString(4, selectedServices.toString());

                ps.setString(5, date);
                ps.setString(6, time);
                ps.setString(7, message);

                // Execute the insert query
                ps.executeUpdate();
                
                // Redirect to thank you page
                response.sendRedirect("Thankyou.jsp");
            } else {
                // Set error message in request attribute
                request.setAttribute("errorMessage", "Selected time slot is full. Please choose another time..");
                // Forward back to the JSP page
                request.getRequestDispatcher("Appointment.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Print stack trace for debugging
            throw new RuntimeException("Error inserting appointment into database", e);
        } finally {
            // Close the ResultSet, PreparedStatement, and Connection objects
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Print stack trace for debugging
            }
        }
    }

    // Handle POST requests
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone");
        String[] services = request.getParameterValues("services");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String message = request.getParameter("message");

        // Insert appointment information into the database
        insertAppointment(name, email, phoneNumber, services, date, time, message, request, response);
    }
}
