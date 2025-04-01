package code.Servlets;

import code.Booking;
import code.Room;
import code.dataAccessObjects.BookingDAO;

import code.dataAccessObjects.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;
import java.io.IOException;

@WebServlet("/ViewBookingServlet")
public class ViewBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerID = request.getParameter("customerID");
        BookingDAO bookingDAO = new BookingDAO();
        RoomDAO roomDAO = new RoomDAO();

        List<Booking> bookings = bookingDAO.getCustomerBooking(customerID);

        if (bookings != null && !bookings.isEmpty()) {
            List<Map<String, Object>> bookingDetails = new ArrayList<>();

            for (Booking booking : bookings) {
                Room room = roomDAO.getRoomInformationByBookingID(booking.getBookingID());
                Map<String, Object> details = new HashMap<>();

                details.put("booking", booking);
                details.put("roomNumber", (room != null) ? room.getRoomNumber() : "N/A");
                details.put("hotelID", (room != null) ? room.getId() : "N/A");
                details.put("price", (room != null) ? room.getPrice() : "N/A");

                bookingDetails.add(details);
            }

            request.setAttribute("bookingDetails", bookingDetails);
        } else {
            request.setAttribute("bookingDetails", Collections.emptyList());
        }

        request.getRequestDispatcher("/view-booking.jsp").forward(request, response);
    }

}