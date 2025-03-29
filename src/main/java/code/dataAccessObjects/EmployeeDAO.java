package code.dataAccessObjects;

import code.Connectiondb;
import code.Room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EmployeeDAO {
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
