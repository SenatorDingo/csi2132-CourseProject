package code.dataAccessObjects;

import code.Connectiondb;
import code.Employee;
import code.Room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
}
