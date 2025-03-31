package code.Servlets;


import code.Renting;
import code.dataAccessObjects.EmployeeDAO;
import code.dataAccessObjects.RentingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/ViewEmployeeRentingServlet")
public class ViewEmployeeRentingServlet extends HttpServlet{

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve employeeID from the request or session
        String employeeID = request.getParameter("employeeID");

        if (employeeID == null || employeeID.isEmpty()) {
            response.sendRedirect("error.jsp?message=Employee ID is missing");
            return;
        }


        // Use EmployeeDAO to get renting for the employee's hotel
        List<Renting> rentings = RentingDAO.getRentingsForEmployee(employeeID);


        if (rentings != null && !rentings.isEmpty()) {

            request.setAttribute("rentings", rentings);


            request.getRequestDispatcher("/view-rentings-employee.jsp").forward(request, response);
        } else {
            System.out.println("empty null");

            request.getRequestDispatcher("/view-rentings-employee.jsp").forward(request, response);
        }
    }
}
