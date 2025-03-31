package code.Servlets;

import code.dataAccessObjects.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/EditBookingsServlet")
public class EditBookingsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeID = request.getParameter("employeeID");
        String bookingID = request.getParameter("bookingID");
        String cin = request.getParameter("checkInDate");
        String cout = request.getParameter("checkOutDate");

        Date checkInDate = Date.valueOf(cin);
        Date checkOutDate = Date.valueOf(cout);

        boolean isUpdated = BookingDAO.updateBooking(bookingID, checkInDate, checkOutDate);
        System.out.println("Is updated" + isUpdated);

        if (isUpdated) {
            response.sendRedirect("ViewBookingEmployeeServlet?employeeID=" + employeeID);

        }
        else{
            request.setAttribute("bookingID", bookingID);
        }



    }

}
