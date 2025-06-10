import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class contact extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String msg = request.getParameter("message");
        
        if (name.isEmpty() || email.isEmpty() || msg.isEmpty()) {
            response.sendRedirect("Contact.jsp?error=Please fill out all fields");
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");

            String sql = "INSERT INTO contact (name, email, msg) VALUES (?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, msg);

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                // Set success status in query parameter and redirect to Contact.jsp
                response.sendRedirect("Home.jsp?success=1");
            } else {
                response.sendRedirect("Contact.jsp?error=Registration failed. Please try again.");
            }

            conn.close();
        } catch (ClassNotFoundException | SQLException ex) {
            response.sendRedirect("Contact.jsp?error=Registration failed. Please try again.");
            ex.printStackTrace();
        }
    }
}
