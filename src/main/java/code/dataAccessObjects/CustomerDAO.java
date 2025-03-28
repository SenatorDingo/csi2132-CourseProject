package code.dataAccessObjects;

import code.Customer;
import code.Connectiondb;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    private static final Connection connection = Connectiondb.getConnection();

    public static boolean addCustomer(Customer customer) {
        String query = "INSERT INTO customer (customerID, name, idType, dateOfRegistration, address) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, customer.getCustomerID());
            statement.setString(2, customer.getName());
            statement.setString(3, customer.getIdType());
            statement.setDate(4, customer.getDateOfRegistration());
            statement.setString(5, customer.getAddress());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static Customer getCustomerById(String customerID) {
        String query = "SELECT * FROM customer WHERE customerID = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, customerID);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return new Customer(
                        resultSet.getString("customerID"),
                        resultSet.getString("name"),
                        resultSet.getString("idType"),
                        resultSet.getDate("dateOfRegistration"),
                        resultSet.getString("address")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM customer";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                customers.add(new Customer(
                        resultSet.getString("customerID"),
                        resultSet.getString("name"),
                        resultSet.getString("idType"),
                        resultSet.getDate("dateOfRegistration"),
                        resultSet.getString("address")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public static boolean validateCustomer(String customerID) {
        String query = "SELECT 1 FROM customer WHERE customerID = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, customerID);
            ResultSet resultSet = statement.executeQuery();
            return resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}