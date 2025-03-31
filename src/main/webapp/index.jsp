<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Booking System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-dark bg-primary bg-gradient">
        <div class="container">
            <a class="navbar-brand">e-Hotels</a>
            <a href="employee-login.jsp" class="btn btn-light">Employee Login</a>
        </div>
    </nav>

    <div class="hero">
        <div class="p-5 bg-primary bg-opacity-75 rounded-3 w-75">
            <h1 class="display-3">Welcome to the Hotel Booking System</h1>
            <p class="lead">Find and book your perfect room with ease.</p>

            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card bg-light text-dark">
                        <div class="card-body text-center">
                            <i class="bi bi-search display-4"></i>
                            <h5 class="card-title">Search Rooms</h5>
                            <p class="card-text">Explore available rooms and make reservations.</p>
                            <a href="search.jsp" class="btn btn-primary">Search Now</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card bg-light text-dark">
                        <div class="card-body text-center">
                            <i class="bi bi-person-fill display-4"></i>
                            <h5 class="card-title">Customer Login</h5>
                            <p class="card-text">Log in to manage your bookings and profile.</p>
                            <a href="customer-login.jsp" class="btn btn-primary">Login</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card bg-light text-dark">
                        <div class="card-body text-center">
                            <i class="bi bi-calendar-check display-4"></i>
                            <h5 class="card-title">View Bookings</h5>
                            <p class="card-text">Check your upcoming and past bookings.</p>
                            <a href="customer-login.jsp?origin=view-bookings" class="btn btn-primary">View</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
