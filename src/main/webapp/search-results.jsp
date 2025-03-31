<%@ page import="java.util.List" %>
<%@ page import="code.Room" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <%
            String customerID = (String) request.getAttribute("customerID");
            if (!"null".equals(customerID) && customerID != null && !customerID.isEmpty()) {
        %>
                <div class="alert alert-info">
                    Logged in as Customer ID: <%= customerID %>
                </div>
        <%
            } else {
        %>
                <div class="alert alert-warning">
                    Not logged in.
                </div>
        <%
            }
        %>

        <h2>Room Search Results</h2>
        <div id="resultsContainer">
            <%
                List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                if (rooms != null && !rooms.isEmpty()) {
                    for (Room room : rooms) {
            %>
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title">Room #<%= room.getRoomNumber() %></h5>
                    <p class="card-text">Capacity: <%= room.getCapacity() %> persons</p>
                    <p class="card-text">View: <%= room.getView() %></p>
                    <p class="card-text">Amenity: <%= room.getAmenity() %></p>
                    <p class="card-text">Price: $<%= room.getPrice() %> per night</p>
                    <%
                    String customerId = request.getParameter("customerID");
                    if ("null".equals(customerId)) {
                    %>
                        <a href="customer-register.jsp" class="btn btn-warning">Log In</a>
                    <%
                    } else {
                    %>
                        <a href="booking.jsp?roomNumber=<%= room.getRoomNumber() %>&customerID=<%= customerId %>&hotelID=<%= room.getId() %>" class="btn btn-success">Book Now</a>
                    <%
                    }
                    %>
                </div>

            </div>
            <%
                    }
                } else {
            %>
            <p class="text-center text-muted">No rooms found for the selected criteria.</p>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
