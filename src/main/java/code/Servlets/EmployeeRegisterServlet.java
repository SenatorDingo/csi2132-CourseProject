package code.Servlets;

import code.Employee;
import code.dataAccessObjects.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/EmployeeRegisterServlet")
public class EmployeeRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = java.util.UUID.randomUUID().toString();
        String sin = request.getParameter("sin");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String middleInitials = request.getParameter("middleInitials");
        String address = request.getParameter("address");
        String role = request.getParameter("role");


        Employee employee = new Employee(id, sin, firstName, lastName, middleInitials, address, role);


        boolean success = EmployeeDAO.addEmployee(employee);

        if (success) {

            response.sendRedirect("search.jsp");
        } else {
            
            response.sendRedirect("booking-failure.jsp");
        }
    }
}
