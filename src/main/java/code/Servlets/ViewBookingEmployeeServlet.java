package code.Servlets;

import code.Booking;
import code.dataAccessObjects.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/ViewBookingEmployeeServlet")
public class ViewBookingEmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve employeeID from the request or session
        String employeeID = request.getParameter("employeeID");

        if (employeeID == null || employeeID.isEmpty()) {
            response.sendRedirect("error.jsp?message=Employee ID is missing");
            return;
        }

        System.out.println("Employee ID: " + employeeID);

        // Use EmployeeDAO to get bookings for the employee's hotel
        List<Booking> bookings = EmployeeDAO.getBookingsForEmployee(employeeID);

        if (bookings != null && !bookings.isEmpty()) {
            // Pass the bookings list as a request attribute to the JSP
            request.setAttribute("bookings", bookings);

            // Forward to the JSP page for displaying bookings
            request.getRequestDispatcher("/view-bookings-employee.jsp").forward(request, response);
        } else {
            // Redirect if no bookings are found
            response.sendRedirect("no-bookings.jsp");
        }
    }
}
