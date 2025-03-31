package code.dataAccessObjects;

import code.Connectiondb;
import code.PaymentType;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;
import java.util.logging.Logger;

public class RentingDAO {
    private static final Logger logger = Logger.getLogger(RentingDAO.class.getName());

    public static boolean createRentingForBooking(String rentingID, String bookingID, Date checkInDate, Date checkOutDate, PaymentType paymentMethod, String employeeID) {
        String insertRentingSQL = "INSERT INTO renting (rentingID, checkInDate, checkOutDate, paymentMethod) VALUES (?, ?, ?, ?)";
        String archiveSQL = "INSERT INTO archiveRecord (archiveID, bookingID, rentingID, checkInDate, checkOutDate) VALUES (?, ?, ?, ?, ?)";
        String moveRoomsSQL = "INSERT INTO occupies (hotelID, roomNumber, rentingID) " +
                "SELECT hotelID, roomNumber, ? FROM reserves WHERE bookingID = ?";
        String deleteBookingSQL = "DELETE FROM booking WHERE bookingID = ?";
        String insertCheckInSQL = "INSERT INTO checkIn (customerID, hotelID, employeeID) " +
                "SELECT ob.customerID, r.hotelID, ? FROM onlineBook ob " +
                "JOIN reserves r ON ob.bookingID = r.bookingID " +
                "WHERE ob.bookingID = ?";


        try (Connection connection = Connectiondb.getConnection();
             PreparedStatement insertRentingStmt = connection.prepareStatement(insertRentingSQL);
             PreparedStatement archiveStmt = connection.prepareStatement(archiveSQL);
             PreparedStatement moveRoomsStmt = connection.prepareStatement(moveRoomsSQL);
             PreparedStatement deleteBookingStmt = connection.prepareStatement(deleteBookingSQL);
             PreparedStatement insertCheckInStmt = connection.prepareStatement(insertCheckInSQL)) {

            connection.setAutoCommit(false);

            // Insert new renting record
            insertRentingStmt.setString(1, rentingID);
            insertRentingStmt.setDate(2, checkInDate);
            insertRentingStmt.setDate(3, checkOutDate);
            insertRentingStmt.setObject(4, paymentMethod.toString(), java.sql.Types.OTHER); // Use setObject for enum
            insertRentingStmt.executeUpdate();

            // Move reserved rooms to occupied
            moveRoomsStmt.setString(1, rentingID);
            moveRoomsStmt.setString(2, bookingID);
            moveRoomsStmt.executeUpdate();

            // Insert into check-in table
            insertCheckInStmt.setString(1, employeeID);
            insertCheckInStmt.setString(2, bookingID);
            insertCheckInStmt.executeUpdate();

            // Delete the booking
            deleteBookingStmt.setString(1, bookingID);
            deleteBookingStmt.executeUpdate();

            String archiveID = UUID.randomUUID().toString();


            // Archive the booking
            archiveStmt.setString(1, archiveID);
            archiveStmt.setString(2, bookingID);
            archiveStmt.setString(3, rentingID);
            archiveStmt.setDate(4, checkInDate);
            archiveStmt.setDate(5, checkOutDate);
            archiveStmt.executeUpdate();

            connection.commit();
            return true;
        } catch (SQLException e) {
            logger.severe("Error in createRentingForBooking: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}

