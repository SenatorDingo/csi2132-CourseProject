<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="code.Booking" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Hotel Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-primary bg-gradient">
        <div class="container">
            <a class="navbar-brand">Hotel Management</a>
            <a href="index.jsp" class="btn btn-light">Home</a>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="jumbotron bg-primary text-white p-4 rounded-3 text-center">
            <h1 class="display-6">Bookings for Your Hotel</h1>
        </div>

        <%
            String employeeID = request.getParameter("employeeID");
            List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
            if (bookings == null || bookings.isEmpty()) {
        %>
        <div class="alert alert-danger text-center mt-4" role="alert">
            No bookings found for your hotel.
        </div>
        <%
            } else {
        %>
        <div class="table-responsive mt-4">
            <table class="table table-striped table-hover">
                <thead class="table-primary">
                    <tr>
                        <th>Booking ID</th>
                        <th>Check-in Date</th>
                        <th>Check-out Date</th>
                        <th>Check In</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Booking booking : bookings) {
                    %>
                    <tr>
                        <td><%= booking.getBookingID() %></td>
                        <td><%= booking.getCheckInDate() %></td>
                        <td><%= booking.getCheckOutDate() %></td>

                        <td><a href="CheckInServlet?book=<%= booking.getBookingID() %>&employeeID=<%= employeeID %>" class="btn btn-success btn-sm">Check In</a></td>
                        <td><a href="edit-bookings.jsp?book=<%= booking.getBookingID() %>&employeeID=<%= employeeID %>" class="btn btn-warning btn-sm">Edit</a></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <%
            }
        %>

        <div class="text-center mt-4">
            <a href="index.jsp" class="btn btn-secondary">Back</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
