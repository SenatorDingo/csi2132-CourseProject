package code;

import java.sql.*;

public class Connectiondb {
    // Database connection parameters
    public static void main(String[] args) {
        try (Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/WebApp", "postgres", "new_password");) {
            System.out.println("Connected");

            Statement stmt = db.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM employee");
            while (rs.next()) {

                //getting the test data
                String employeeID = rs.getString("employeeID");
                String sin = rs.getString("sin");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String middleInitials = rs.getString("middleInitials");
                String name = rs.getString("name");
                String address = rs.getString("address");
                String role = rs.getString("role");

                //prinign out the line
                System.out.println(
                        "EmployeeID: " + employeeID +
                        ", SIN: " + sin +
                        ", First Name: " + firstName +
                        ", Last Name: " + lastName +
                        ", Middle Initials: " + middleInitials +
                        ", Name: " + name +
                        ", Address: " + address +
                        ", Role: " + role);

            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }


    }


}
