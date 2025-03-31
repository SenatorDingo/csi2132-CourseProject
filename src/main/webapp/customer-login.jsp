<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>

        .login-card {
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-dark bg-primary bg-gradient mb-4">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Hotel Booking</a>
            <a href="index.jsp" class="btn btn-light">Home</a>
        </div>
    </nav>

    <div class="container mt 4">
        <div class="jumbotron bg-primary text-white p-5 rounded-3">
            <h1 class="display-4">Log In</h1>
            <p class="lead">Access your account</p>
        </div>

        <div class="row justify-content-center mt-4">
            <div class="col-md-4">
                <div class="card login-card">
                    <form action="CustomerLoginServlet" method="post">
                        <input type="hidden" name="origin" value="<%= request.getParameter("origin") %>">
                        <div class="mb-3">
                            <label for="customerID" class="form-label">Customer ID</label>
                            <input type="text" class="form-control" id="customerID" name="customerID" required>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Login</button>
                    </form>
                    <div class="text-center mt-3">
                        <a href="customer-register.jsp">New customer? Register here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
