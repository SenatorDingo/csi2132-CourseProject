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

    public static boolean addBooking(Date checkInDate, Date checkOutDate) {

        String bookingId = UUID.randomUUID().toString();


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
            // Log exception for debugging
            logger.severe("SQL Exception while adding booking: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        return false;
    }

}
