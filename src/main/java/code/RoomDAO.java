package code;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {
    private static final Connection connection = Connectiondb.getConnection();

    public static List<Room> searchRooms(String capacity, String view, String amenity, String maxPrice) {

        List<Room> rooms = new ArrayList<>();
        //list to keep track of how many parameters the user has selected
        List<Object> parameters = new ArrayList<>();

        //TODO we need to think of the REQUIRED paramters we wan tther user to submit
        parameters.add(Integer.parseInt(capacity));
        String query = "SELECT * FROM room WHERE capacity = ?";

        //adding paramters based on if the user has selcted them
        if (view != null && !view.isEmpty()) {
            query+= " AND view = ?";
            parameters.add(view);
        }
        if (amenity != null && !amenity.isEmpty()) {
            query += (" AND amenity = ?");
            parameters.add(amenity);
        }
        if (maxPrice != null && !maxPrice.isEmpty()) {
            query+=(" AND price <= ?");
            parameters.add(Float.parseFloat(maxPrice));
        }

        //preparing the query based on what the user has selected
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }


            //execte the query 
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                rooms.add(new Room(
                        rs.getString("hotelID"),
                        rs.getInt("roomNumber"),
                        rs.getInt("capacity"),
                        rs.getFloat("price"),
                        rs.getString("view"),
                        rs.getString("amenity"),
                        rs.getBoolean("knownIssues"),
                        rs.getBoolean("extendable")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }
}
