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
import java.util.List;
import java.util.Objects;
import java.io.IOException;

@WebServlet("/ViewBookingServlet")
public class ViewBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerID = request.getParameter("customerID");
        BookingDAO bookingDAO = new BookingDAO();
        RoomDAO roomDAO = new RoomDAO();
        List<Booking> bookings = bookingDAO.getCustomerBooking(customerID);
        if (bookings != null && !bookings.isEmpty()) {
            Booking booking = bookings.get(0);
            Room room = roomDAO.getRoomInformationByBookingID(booking.getBookingID());

            if (room != null && booking != null) {
                request.setAttribute("booking", booking);
                request.setAttribute("roomNumber", room.getRoomNumber());
                request.setAttribute("hotelID", room.getId());
                request.setAttribute("price", room.getPrice());

                request.getRequestDispatcher("/view-booking.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/view-booking.jsp").forward(request, response);

            }
        } else {
            request.getRequestDispatcher("/view-booking.jsp").forward(request, response);
        }
    }
}