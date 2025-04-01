<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Room Booking</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
            <a class="navbar-brand" href="index.jsp">e-Hotels</a>
            <a href="index.jsp" class="btn btn-light">Home</a>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card booking-card">
                    <div class="card-body">
                        <h2 class="text-center text-primary">Confirm Your Booking</h2>

                        <%
                            String roomNumber = request.getParameter("roomNumber");
                            String customerID = request.getParameter("customerID");
                            String hotelID = request.getParameter("hotelID");

                            if (roomNumber == null || customerID == null || hotelID == null) {
                        %>
                            <div class="alert alert-danger text-center">
                                Missing booking details. Please go back and try again.
                            </div>
                        <% } else { %>
                            <form action="BookingServlet" method="post">
                                <input type="hidden" name="roomNumber" value="<%= roomNumber %>">
                                <input type="hidden" name="customerID" value="<%= customerID %>">
                                <input type="hidden" name="hotelID" value="<%= hotelID %>">

                                <div class="mb-3">
                                    <label for="checkInDate" class="form-label">Check-In Date</label>
                                    <input type="date" id="checkInDate" name="checkInDate" class="form-control" required>
                                </div>

                                <div class="mb-3">
                                    <label for="checkOutDate" class="form-label">Check-Out Date</label>
                                    <input type="date" id="checkOutDate" name="checkOutDate" class="form-control" required>
                                </div>

                                <button type="submit" class="btn btn-success w-100">Confirm Booking</button>
                            </form>
                        <% } %>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
