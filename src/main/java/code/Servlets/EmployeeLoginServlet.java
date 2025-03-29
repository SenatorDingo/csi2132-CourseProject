package code.Servlets;

import code.dataAccessObjects.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/EmployeeLoginServlet")
public class EmployeeLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //getting the data from the front end
        String employeeID = request.getParameter("employeeID");

        EmployeeDAO dao = new EmployeeDAO();

        boolean exists = dao.checkEmployeeExists(employeeID);
        if (exists) {
            response.sendRedirect("CheckIn.jsp");
        } else {
            response.sendRedirect("booking-failure.jsp");
        }
    }
}
