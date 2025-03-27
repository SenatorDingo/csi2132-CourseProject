package code;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Hotel {
    private String id;
    private String name;
    private String address;
    private String email;
    private int phone;
    private int numRooms;
    private String category;

    static Connection connection = Connectiondb.getConnection();


    public Hotel(String id, String name, String address, String email, int phone, int numRooms, String category) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.email = email;
        this.phone = phone;
        this.numRooms = numRooms;
        this.category = category;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
        this.phone = phone;
    }

    public int getNumRooms() {
        return numRooms;
    }

    public void setNumRooms(int numRooms) {
        this.numRooms = numRooms;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public static void getAllHotels(){

        if (connection == null) {
            System.out.println("Failed to establish database connection.");
            return;
        }

        String query = "SELECT * FROM hotel";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                System.out.println("Hotel ID: " + resultSet.getString("id"));
                System.out.println("Name: " + resultSet.getString("name"));
                System.out.println("Address: " + resultSet.getString("address"));
                System.out.println("Email: " + resultSet.getString("email"));
                System.out.println("Phone: " + resultSet.getString("phone"));
                System.out.println("Number of Rooms: " + resultSet.getString("numRooms"));
                System.out.println("Category: " + resultSet.getString("category"));
                System.out.println("-------------------------------------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connectiondb.closeConnection(connection);
        }

    }

    public static ArrayList<Room> getAllRooms(String hotelID){
        if (connection == null) {
            System.out.println("Failed to establish database connection.");
            return null;
        }
        ArrayList<Room> allRooms = new ArrayList<>();

        String query = "SELECT * FROM room Where hotelId = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)){
            statement.setString(1, hotelID);
            try(ResultSet rs = statement.executeQuery()){
                while (rs.next()){
                    allRooms.add(
                            new Room(
                                    rs.getString("hotelID"),
                                    rs.getInt("roomNumber"),
                                    rs.getInt("capacity"),
                                    rs.getInt("price"),
                                    rs.getString("view"),
                                    rs.getString("amenity"),
                                    rs.getBoolean("knownIssues"),
                                    rs.getBoolean("extendable")
                            )
                    );

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        finally {
            Connectiondb.closeConnection(connection);
        }
       return allRooms;
    }



    public static void main(String[] args){
        getAllRooms("1");
    }



    @Override
    public String toString() {
        return "Hotel{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", email='" + email + '\'' +
                ", phone=" + phone +
                ", numRooms=" + numRooms +
                ", category='" + category + '\'' +
                '}';
    }

    public String toStringWA() {
        return "<ul>" +
                "<li> id=" + id + "</li>" +
                "<li> name='" + name + "</li>" +
                "<li> address='" + address + "</li>" +
                "<li> email='" + email + "</li>" +
                "<li> phone=" + phone + "</li>" +
                "<li> numRooms=" + numRooms +"</li>" +
                "<li> category='" + category + "</li>" ;
    }
}
