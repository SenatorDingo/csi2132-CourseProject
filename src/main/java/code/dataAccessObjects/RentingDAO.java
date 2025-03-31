package code.dataAccessObjects;

import code.Connectiondb;
import code.PaymentType;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Logger;

public class RentingDAO {
    private static final Logger logger = Logger.getLogger(RentingDAO.class.getName());

    public static boolean createRentingForBooking(String rentingID, String bookingID, Date checkInDate, Date checkOutDate, PaymentType paymentMethod) {
        String insertRentingSQL = "INSERT INTO renting (rentingID, checkInDate, checkOutDate, paymentMethod) VALUES (?, ?, ?, ?)";
        String archiveSQL = "INSERT INTO archiveRecord (bookingID, rentingID, checkInDate, checkOutDate) VALUES (?, ?, ?, ?)";
        String moveRoomsSQL = "INSERT INTO occupies (hotelID, roomNumber, rentingID) " +
                "SELECT hotelID, roomNumber, ? FROM reserves WHERE bookingID = ?";
        String deleteBookingSQL = "DELETE FROM booking WHERE bookingID = ?";

        try (Connection connection = Connectiondb.getConnection();
             PreparedStatement insertRentingStmt = connection.prepareStatement(insertRentingSQL);
             PreparedStatement archiveStmt = connection.prepareStatement(archiveSQL);
             PreparedStatement moveRoomsStmt = connection.prepareStatement(moveRoomsSQL);
             PreparedStatement deleteBookingStmt = connection.prepareStatement(deleteBookingSQL)) {

            connection.setAutoCommit(false);

            // Insert new renting record
            insertRentingStmt.setString(1, rentingID);
            insertRentingStmt.setDate(2, checkInDate);
            insertRentingStmt.setDate(3, checkOutDate);
            insertRentingStmt.setObject(4, paymentMethod.toString(), java.sql.Types.OTHER); // Use setObject for enum
            insertRentingStmt.executeUpdate();

            // Archive the booking
            archiveStmt.setString(1, bookingID);
            archiveStmt.setString(2, rentingID);
            archiveStmt.setDate(3, checkInDate);
            archiveStmt.setDate(4, checkOutDate);
            archiveStmt.executeUpdate();

            // Move reserved rooms to occupied
            moveRoomsStmt.setString(1, rentingID);
            moveRoomsStmt.setString(2, bookingID);
            moveRoomsStmt.executeUpdate();

            // Delete the booking
            deleteBookingStmt.setString(1, bookingID);
            deleteBookingStmt.executeUpdate();

            connection.commit();
            return true;
        } catch (SQLException e) {
            logger.severe("Error in createRenting: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}

