package code;
import java.sql.*;
import java.util.ArrayList;

public class HotelChain {
    private static String chainName;
    private String Address;
    private int numHotels;
    private String email;
    private int phone;

    static Connection connection = Connectiondb.getConnection();
    //Constructor
    public HotelChain(String chainName, String address, int numHotels, String email, int phone) {
        this.chainName = chainName;
        Address = address;
        this.numHotels = numHotels;
        this.email = email;
        this.phone = phone;
    }

    //getters & setters
    public String getChainName() {
        return chainName;
    }

    public void setChainName(String chainName) {
        this.chainName = chainName;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String address) {
        Address = address;
    }

    public int getNumHotels() {
        return numHotels;
    }

    public void setNumHotels(int numHotels) {
        this.numHotels = numHotels;
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

    public static void getAllHotelChains(){


        if (connection == null) {
            System.out.println("Failed to establish database connection.");
            return;
        }

        String query = "SELECT * FROM hotelChain";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                System.out.println("Chain Name: " + resultSet.getString("chainName"));
                System.out.println("Address: " + resultSet.getString("address"));
                System.out.println("Number of Hotels: " + resultSet.getString("numHotels"));
                System.out.println("Email: " + resultSet.getString("email"));
                System.out.println("Phone: " + resultSet.getString("phone"));
                System.out.println("-------------------------------------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connectiondb.closeConnection(connection);
        }
    }


    public ArrayList<Hotel> getAllHotelsBasedOnChain(String cN){
        ArrayList<Hotel> hotelsBasedOnChianName = new ArrayList<>();
        //making sure connection is active to use
        if (connection == null) {
            System.out.println("Failed to establish database connection.");
            return null;
        }
        //query to get hotels from hotelChaons
        String query = "SELECT * FROM hotel h JOIN owns o ON h.id = o.hotelID WHERE o.chainName = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)){
            //using hte cN to replace the ? in the sql querey
             statement.setString(1, cN);
             try(ResultSet resultSet = statement.executeQuery()) {

                 //creating the hotel objects
            while (resultSet.next()) {
                hotelsBasedOnChianName.add(new Hotel(
                        resultSet.getString("id"),
                        resultSet.getString("name"),
                        resultSet.getString("address"),
                        resultSet.getString("email"),
                        (int) resultSet.getLong("phone"),
                        resultSet.getInt("numRooms"),
                        resultSet.getString("category")
                        ));

            }}

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connectiondb.closeConnection(connection);
        }
        //for testing purposes
        for (Hotel hotel : hotelsBasedOnChianName) {
            System.out.println(hotel.toString());
        }
        return hotelsBasedOnChianName;


    }
    //toString method
    @Override
    public String toString() {
        return "HotelChain{" +
                "chainName='" + chainName + '\'' +
                ", Address='" + Address + '\'' +
                ", numHotels=" + numHotels +
                ", email='" + email + '\'' +
                ", phone=" + phone +
                '}';
    }
    public String toStringWA() {
        return "<ul>" +
                "<li> chainName=" + chainName + "</li>" +
                "<li>Address=" + Address + "</li>" +
                "<li> numHotels=" + numHotels + "</li>" +
                "<li> email='" + email + "</li>" +
                "<li> phone=" + phone +"</li>";
    }

    public static void main(String[] args){
        //getAllHotelsBasedOnChain("Holiday Inn");
        //getAllHotelChains();
    }

}
