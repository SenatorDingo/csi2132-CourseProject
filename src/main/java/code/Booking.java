package code;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Booking {




    private String id;
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
