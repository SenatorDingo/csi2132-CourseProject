package code.dataAccessObjects;

import code.Connectiondb;
import code.Room;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class RoomDAO {
    private static final Logger logger = Logger.getLogger(RoomDAO.class.getName());

    public static List<Room> searchRooms(String capacity, String view, String amenity, String maxPrice,
                                         String hotelChain, String category, String checkInDate, String checkOutDate) {

        List<Room> rooms = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT r.hotelID, r.roomNumber, r.capacity, r.price, r.view, r.amenity, r.knownIssues, r.extendable ");
        query.append("FROM room r ");
        query.append("JOIN hotel h ON r.hotelID = h.id ");

        if (capacity != null && !capacity.isEmpty()) {
            query.append("AND r.capacity = ").append(capacity).append(" ");
        }
        if (view != null && !view.isEmpty()) {
            query.append("AND r.view = '").append(view).append("' ");
        }
        if (amenity != null && !amenity.isEmpty()) {
            query.append("AND r.amenity = '").append(amenity).append("' ");
        }
        if (maxPrice != null && !maxPrice.isEmpty()) {
            query.append("AND r.price <= ").append(maxPrice).append(" ");
        }
        if (hotelChain != null && !hotelChain.isEmpty()) {
            query.append("AND h.chainName = '").append(hotelChain).append("' ");
        }
        if (category != null && !category.isEmpty()) {
            query.append("AND h.category = '").append(category).append("' ");
        }
        if (checkInDate != null && !checkInDate.isEmpty() && checkOutDate != null && !checkOutDate.isEmpty()) {
            query.append("AND r.roomNumber NOT IN (SELECT r.roomNumber FROM booking b ");
            query.append("JOIN reserves res ON b.bookingID = res.bookingID ");
            query.append("WHERE b.checkInDate <= '").append(checkOutDate).append("' ");
            query.append("AND b.checkOutDate >= '").append(checkInDate).append("') ");
        }

        logger.info("SQL Query: " + query.toString());

        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query.toString());
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Room room = new Room(
                        rs.getString("hotelID"),
                        rs.getInt("roomNumber"),
                        rs.getInt("capacity"),
                        rs.getFloat("price"),
                        rs.getString("view"),
                        rs.getString("amenity"),
                        rs.getBoolean("knownIssues"),
                        rs.getBoolean("extendable")
                );
                rooms.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rooms;
    }
}
