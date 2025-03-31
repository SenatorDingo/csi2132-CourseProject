<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .register-card {
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
            <a class="navbar-brand" href="index.jsp">e-Hotels</a>
            <a href="index.jsp" class="btn btn-light">Home</a>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="jumbotron bg-primary text-white p-4 rounded-3 text-center">
            <h1 class="display-6">Customer Registration</h1>
        </div>

        <div class="row justify-content-center mt-4">
            <div class="col-md-6">
                <div class="card register-card">
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
                                <option value="photoCard">Photo Card</option>
                                <option value="driversLicence">Driver's License</option>
                                <option value="passport">Passport</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-success w-100">Register</button>
                    </form>
                    <div class="text-center mt-3">
                        <a href="customer-login.jsp">Already have an account? Login here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>