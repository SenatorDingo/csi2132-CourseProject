package code.Servlets;

import code.dataAccessObjects.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class CustomerLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerID = request.getParameter("customerID");

        boolean isValid = CustomerDAO.validateCustomer(customerID);

        if (isValid) {
            request.getSession().setAttribute("customerID", customerID);
            response.sendRedirect("welcome.jsp");
        } else {
            response.sendRedirect("loginFail.jsp");
        }
    }
}
