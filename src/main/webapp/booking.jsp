<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Room Booking</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Confirm Your Booking</h2>
    <form action="BookingServlet" method="post">
        <input type="hidden" name="roomNumber" value="<%= request.getParameter("roomNumber") %>">
        <input type="hidden" name="customerID" value="<%= request.getParameter("customerID") %>">
        <input type="hidden" name="hotelID" value="<%= request.getParameter("hotelID") %>">



        <div class="mb-3">
            <label for="checkInDate" class="form-label">Check-In Date</label>
            <input type="date" id="checkInDate" name="checkInDate" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="checkOutDate" class="form-label">Check-Out Date</label>
            <input type="date" id="checkOutDate" name="checkOutDate" class="form-control" required>
        </div>



        <button type="submit" class="btn btn-primary">Confirm Booking</button>
    </form>
</div>
</body>
</html>
