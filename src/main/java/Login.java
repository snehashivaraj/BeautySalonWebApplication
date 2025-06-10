import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet(
		"/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**2
     * 
     *  
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
        String password = request.getParameter("password");

          
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection blood = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "root");

            PreparedStatement ps = blood.prepareStatement("SELECT * FROM reg WHERE email=? AND password=?");
            ps.setString(1, email);

            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
            	  HttpSession session = request.getSession();
                  session.setAttribute("email",email);
                  response.sendRedirect(request.getContextPath() + "/Homel.jsp");
            } else {
                PrintWriter out = response.getWriter();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Invalid username or password');");
                out.println("location='Login.jsp';");
                out.println("</script>");
            }

            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
	}

}
