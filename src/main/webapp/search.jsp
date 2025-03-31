<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Rooms</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
    <nav class="navbar navbar-dark bg-primary bg-gradient">
        <div class="container">
            <a class="navbar-brand">e-Hotels</a>
            <a href="index.jsp" class="btn btn-light">Home</a>
        </div>
    </nav>

    <div class="container mt-4">


        <div class="jumbotron bg-primary text-white p-5 rounded-3">
            <h1 class="display-4">Search for a Room</h1>
            <p class="lead">Find the perfect room for your stay.</p>
        </div>

        <%
            String customerID = request.getParameter("customerID");
            String registered = request.getParameter("registered");
            if (customerID != null && registered != null) {
                String message = "true".equals(registered) ?
                    "Registration Successful. Logged in as Customer ID: " + customerID :
                    "Login Successful. Logged in as Customer ID: " + customerID;
        %>
            <div class="alert alert-success text-center mt-4">
                <%= message %>
            </div>
        <% } %>

        <form action="RoomSearchServlet" method="POST" class="mt-4">
            <input type="hidden" name="customerID" value="<%= customerID %>">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Room Capacity</h5>
                            <input type="number" name="capacity" class="form-control" placeholder="Enter capacity">
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">View</h5>
                            <select name="view" class="form-control">
                                <option value="">Select View</option>
                                <option value="mountainView">Mountain View</option>
                                <option value="oceanView">Ocean View</option>
                                <option value="both">Both</option>
                                <option value="neither">Neither</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Amenity</h5>
                            <select name="amenity" class="form-control">
                                <option value="">Select Amenity</option>
                                <option value="tv">TV</option>
                                <option value="fridge">Fridge</option>
                                <option value="heating">Heating</option>
                                <option value="microwave">Microwave</option>
                                <option value="airCondition">Air Condition</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Max Price ($)</h5>
                            <input type="number" name="maxPrice" class="form-control" placeholder="Enter max price">
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Hotel Chain</h5>
                            <select name="hotelChain" class="form-control">
                                <option value="">Select Hotel Chain</option>
                                <option value="Holiday Inn">Holiday Inn</option>
                                <option value="Best Western">Best Western</option>
                                <option value="Swiss Hotel">Swiss Hotel</option>
                                <option value="Hilton Garden Inn">Hilton Garden Inn</option>
                                <option value="Double Tree">Double Tree</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Hotel Category</h5>
                            <select name="category" class="form-control">
                                <option value="">Select Category</option>
                                <option value="Motel">Motel</option>
                                <option value="Business">Business</option>
                                <option value="Airport">Airport</option>
                                <option value="Hotel">Hotel</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Check-In Date</h5>
                            <input type="date" name="checkInDate" class="form-control">
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Check-Out Date</h5>
                            <input type="date" name="checkOutDate" class="form-control">
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">City</h5>
                            <select name="city" class="form-control">
                                <option value="">Select City</option>
                                <option value="Toronto">Toronto</option>
                                <option value="Ottawa">Ottawa</option>
                                <option value="Sandy Hill">Sandy Hill</option>
                                <option value="Rockford">Rockford</option>
                                <option value="Appleton">Appleton</option>
                                <option value="Vancouver">Vancouver</option>
                                <option value="San Louis">San Louis</option>
                                <option value="Montreal">Montreal</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-primary btn-lg">Search</button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
