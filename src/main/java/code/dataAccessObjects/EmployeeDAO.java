package code.dataAccessObjects;

import code.Booking;
import code.Connectiondb;
import code.Employee;
import code.Room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {
    public static boolean addEmployee(Employee employee) {
        String query = "INSERT INTO employee (employeeID, sin, firstName, lastName, middleInitials, address, role) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, employee.getId());
            stmt.setString(2, employee.getSin());
            stmt.setString(3, employee.getFirstName());
            stmt.setString(4, employee.getLastName());
            stmt.setString(5, employee.getMiddleInitials());
            stmt.setString(6, employee.getAddress());
            stmt.setString(7, employee.getRole());

            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean checkEmployeeExists(String eID) {
        String query = "SELECT * FROM employee WHERE employeeID = ?";



        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query.toString())){
            stmt.setString(1, eID);
            ResultSet rs = stmt.executeQuery();

          if (rs.next()) {
              return true;
          }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static List<Booking> getBookingsForEmployee(String employeeID) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT DISTINCT b.bookingID, b.checkInDate, b.checkOutDate " +
                "FROM booking b " +
                "JOIN reserves r ON b.bookingID = r.bookingID " +
                "JOIN hotel h ON r.hotelID = h.id " +
                "JOIN employs e ON e.hotelID = h.id " +
                "JOIN customer c ON b.bookingID = r.bookingID " +
                "WHERE e.employeeID = E1";

        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, employeeID); // Correctly setting the employee ID

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    System.out.println("Booking ID Found: " + rs.getString("bookingID"));
                    Booking booking = new Booking(
                            rs.getString("bookingID"),
                            rs.getDate("checkInDate"),
                            rs.getDate("checkOutDate")
                    );
                    bookings.add(booking);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }
}
