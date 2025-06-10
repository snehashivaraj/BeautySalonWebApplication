import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Forgot extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Forgot() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		String url = "jdbc:mysql://localhost:3306/salon";
	    String user = "root";
	    String dbpassword = "root";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(url, user, dbpassword);
			String sql = "UPDATE reg SET password = ? WHERE email = ?";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, password);
			statement.setString(2, email);
			statement.executeUpdate();
			response.sendRedirect("Login.jsp");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}