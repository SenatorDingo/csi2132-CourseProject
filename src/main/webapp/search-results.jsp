<%@ page import="java.util.List" %>
<%@ page import="code.Room" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-dark bg-primary bg-gradient">
        <div class="container">
            <a class="navbar-brand">e-Hotels</a>
            <div>
                <a href="index.jsp" class="btn btn-light">Home</a>
                <a href="search.jsp" class="btn btn-light">Search</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">

        <!-- Jumbotron -->
        <div class="jumbotron bg-primary text-white p-5 rounded-3">
            <h1 class="display-4">Search Results</h1>
            <p class="lead">Here are the available rooms based on your criteria.</p>
        </div>

        <!-- Customer Info -->
        <%
            String customerID = (String) request.getAttribute("customerID");
            if (customerID != null && !customerID.isEmpty() && !"null".equals(customerID)) {
        %>
            <div class="alert alert-info text-center mt-4">
                Logged in as Customer ID: <%= customerID %>
            </div>
        <%
            } else {
        %>
            <div class="alert alert-warning text-center mt-4">
                Not logged in.
            </div>
        <%
            }
        %>

        <!-- Results -->
        <div class="mt-4">
            <%
                List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                if (rooms != null && !rooms.isEmpty()) {
            %>
                <div class="row">
                    <% for (Room room : rooms) {
                        String viewIcon = "";
                        switch (room.getView()) {
                            case "mountainView":
                                viewIcon = "bi bi-tree-fill";
                                break;
                            case "oceanView":
                                viewIcon = "bi bi-water";
                                break;
                            case "both":
                                viewIcon = "bi bi-tree-fill bi-water";
                                break;
                            default:
                                viewIcon = "bi bi-eye-slash";
                        }

                        String amenityIcon = "";
                        switch (room.getAmenity()) {
                            case "tv":
                                amenityIcon = "bi bi-tv";
                                break;
                            case "fridge":
                                amenityIcon = "bi bi-box";
                                break;
                            case "heating":
                                amenityIcon = "bi bi-thermometer-half";
                                break;
                            case "microwave":
                                amenityIcon = "bi bi-lightning";
                                break;
                            case "airCondition":
                                amenityIcon = "bi bi-wind";
                                break;
                            default:
                                amenityIcon = "bi bi-question-circle";
                        }
                    %>
                        <div class="col-md-4">
                            <div class="card mb-4 shadow-sm">
                                <div class="card-body">
                                    <h5 class="card-title">Room #<%= room.getRoomNumber() %></h5>
                                    <p class="card-text"><strong>Capacity:</strong> <%= room.getCapacity() %> persons</p>
                                    <p class="card-text">
                                        <strong>View:</strong> <i class="<%= viewIcon %>"></i> <%= room.getView() %>
                                    </p>
                                    <p class="card-text">
                                        <strong>Amenity:</strong> <i class="<%= amenityIcon %>"></i> <%= room.getAmenity() %>
                                    </p>
                                    <p class="card-text"><strong>Price:</strong> $<%= room.getPrice() %> per night</p>

                                    <%
                                        String customerId = request.getParameter("customerID");
                                        if ("null".equals(customerId) || customerId == null || customerId.isEmpty()) {
                                    %>
                                        <a href="customer-register.jsp" class="btn btn-warning w-100">Log In to Book</a>
                                    <%
                                        } else {
                                    %>
                                        <a href="booking.jsp?roomNumber=<%= room.getRoomNumber() %>&customerID=<%= customerId %>&hotelID=<%= room.getId() %>" class="btn btn-success w-100">Book Now</a>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            <%
                } else {
            %>
                <p class="text-center text-muted mt-4">No rooms found for the selected criteria.</p>
            <%
                }
            %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
