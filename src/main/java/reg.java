import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class reg extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (firstName.isEmpty() || lastName.isEmpty() || phoneNumber.isEmpty() || email.isEmpty() || password.isEmpty()) {
            response.sendRedirect("reg.jsp?error=Please fill out all fields");
            return;
        }

        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");

            // Check if email already exists
            String checkEmailQuery = "SELECT COUNT(*) FROM reg WHERE email=?";
            preparedStatement = conn.prepareStatement(checkEmailQuery);
            preparedStatement.setString(1, email);
            resultSet = preparedStatement.executeQuery();
            resultSet.next(); // Move to the first row
            int count = resultSet.getInt(1);

            if (count > 0) {
                // Email already exists, display alert message
            	PrintWriter out = response.getWriter();
            	out.println("<script type=\"text/javascript\">");
                out.println("alert('The account in this mail already exist.');");
                out.println("location='Login.jsp';");
                out.println("</script>");
                return;
            }
            String insertQuery = "INSERT INTO reg (first_name, last_name, phone_number, email, password) VALUES (?, ?, ?, ?, ?)";
            preparedStatement = conn.prepareStatement(insertQuery);
            preparedStatement.setString(1, firstName);
            preparedStatement.setString(2, lastName);
            preparedStatement.setString(3, phoneNumber);
            preparedStatement.setString(4, email);
            preparedStatement.setString(5, password);

            int rowsInserted = preparedStatement.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("Login.jsp");
            } else {
                response.sendRedirect("Registration.jsp?error=Registration failed. Please try again.");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            response.sendRedirect("Registration.jsp?error=Registration failed. Please try again.");
            ex.printStackTrace();
        } finally {
            // Close all resources
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
