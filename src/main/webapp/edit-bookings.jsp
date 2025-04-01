<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="code.dataAccessObjects.BookingDAO" %>
<%@ page import="code.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Booking</title>
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

    <nav class="navbar navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Hotel Booking</a>
            <a href="index.jsp" class="btn btn-light">Home</a>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="jumbotron bg-primary text-white p-4 rounded-3 text-center">
            <h1 class="display-6">Edit Booking</h1>
        </div>

        <div class="row justify-content-center mt-4">
            <div class="col-md-8">
                <div class="card booking-card">
                    <div class="card-body">
                        <%
                            String bookingID = request.getParameter("book");
                            String employeeID = request.getParameter("employeeID");
                            Booking b = BookingDAO.getBookingBasedOnID(bookingID);

                            if (b != null) {
                        %>
                        <p><strong>Booking ID:</strong> <%= bookingID %></p>

                        <form action="EditBookingsServlet" method="post">
                            <input type="hidden" name="bookingID" value="<%= bookingID %>" />
                            <input type="hidden" name="employeeID" value="<%= employeeID %>" />

                            <div class="mb-3">
                                <label for="checkInDate" class="form-label">Check-In Date:</label>
                                <input type="date" id="checkInDate" name="checkInDate" class="form-control" required value="<%= b.getCheckInDate() %>" />
                            </div>

                            <div class="mb-3">
                                <label for="checkOutDate" class="form-label">Check-Out Date:</label>
                                <input type="date" id="checkOutDate" name="checkOutDate" class="form-control" required value="<%= b.getCheckOutDate() %>" />
                            </div>

                            <button type="submit" class="btn btn-success w-100">Update Booking</button>
                        </form>

                        <form action="DeleteBookingServlet" method="post" class="mt-3">
                            <input type="hidden" name="bookingID" value="<%= bookingID %>" />
                            <input type="hidden" name="employeeID" value="<%= employeeID %>" />
                            <button type="submit" class="btn btn-danger w-100">Delete Booking</button>
                        </form>

                        <%
                            } else {
                        %>
                        <p class="text-danger text-center">No booking selected. Please select a booking to edit.</p>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
