<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Rooms</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .stars {
            display: flex;
            justify-content: flex-start;
            gap: 5px;
        }

        .stars input {
            display: none;
        }

        .stars label {
            font-size: 2rem;
            color: #ccc;
            cursor: pointer;
        }

        .stars input:checked ~ label {
            color: gold;
        }

        .stars input:hover ~ label {
            color: gold;
        }

        .stars input:checked:hover ~ label,
        .stars input:hover:checked ~ label {
            color: gold;
        }

        .stars input:nth-of-type(1):checked ~ label:nth-of-type(1),
        .stars input:nth-of-type(2):checked ~ label:nth-of-type(2),
        .stars input:nth-of-type(3):checked ~ label:nth-of-type(3),
        .stars input:nth-of-type(4):checked ~ label:nth-of-type(4),
        .stars input:nth-of-type(5):checked ~ label:nth-of-type(5) {
            color: gold;
        }

        .banner {
            padding: 10px;
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <%
            String customerID = request.getParameter("customerID");
            String registered = request.getParameter("registered");
            if (customerID != null && registered != null) {
                String message = "true".equals(registered) ? "Registration Successful. Logged in as Customer ID: " + customerID : "Login Successful. Logged in as Customer ID: " + customerID;
        %>
                <div class="banner">
                    <%= message %>
                </div>
        <%
            }
        %>
        <h2 class="mb-4">Search for a Room</h2>
        <form action="RoomSearchServlet" method="POST">
            <input type="hidden" name="customerID" value="<%= customerID %>">
            <div class="mb-3">
                <label for="capacity" class="form-label">Room Capacity:</label>
                <input type="number" name="capacity" id="capacity" class="form-control" placeholder="Enter capacity">
            </div>

            <div class="mb-3">
                <label class="view">View:</label><br>
                <input type="radio" name="view" value="mountainView" id="mountainView">
                <label for="mountainView">Mountain View</label><br>

                <input type="radio" name="view" value="oceanView" id="oceanView">
                <label for="oceanView">Ocean View</label><br>

                <input type="radio" name="view" value="both" id="both">
                <label for="both">Both</label><br>

                <input type="radio" name="view" value="neither" id="neither">
                <label for="neither">Neither</label><br>
            </div>

            <div class="mb-3">
                <label class="amenity">Amenity:</label><br>
                <input type="radio" name="amenity" value="tv" id="tv">
                <label for="tv">TV</label><br>

                <input type="radio" name="amenity" value="fridge" id="fridge">
                <label for="fridge">Fridge</label><br>

                <input type="radio" name="amenity" value="heating" id="heating">
                <label for="heating">Heating</label><br>

                <input type="radio" name="microwave" value="microwave" id="microwave">
                <label for="microwave">Microwave</label><br>

                <input type="radio" name="airCondition" value="airCondition" id="airCondition">
                <label for="airCondition">Air Condition</label><br>
            </div>

            <div class="mb-3">
                <label for="maxPrice" class="form-label">Max Price ($):</label>
                <input type="number" name="maxPrice" id="maxPrice" class="form-control" placeholder="Enter maximum price">
            </div>

            <div class="mb-3">
                <label for="hotelChain" class="form-label">Hotel Chain:</label>
                <select name="hotelChain" id="hotelChain" class="form-control">
                    <option value="">Select Hotel Chain</option>
                    <option value="Holiday Inn">Holiday Inn</option>
                    <option value="Best Western">Best Western</option>
                    <option value="Swiss Hotel">Swiss Hotel</option>
                    <option value="Hilton Garden Inn">Hilton Garden Inn</option>
                    <option value="Double Tree">Double Tree</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="category" class="form-label">Hotel Category:</label>
                <select name="category" id="category" class="form-control">
                    <option value="" selected>Select Category</option>
                    <option value="Motel">Motel</option>
                    <option value="Business">Business</option>
                    <option value="Airport">Airport</option>
                    <option value="Hotel">Hotel</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="checkInDate" class="form-label">Check-In Date:</label>
                <input type="date" name="checkInDate" id="checkInDate" class="form-control">
            </div>

            <div class="mb-3">
                <label for="checkOutDate" class="form-label">Check-Out Date:</label>
                <input type="date" name="checkOutDate" id="checkOutDate" class="form-control">
            </div>
            <div class="mb-3"><label for="city" class="form-label">City:</label>
                <select name="city" id="city"
                        class="form-control">
                    <option value="" selected>Select City</option>
                    <option value="Toronto">Toronto</option>
                    <option value="Ottawa">Ottawa</option>
                    <option value="Sandy Hill">Sandy Hill</option>
                    <option value="Rockford">Rockford</option>
                    <option value="Appleton">Appleton</option>
                    <option value="Vancouver">Vancouver</option>
                    <option value="San Louis">San Louis</option>
                    <option value="Montreal">Montreal</option>
                </select></div>

            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>
</body>
</html>
