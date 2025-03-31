<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="code.Booking, code.Customer, code.Room" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Check-In</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-primary bg-gradient">
        <div class="container">
            <a class="navbar-brand" href="#">e-Hotels</a>
            <a href="ViewBookingEmployeeServlet?employeeID=<%= request.getAttribute("employeeID") %>" class="btn btn-light">Bookings</a>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="jumbotron bg-primary text-white p-4 rounded-3 text-center">
            <h1 class="display-6">Check In</h1>
        </div>
        <%
            Booking booking = (Booking) request.getAttribute("booking");
            Customer customer = (Customer) request.getAttribute("customer");
            Room room = (Room) request.getAttribute("room");

            // Individual null checks
            if (booking == null) {
        %>
            <div class="alert alert-danger" role="alert">Error: Booking details are not available.</div>
        <%
            } else if (room == null) {
        %>
            <div class="alert alert-danger" role="alert">Error: Room details are not available.</div>
        <%
            } else if (customer == null) {
        %>
            <div class="alert alert-danger" role="alert">Error: Customer details are not available.</div>
        <%
            } else {
        %>
    </div>
    <div class="container mt-5 col-md-4">
        <div class="card">
            <div class="card-body">
                <form action="CheckInServlet" method="post">
                    <input type="hidden" name="bookingID" value="<%= booking.getBookingID() %>">
                    <input type="hidden" name="employeeID" value="<%= request.getAttribute("employeeID") %>">

                    <div class="mb-3 row">
                        <label class="col-sm-6 col-form-label"><strong>Customer Name:</strong></label>
                        <div class="col-sm-6">
                            <p class="form-control-plaintext"><%= customer.getName() %></p>
                        </div>
                    </div>

                    <div class="mb-3 row">
                        <label class="col-sm-6 col-form-label"><strong>Room Number:</strong></label>
                        <div class="col-sm-6">
                            <p class="form-control-plaintext"><%= room.getRoomNumber() %></p>
                        </div>
                    </div>

                    <div class="mb-3 row">
                        <label class="col-sm-6 col-form-label"><strong>Check-in Date:</strong></label>
                        <div class="col-sm-6">
                            <p class="form-control-plaintext"><%= booking.getCheckInDate() %></p>
                        </div>
                    </div>

                    <div class="mb-3 row">
                        <label class="col-sm-6 col-form-label"><strong>Check-out Date:</strong></label>
                        <div class="col-sm-6">
                            <p class="form-control-plaintext"><%= booking.getCheckOutDate() %></p>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="paymentMethod" class="form-label">Payment Method:</label>
                        <select class="form-select" name="paymentMethod" required>
                            <option value="Debit">Debit</option>
                            <option value="Credit">Credit</option>
                            <option value="Cash">Cash</option>
                        </select>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Confirm Check-In</button>
                    </div>
                </form>
            </div>
        </div>

        <%
            } // End of else for all checks
        %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap
</body>
</html>