<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
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
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="search.jsp">Search Rooms</a></li>
                    <li class="nav-item"><a class="nav-link" href="customer-login.jsp">Customer Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2 class="text-center">Customer Registration</h2>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <form action="CustomerRegisterServlet" method="post">
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" required>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <input type="text" class="form-control" id="address" name="address" required>
                    </div>
                    <div class="mb-3">
                        <label for="idType" class="form-label">ID Type</label>
                        <select class="form-select" id="idType" name="idType">
                            <option value="SSN">SSN</option>
                            <option value="SIN">SIN</option>
                            <option value="Driver's License">Driver's License</option>
                        </select>
                    </div>
<%--                    send the id thougtht he paraemters of hte button --%>
                    <button type="submit" class="btn btn-success w-100">Register</button>

                </form>
                <div class="text-center mt-3">
                    <a href="customer-login.jsp">Already have an account? Login here</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
