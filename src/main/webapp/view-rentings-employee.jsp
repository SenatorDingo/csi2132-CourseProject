<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="code.Renting" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Hotel Rentings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
    String employeeID = request.getParameter("employeeID");
    List<Renting> rentings = (List<Renting>) request.getAttribute("rentings");
%>

<nav class="navbar navbar-dark bg-primary bg-gradient">
    <div class="container">
        <a class="navbar-brand">Hotel Management</a>
        <div class="ms-auto">
            <a href="index.jsp" class="btn btn-light">Home</a>
            <a href="view-bookings-employee.jsp?employeeID=<%= employeeID %>" class="btn btn-light">Bookings</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="jumbotron bg-primary text-white p-4 rounded-3 text-center">
        <h1 class="display-6">Rentings for Your Hotel</h1>
    </div>

    <% if (rentings == null || rentings.isEmpty()) { %>
        <div class="alert alert-danger text-center mt-4" role="alert">
            No Rentings found for your hotel.
        </div>
    <% } else { %>
        <div class="table-responsive mt-4">
            <table class="table table-striped table-hover">
                <thead class="table-primary">
                <tr>
                    <th>Renting ID</th>
                    <th>Check-in Date</th>
                    <th>Check-out Date</th>
                    <th>Payment Method</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <% for (Renting rent : rentings) { %>
                    <tr>
                        <td><%= rent.getRentingID() %></td>
                        <td><%= rent.getCheckInDate() %></td>
                        <td><%= rent.getCheckOutDate() %></td>
                        <td><%= rent.getPaymentMethod() %></td>
                        <td>
                            <a href="CheckOutServlet?rentingID=<%= rent.getRentingID() %>&employeeID=<%= employeeID %>" class="btn btn-danger btn-sm">
                                Check Out
                            </a>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    <% } %>

    <div class="text-center mt-4">
        <a href="index.jsp" class="btn btn-secondary">Back</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
