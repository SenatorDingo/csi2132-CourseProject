package code;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {
    private static final Connection connection = Connectiondb.getConnection();

    public static List<Room> searchRooms(String capacity, String view, String amenity, String maxPrice) {
        List<Room> rooms = new ArrayList<>();
        String query = "SELECT * FROM room WHERE price <= COALESCE(?, price) " +
                "AND capacity = COALESCE(NULLIF(?, ''), capacity) " +
                "AND view ILIKE COALESCE(NULLIF(?, ''), view) " +
                "AND amenity ILIKE COALESCE(NULLIF(?, ''), amenity)";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setObject(1, maxPrice.isEmpty() ? null : Float.parseFloat(maxPrice));
            stmt.setString(2, capacity);
            stmt.setString(3, "%" + view + "%");
            stmt.setString(4, "%" + amenity + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                rooms.add(new Room(
                        rs.getString("id"),
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
