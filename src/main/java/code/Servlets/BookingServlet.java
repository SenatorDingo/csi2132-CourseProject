package code.Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Date;

import code.dataAccessObjects.BookingDAO;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String checkInDateStr = request.getParameter("checkInDate");
        String checkOutDateStr = request.getParameter("checkOutDate");
        String customerID = request.getParameter("customerID");
        String roomNumber = request.getParameter("roomNumber");
        String hotelID = request.getParameter("hotelID");


        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date checkInDate = dateFormat.parse(checkInDateStr);
            Date checkOutDate = dateFormat.parse(checkOutDateStr);

            String bookingId = UUID.randomUUID().toString();

            boolean success = BookingDAO.addBooking(bookingId, new java.sql.Date(checkInDate.getTime()), new java.sql.Date(checkOutDate.getTime())) &&
            BookingDAO.addOnlineBooking(bookingId, customerID) &&
            BookingDAO.addReservation(bookingId, hotelID, Integer.parseInt(roomNumber));


            if (success) {
                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("booking-failure.jsp");
            }
        } catch (ParseException e) {

            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page
        }
    }
}
