<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="code.Booking" %>
<%@ page import="code.Room" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .booking-card {
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-dark bg-primary bg-gradient mb-4">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">e-Hotels</a>
            <a href="index.jsp" class="btn btn-light">Home</a>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="jumbotron bg-primary text-white p-4 rounded-3 text-center">
            <h1 class="display-6">Your Bookings</h1>
        </div>

        <div class="row justify-content-center mt-4">
            <div class="col-md-8">
                <div class="card booking-card">
                    <%
                        Booking booking = (Booking) request.getAttribute("booking");

                        if (booking == null) {
                    %>
                        <p class="text-danger text-center fw-bold">No bookings found for this customer.</p>
                    <%
                        } else {
                    %>
                        <table class="table table-striped table-bordered">
                            <thead class="table-primary">
                                <tr>
                                    <th>Booking ID</th>
                                    <th>Hotel ID</th>
                                    <th>Room Number</th>
                                    <th>Check-in Date</th>
                                    <th>Check-out Date</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><%= booking.getBookingID() %></td>
                                    <td><%= request.getAttribute("hotelID") %></td>
                                    <td><%= request.getAttribute("roomNumber") %></td>
                                    <td><%= booking.getCheckInDate() %></td>
                                    <td><%= booking.getCheckOutDate() %></td>
                                    <td>$<%= request.getAttribute("price") %></td>
                                </tr>
                            </tbody>
                        </table>
                    <%
                        }
                    %>
                    <div class="text-center mt-3">
                        <a href="search.jsp" class="btn btn-primary">Back to Search</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
