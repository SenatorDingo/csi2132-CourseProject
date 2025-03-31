package code.Servlets;

import code.dataAccessObjects.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerID = request.getParameter("customerID");

        boolean isValid = CustomerDAO.validateCustomer(customerID);

        if (isValid) {
            response.sendRedirect("search.jsp?customerID=" + customerID + "&registered=false");
        } else {
            response.sendRedirect("booking-failure.jsp");
        }
    }
}
