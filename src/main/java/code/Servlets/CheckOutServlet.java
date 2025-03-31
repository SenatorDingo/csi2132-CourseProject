package code.Servlets;

import code.dataAccessObjects.RentingDAO;
import java.io.IOException;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/CheckOutServlet")
public class CheckOutServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(CheckOutServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rentingID = request.getParameter("rentingID");
        String employeeID = request.getParameter("employeeID");

        if (rentingID == null || rentingID.isEmpty() || employeeID == null || employeeID.isEmpty()) {
            logger.warning("Missing parameters for checkout.");
            response.sendRedirect("ViewEmployeeRentingServlet?employeeID=" + employeeID);
            return;
        }

        boolean success = RentingDAO.removeRenting(rentingID);

        if (success) {
            logger.info("Successfully checked out renting ID: " + rentingID);
        } else {
            logger.severe("Failed to check out renting ID: " + rentingID);
        }

        response.sendRedirect("ViewEmployeeRentingServlet?employeeID=" + employeeID);
    }
}
