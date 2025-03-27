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
                <label for="view" class="form-label">View:</label>
                <input type="text" name="view" id="view" class="form-control" placeholder="E.g., Sea, City, Mountain">
            </div>
            <div class="mb-3">
                <label for="amenity" class="form-label">Amenity:</label>
                <input type="text" name="amenity" id="amenity" class="form-control" placeholder="E.g., WiFi, Pool, Gym">
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
