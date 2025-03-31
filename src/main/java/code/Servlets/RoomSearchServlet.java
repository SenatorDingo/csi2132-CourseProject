package code.Servlets;

import code.Room;
import code.dataAccessObjects.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

@WebServlet("/RoomSearchServlet")
public class RoomSearchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String capacity = request.getParameter("capacity");
        String view = request.getParameter("view");
        String amenity = request.getParameter("amenity");
        String maxPrice = request.getParameter("maxPrice");
        String hotelChain = request.getParameter("hotelChain");
        String category = request.getParameter("category");
        String checkInDate = request.getParameter("checkInDate");
        String checkOutDate = request.getParameter("checkOutDate");
        String customerID = request.getParameter("customerID");

        List<Room> rooms = RoomDAO.searchRooms(capacity, view, amenity, maxPrice, hotelChain, category, checkInDate, checkOutDate);

        request.setAttribute("rooms", rooms);

        request.setAttribute("customerID", customerID);
        System.out.println(Objects.equals(customerID, "null"));
        request.getRequestDispatcher("search-results.jsp").forward(request, response);
    }
}
