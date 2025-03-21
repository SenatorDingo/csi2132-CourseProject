package code;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Customer {
    private String customerID;
    private String name;
    private String idType;
    private String dateOfRegistration;
    private String address;

    static Connection connection = Connectiondb.getConnection();

    public Customer(String customerID, String name, String idType, String dateOfRegistration, String address) {
        this.customerID = customerID;
        this.name = name;
        this.idType = idType;
        this.dateOfRegistration = dateOfRegistration;
        this.address = address;
    }

    //for testing purposes
    public static void getAllCustomers() {

        if (connection == null) {
            System.out.println("Failed to establish database connection.");
            return;
        }

        String query = "SELECT * FROM customer";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                System.out.println("Customer ID: " + resultSet.getString("customerID"));
                System.out.println("Name: " + resultSet.getString("name"));
                System.out.println("ID Type: " + resultSet.getString("idType"));
                System.out.println("Registration Date: " + resultSet.getString("dateOfRegistration"));
                System.out.println("Address: " + resultSet.getString("address"));
                System.out.println("-------------------------------------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connectiondb.closeConnection(connection);
        }
    }

    public static void main(String[] args) {
        getAllCustomers();
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDateOfRegistration() {
        return dateOfRegistration;
    }

    public void setDateOfRegistration(String dateOfRegistration) {
        this.dateOfRegistration = dateOfRegistration;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

}
