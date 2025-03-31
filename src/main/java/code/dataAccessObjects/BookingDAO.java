package code.dataAccessObjects;

import code.Booking;
import code.Connectiondb;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;

public class BookingDAO {
    private static final Logger logger = Logger.getLogger(BookingDAO.class.getName());

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings";

        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getString("id"),
                        rs.getString("customer_id"),
                        rs.getDate("check_in_date"),
                        rs.getDate("check_out_date")

                );

                bookings.add(booking);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookings;
    }

    public static boolean addBooking(String bookingId, Date checkInDate, Date checkOutDate) {


        String sql = "INSERT INTO booking (bookingid, checkInDate, checkOutDate) VALUES (?, ?, ?)";

        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {


            logger.info("Executing query: " + sql);


            pstmt.setString(1, bookingId);
            pstmt.setDate(2, (java.sql.Date) checkInDate);
            pstmt.setDate(3, (java.sql.Date) checkOutDate);


            int rowsAffected = pstmt.executeUpdate();


            if (rowsAffected > 0) {
                logger.info("Booking successfully added with ID: " + bookingId);
                return true;
            }

        } catch (SQLException e) {
            logger.severe("SQL Exception while adding booking: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public static boolean addReservation(String bookingId, String hotelID, int roomNumber) {
        String sql = "INSERT INTO reserves (roomNumber, bookingID, hotelID) VALUES (?, ?, ?)";
        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomNumber);
            pstmt.setString(2, bookingId);
            pstmt.setString(3, hotelID);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                logger.info("Reservation successfully added for booking ID: " + bookingId);
                return true;
            }

        } catch (SQLException e) {
            logger.severe("SQL Exception while adding reservation: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public static boolean addOnlineBooking(String bookingId, String customerId) {
        String sql = "INSERT INTO onlineBook (bookingID, customerID) VALUES (?, ?)";

        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, bookingId);
            pstmt.setString(2, customerId);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                logger.info("Online booking successfully added for booking ID: " + bookingId);
                return true;
            }

        } catch (SQLException e) {
            logger.severe("SQL Exception while adding online booking: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        return false;
    }
}
