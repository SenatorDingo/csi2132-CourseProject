<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Rooms</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Search for a Room</h2>
        <form action="RoomSearchServlet" method="POST">
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
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>
</body>
</html>
