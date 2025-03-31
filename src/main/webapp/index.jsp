<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Booking System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
        }
        .hero {
            background-image: url(images/toronto.jpg);
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
        }
    </style>
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

    <div class="hero">
        <div class="p-5 bg-dark bg-opacity-70 rounded-3">
            <h1 class="display-3">Welcome to the Hotel Booking System</h1>
            <p class="lead">Find and book your perfect room with ease.</p>
            <a href="customer-login.jsp" class="btn btn-light btn-lg me-2">Customer</a>
            <a href="employee-login.jsp" class="btn btn-light btn-lg">Employee</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
