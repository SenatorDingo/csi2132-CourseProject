<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="code.Booking" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Hotel Bookings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h2 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #007BFF;
            color: white;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #ccc;
        }
        .no-bookings {
            color: red;
            font-weight: bold;
        }
        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Bookings for Your Hotel</h2>

    <%
        List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
        if (bookings == null || bookings.isEmpty()) {
    %>
    <p class="no-bookings">No bookings found for your hotel.</p>
    <%
        } else {
    %>
    <table>
        <thead>
        <tr>
            <th>Booking ID</th>
            <th>Check-in Date</th>
            <th>Check-out Date</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Booking booking : bookings) {
        %>
        <tr>
            <td><%= booking.getBookingID() %></td>
            <td><%= booking.getCheckInDate() %></td>
            <td><%= booking.getCheckOutDate() %></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%
        }
    %>
    <a href="#" class="back-button">Back</a>
</div>
</body>
</html>
