package code;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Room {
    private String id;
    private int roomNumber;
    private int capacity;
    private float price;
    //maybe make this an enum
    private String view;
    //maybe make this an enum and an array?
    private String amenity;
    private boolean knownIssues;
    private boolean extendable;
    static Connection connection = Connectiondb.getConnection();

    public Room(String id, int roomNumber, int capacity, float price, String view, String amenity, boolean knownIssues, boolean extendable) {
        this.id = id;
        this.roomNumber = roomNumber;
        this.capacity = capacity;
        this.price = price;
        this.view = view;
        this.amenity = amenity;
        this.knownIssues = knownIssues;
        this.extendable = extendable;
    }


    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getView() {
        return view;
    }

    public void setView(String view) {
        this.view = view;
    }

    public String getAmenity() {
        return amenity;
    }

    public void setAmenity(String amenity) {
        this.amenity = amenity;
    }

    public boolean isKnownIssues() {
        return knownIssues;
    }

    public void setKnownIssues(boolean knownIssues) {
        this.knownIssues = knownIssues;
    }

    public boolean isExtendable() {
        return extendable;
    }

    public void setExtendable(boolean extendable) {
        this.extendable = extendable;
    }

    public static void getAllRooms() {

        if (connection == null) {
            System.out.println("Failed to establish database connection.");
            return;
        }

        String query = "SELECT * FROM room";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                System.out.println("Hotel ID: " + resultSet.getString("hotelID"));
                System.out.println("Room Number: " + resultSet.getString("roomNumber"));
                System.out.println("capacity: " + resultSet.getString("capacity"));
                System.out.println("Price " + resultSet.getString("price"));
                System.out.println("View: " + resultSet.getString("view"));
                System.out.println("Amenity: " + resultSet.getString("amenity"));
                System.out.println("Known Issues " + resultSet.getString("knownIssues"));
                System.out.println("Extendable: " + resultSet.getString("extendable"));
                System.out.println("-------------------------------------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connectiondb.closeConnection(connection);
        }
    }

    public static void main(String[] args) {
        getAllRooms();
    }
    @Override
    public String toString() {
        return "Room{" +
                "id='" + id + '\'' +
                ", roomNumber=" + roomNumber +
                ", capacity=" + capacity +
                ", price=" + price +
                ", view='" + view + '\'' +
                ", amenity='" + amenity + '\'' +
                ", knownIssues=" + knownIssues +
                ", extendable=" + extendable +
                '}';
    }

    public String toStringWA() {
        return "<ul> "+
                "id='" + id + "</li>" +
                "<li> roomNumber=" + roomNumber +"</li>" +
                "<li> capacity=" + capacity + "</li>" +
                "<li> price=" + price +"</li>" +
                "<li> view='" + view +"</li>" +
                "<li> amenity='" + amenity + "</li>" +
                " <li> knownIssues=" + knownIssues + "</li>" +
                " <li> extendable=" + extendable + "</li>" ;
    }

}
