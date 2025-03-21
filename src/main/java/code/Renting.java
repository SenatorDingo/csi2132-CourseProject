package code;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Renting {
    private String rentingID;
    private String checkInDate;
    private String checkOutDate;
    private String paymentMethod;
    static Connection connection = Connectiondb.getConnection();


    public Renting(String rentingID, String checkInDate, String checkOutDate, String paymentMethod) {
        this.rentingID = rentingID;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.paymentMethod = paymentMethod;
    }

    public String getRentingID() {
        return rentingID;
    }

    public void setRentingID(String rentingID) {
        this.rentingID = rentingID;
    }

    public String getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(String checkInDate) {
        this.checkInDate = checkInDate;
    }

    public String getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(String checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }




    public static void getAllRentings() {

        if (connection == null) {
            System.out.println("Failed to establish database connection.");
            return;
        }

        String query = "SELECT * FROM renting";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            System.out.println("=== Renting List ===");
            while (resultSet.next()) {
                System.out.println("Renting ID: " + resultSet.getString("rentingID"));
                System.out.println("Check-In Date: " + resultSet.getString("checkInDate"));
                System.out.println("Check-Out Date: " + resultSet.getString("checkOutDate"));
                System.out.println("Payment Method: " + resultSet.getString("paymentMethod"));
                System.out.println("-------------------------------------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connectiondb.closeConnection(connection);
        }
    }

    public static void main(String[] args) {
        getAllRentings();
    }
}
