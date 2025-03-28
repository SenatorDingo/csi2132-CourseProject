package code.dataAccessObjects;

import code.Connectiondb;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.UUID;
import java.util.logging.Logger;

public class BookingDAO {
    private static final Logger logger = Logger.getLogger(BookingDAO.class.getName());

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
