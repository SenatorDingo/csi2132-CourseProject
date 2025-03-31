package code.dataAccessObjects;

import code.Booking;
import code.Connectiondb;
import code.Room;

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

    public static Booking getBookingBasedOnID(String bookingID) {
        Booking b = null;
        String sql = "SELECT bookingID, checkInDate, checkOutDate FROM booking WHERE bookingID = ?";
        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, bookingID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {

                     b = new Booking(
                             rs.getString("bookingID"),
                             rs.getDate("checkInDate"),
                             rs.getDate("checkOutDate")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return b;
    }


    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings";

        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getString("id"),
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

    public Booking getCustomerBooking(String customerID) {
        Booking booking = null;
        String bookingIdQuery = "SELECT bookingID FROM onlineBook WHERE customerID = ?";
        String bookingQuery = "SELECT * FROM booking WHERE bookingID = ?";

        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement bookingIdStmt = conn.prepareStatement(bookingIdQuery)) {

            bookingIdStmt.setString(1, customerID);
            ResultSet bookingIdRs = bookingIdStmt.executeQuery();

            if (bookingIdRs.next()) {
                String bookingID = bookingIdRs.getString("bookingID");

                try (PreparedStatement bookingStmt = conn.prepareStatement(bookingQuery)) {
                    bookingStmt.setString(1, bookingID);
                    ResultSet bookingRs = bookingStmt.executeQuery();

                    if (bookingRs.next()) {
                        booking = new Booking(
                                bookingRs.getString("bookingID"),
                                bookingRs.getDate("checkInDate"),
                                bookingRs.getDate("checkOutDate")
                        );
                    }
                }
            }
        } catch (SQLException e) {
            logger.severe("SQL Exception while retrieving customer booking: " + e.getMessage());
            e.printStackTrace();
        }

        return booking;
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

    public boolean deleteBooking(String bookingID) {
        String sql = "DELETE FROM booking WHERE bookingID = ?";
        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, bookingID);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                logger.info("Booking successfully deleted with ID: " + bookingID);
                return true;
            }

        } catch (SQLException e) {
            logger.severe("SQL Exception while deleting booking: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public static boolean updateBooking(String bookingID, Date checkInDate, Date checkOutDate) {
        String sql = "UPDATE booking SET checkInDate = ?, checkOutDate = ? WHERE bookingID = ?";
        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {


            pstmt.setDate(1, (java.sql.Date) checkInDate);
            pstmt.setDate(2, (java.sql.Date) checkOutDate);
            pstmt.setString(3, bookingID);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                logger.info("Booking successfully updated with ID: " + bookingID);
                return true;
            }

        } catch (SQLException e) {
            logger.severe("SQL Exception while updating booking: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        return false;
    }


}
