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
                                         String hotelChain, String category, String checkInDate, String checkOutDate,String city) {

        List<Room> rooms = new ArrayList<>();

        StringBuilder query = new StringBuilder("SELECT r.hotelID, r.roomNumber, r.capacity, r.price, r.view, r.amenity, r.knownIssues, r.extendable, h.category, o.chainName ");
        query.append("FROM room r ");
        query.append("JOIN hotel h ON r.hotelID = h.id ");
        query.append("JOIN owns o ON h.id = o.hotelID ");
        query.append("WHERE 1=1 ");

        if (city != null && !city.isEmpty()) {
            query.append("AND h.address LIKE '%").append(city).append("%' ");
        }


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
            query.append("AND o.chainName = '").append(hotelChain).append("' ");
        }
        if (category != null && !category.isEmpty()) {
            query.append("AND h.category = '").append(category).append("' ");
        }

        // Exclude rooms that are already booked
        if (checkInDate != null && !checkInDate.isEmpty() && checkOutDate != null && !checkOutDate.isEmpty()) {
            query.append("AND r.roomNumber NOT IN ( ");
            query.append("SELECT res.roomNumber FROM reserves res ");
            query.append("JOIN booking b ON res.bookingID = b.bookingID ");
            query.append("WHERE b.checkInDate <= '").append(checkOutDate).append("' ");
            query.append("AND b.checkOutDate >= '").append(checkInDate).append("') ");
        }

        // Exclude rooms that are already rented
        if (checkInDate != null && !checkInDate.isEmpty() && checkOutDate != null && !checkOutDate.isEmpty()) {
            query.append("AND r.roomNumber NOT IN ( ");
            query.append("SELECT occ.roomNumber FROM occupies occ ");
            query.append("JOIN renting rent ON occ.rentingID = rent.rentingID ");
            query.append("WHERE rent.checkInDate <= '").append(checkOutDate).append("' ");
            query.append("AND rent.checkOutDate >= '").append(checkInDate).append("') ");
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

    public static Room getRoomInformationByBookingID(String bookingID) {
        Room room = null;

        String query = "SELECT * FROM room WHERE roomnumber IN (SELECT roomnumber FROM reserves WHERE bookingID = ?)";
        logger.info("SQL Query: " + query);

        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, bookingID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    room = new Room(
                            rs.getString("hotelID"),
                            rs.getInt("roomNumber"),
                            rs.getInt("capacity"),
                            rs.getFloat("price"),
                            rs.getString("view"),
                            rs.getString("amenity"),
                            rs.getBoolean("knownIssues"),
                            rs.getBoolean("extendable")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return room;
    }

    public static Room getRoomByBookingID(String bookingID) {
        Room room = null;

        String query = "SELECT r.* FROM room r " +
                "JOIN reserves res ON r.hotelID = res.hotelID AND r.roomNumber = res.roomNumber " +
                "WHERE res.bookingID = ?";

        logger.info("SQL Query: " + query);

        try (Connection conn = Connectiondb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, bookingID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    room = new Room(
                            rs.getString("hotelID"),
                            rs.getInt("roomNumber"),
                            rs.getInt("capacity"),
                            rs.getFloat("price"),
                            rs.getString("view"),
                            rs.getString("amenity"),
                            rs.getBoolean("knownIssues"),
                            rs.getBoolean("extendable")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println(room.getRoomNumber());
        return room;
    }

}