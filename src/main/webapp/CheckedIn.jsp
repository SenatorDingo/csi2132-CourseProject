<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="code.Booking" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Checked-In Room Information</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Checked-In Room Details</h2>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <%
            <%
            Booking booking = (Booking) request.getAttribute("checkedInBooking");
            if (booking != null) {
            %>
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title">Booking ID: <%= booking.getId() %></h5>
                    <p class="card-text">Customer ID: <%= booking.getCustomerID() %> persons</p>
                    <p class="card-text">Check In Date: <%= booking.getCheckInDate() %></p>
                    <p class="card-text">Check Out Date: <%= booking.getCheckOutDate() %></p>
                    <a href="CheckedIn.jsp?roomId=<%= booking.getId() %>" class="btn btn-success">Book Now</a>
                </div>
            </div>
            <%

            } else {
            %>
            <p class="text-center text-muted">No rooms found for the selected criteria.</p>
            <%
                }
            %>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
