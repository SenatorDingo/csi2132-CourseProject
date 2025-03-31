<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Booking System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Hotel Booking</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="search.jsp">Search Rooms</a></li>
                    <li class="nav-item"><a class="nav-link" href="customer-login.jsp">Customer Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="employee-login.jsp">Employee Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="customer-login.jsp?origin=view-bookings">View Bookings</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5 text-center">
        <h1>Welcome to the Hotel Booking System</h1>
        <p>Find and book your perfect room with ease.</p>
        <a href="customer-login.jsp" class="btn btn-primary">Customer</a>
        <a href="employee-login.jsp" class="btn btn-primary">Employee</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
