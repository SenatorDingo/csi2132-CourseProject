package code.Servlets;
import code.*;
import code.dataAccessObjects.EmployeeDAO;
import code.dataAccessObjects.CustomerDAO;
import code.dataAccessObjects.BookingDAO;
import code.dataAccessObjects.RoomDAO;
import code.dataAccessObjects.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/CheckInServlet")
public class CheckInServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();
    private final RoomDAO roomDAO = new RoomDAO();
    private final RentingDAO rentingDAO = new RentingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingID = request.getParameter("book");
        String employeeID = request.getParameter("employeeID");
        System.out.println(employeeID);

        if (bookingID != null) {
            Booking booking = bookingDAO.getBookingBasedOnID(bookingID);

            if (booking != null) {
                Customer customer = customerDAO.getCustomerByBookingID(bookingID);
                Room room = roomDAO.getRoomByBookingID(bookingID);

                request.setAttribute("booking", booking);
                request.setAttribute("customer", customer);
                request.setAttribute("room", room);
                request.setAttribute("employeeID", employeeID);

                System.out.println(customer.getCustomerID());

                request.getRequestDispatcher("check-in.jsp").forward(request, response);
                return;
            }
        }

        response.sendRedirect("view-bookings.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingID = request.getParameter("bookingID");
        String employeeID = request.getParameter("employeeID");
        String paymentMethodString = request.getParameter("paymentMethod");
        PaymentType paymentMethod = PaymentType.valueOf(paymentMethodString);


        if (bookingID != null && employeeID != null && paymentMethod != null) {
            Booking booking = bookingDAO.getBookingBasedOnID(bookingID);
            String rentingId = UUID.randomUUID().toString();
            if (booking != null) {
                rentingDAO.createRentingForBooking(rentingId, bookingID, booking.getCheckInDate(), booking.getCheckOutDate(), paymentMethod);

                response.sendRedirect("view-bookings.jsp?success=checkin");
                return;
            }
        }

        response.sendRedirect("check-in.jsp?error=1");
    }
}