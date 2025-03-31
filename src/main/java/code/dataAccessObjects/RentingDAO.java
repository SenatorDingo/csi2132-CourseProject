package code.dataAccessObjects;

import code.Connectiondb;
import code.PaymentType;
import code.Renting;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
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
    public static List<Renting> getRentingsForEmployee(String employeeID) {
        List<Renting> rentings = new ArrayList<>();
        String query = "SELECT r.* " +
                "FROM renting r " +
                "JOIN occupies o ON r.rentingID = o.rentingID " +
                "JOIN room rm ON o.hotelID = rm.hotelID AND o.roomNumber = rm.roomNumber " +
                "JOIN employs e ON rm.hotelID = e.hotelID " +
                "WHERE e.employeeID = ?";
        try (Connection conn = Connectiondb.getConnection(); // Replace with your DB connection method
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the employeeID parameter
            stmt.setString(1, employeeID);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Assuming Renting is a class that matches the columns in the renting table
                    Renting renting = new Renting(
                            rs.getString("rentingID"),
                            rs.getDate("checkInDate"),
                            rs.getDate("checkOutDate"),
                            rs.getString("paymentMethod")
                    );
                    rentings.add(renting);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
        }
        return rentings; // Return the list of rentings
    }
}

