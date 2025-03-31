package code.Servlets;

import code.dataAccessObjects.CustomerDAO;
import code.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/CustomerRegisterServlet")
public class CustomerRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("fullName");
        String idType = request.getParameter("idType");
        String address = request.getParameter("address");

        String customerID = java.util.UUID.randomUUID().toString();

        Customer customer = new Customer(customerID, name, idType, address);
        boolean success = CustomerDAO.addCustomer(customer);

        if (success) {
            response.sendRedirect("search.jsp?customerID=" + customerID + "&registered=true");
        } else {
            response.sendRedirect("booking-failure.jsp");
        }
    }

}

