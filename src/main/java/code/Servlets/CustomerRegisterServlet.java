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

@WebServlet("/register")
public class CustomerRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerID = request.getParameter("customerID");
        String name = request.getParameter("name");
        String idType = request.getParameter("idType");
        String address = request.getParameter("address");
        Date dateOfRegistration = new Date(System.currentTimeMillis());

        Customer customer = new Customer(customerID, name, idType, dateOfRegistration, address);
        boolean success = CustomerDAO.addCustomer(customer);

        if (success) {
            response.sendRedirect("registerSuccess.jsp");
        } else {
            response.sendRedirect("registerFail.jsp");
        }
    }
}


