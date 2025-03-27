package code;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/RoomSearchServlet")
public class RoomSearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String capacity = request.getParameter("capacity");
        String view = request.getParameter("view");
        String amenity = request.getParameter("amenity");
        String maxPrice = request.getParameter("maxPrice");

        List<Room> rooms = RoomDAO.searchRooms(capacity, view, amenity, maxPrice);
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("search-results.jsp").forward(request, response);
    }
}
