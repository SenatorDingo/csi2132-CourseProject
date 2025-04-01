<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map" %>
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
            <div class="col-md-10">
                <div class="card booking-card">
                    <%
                        List<Map<String, Object>> bookingDetails = (List<Map<String, Object>>) request.getAttribute("bookingDetails");

                        boolean hasValidBookings = false;

                        if (bookingDetails != null) {
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
                                <%
                                    for (Map<String, Object> details : bookingDetails) {
                                        code.Booking booking = (code.Booking) details.get("booking");
                                        String roomNumber = String.valueOf(details.get("roomNumber"));
                                        String hotelID = String.valueOf(details.get("hotelID"));
                                        String price = String.valueOf(details.get("price"));

                                        // Skip booking if any field is "N/A"
                                        if ("N/A".equalsIgnoreCase(roomNumber) ||
                                            "N/A".equalsIgnoreCase(hotelID) ||
                                            "N/A".equalsIgnoreCase(price)) {
                                            continue;
                                        }

                                        hasValidBookings = true;
                                %>
                                <tr>
                                    <td><%= booking.getBookingID() %></td>
                                    <td><%= hotelID %></td>
                                    <td><%= roomNumber %></td>
                                    <td><%= booking.getCheckInDate() %></td>
                                    <td><%= booking.getCheckOutDate() %></td>
                                    <td>$<%= price %></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    <%
                        }

                        if (!hasValidBookings) {
                    %>
                        <p class="text-danger text-center fw-bold">No valid bookings found for this customer.</p>
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
