package code;
import java.sql.*;

public class Booking {




    private String id;

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    public void setCheckOutDate(Date checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    private String customerID;

    public String getBookingID(){return this.id;}
    public String getCustomerID() {
        return customerID;
    }

    public Date getCheckInDate() {
        return checkInDate;
    }

    public Date getCheckOutDate() {
        return checkOutDate;
    }

    public Booking(String id, Date checkInDate, Date checkOutDate) {
        this.id = id;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
    }

    private Date checkInDate;
    private Date checkOutDate;

    static Connection connection = Connectiondb.getConnection();

    public Booking(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public static void getAllBookings(){
        if (connection == null) {
            System.out.println("Failed to establish database connection.");
            return;
        }

        String query = "SELECT * FROM booking";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {


            while (resultSet.next()) {
                System.out.println("Booking ID: " + resultSet.getString("bookingID"));

                System.out.println("-------------------------------------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connectiondb.closeConnection(connection);
        }
    }
    public static void main(String[] args) {
        getAllBookings();
    }
}
