package code.Servlets;

import code.dataAccessObjects.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DeleteBookingServlet")
public class DeleteBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingID = request.getParameter("bookingID");
        String employeeID = request.getParameter("employeeID");


        boolean isDeleted = BookingDAO.deleteBooking(bookingID);

        if (isDeleted) {

            response.sendRedirect("ViewBookingEmployeeServlet?employeeID=" + employeeID);

        } else {

            request.setAttribute("errorMessage", "Failed to delete the booking.");
            request.getRequestDispatcher("booking-failure.jsp").forward(request, response);
        }
    }
}
