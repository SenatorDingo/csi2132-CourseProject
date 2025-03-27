package code;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Manager {
    private String ssn;
    private String employeeID;
    private String firstName;
    private String lastName;
    private String middleInitials;

    private static final Connection connection = Connectiondb.getConnection();

    // Constructor
    public Manager(String ssn, String employeeID, String firstName, String lastName, String middleInitials) {
        this.ssn = ssn;
        this.employeeID = employeeID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.middleInitials = middleInitials;
    }


    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSsn() {
        return ssn;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public String getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(String employeeID) {
        this.employeeID = employeeID;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getMiddleInitials() {
        return middleInitials;
    }

    public void setMiddleInitials(String middleInitials) {
        this.middleInitials = middleInitials;
    }




    public static void getAllManagers() {

        if (connection == null) {
            System.out.println("Failed to establish database connection.");
            return;
        }

        String query = "SELECT * FROM manager";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {


            while (resultSet.next()) {
                System.out.println("SSN: " + resultSet.getString("ssn"));
                System.out.println("Employee ID: " + resultSet.getString("employeeID"));
                System.out.println("First Name: " + resultSet.getString("firstName"));
                System.out.println("Last Name: " + resultSet.getString("lastName"));
                System.out.println("Middle Initials: " + resultSet.getString("middleInitials"));
                System.out.println("-------------------------------------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connectiondb.closeConnection(connection);
        }
    }

    public static void main(String[] args) {
        getAllManagers();
    }
}
