<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="code.dataAccessObjects.BookingDAO" %>
<%@ page import="code.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h1 {
            color: #333;
        }
        .form-inline {
            display: flex;
            align-items: center;
            gap: 10px;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-inline label {
            margin: 0 5px;
        }
        .form-inline input[type="date"],
        .form-inline input[type="submit"] {
            padding: 5px;
            font-size: 16px;
            height: 40px;
        }
        .btn-danger {
            background-color: #c9302c;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-danger:hover {
            background-color: #b52b26;
        }
        .message {
            color: #c9302c;
            font-weight: bold;
        }
    </style>
</head>
<body>
<h1>Edit Booking</h1>
<%

    String bookingID = request.getParameter("book");
    String employeeID = request.getParameter("employeeID");
    Booking b = BookingDAO.getBookingBasedOnID(bookingID);

    if (b != null) {
%>
<p><strong>Booking ID:</strong> <%= bookingID %></p>
<form class="form-inline" action="EditBookingsServlet" method="post">
    <input type="hidden" name="bookingID" value="<%= bookingID %>" />
    <input type="hidden" name="employeeID" value="<%= employeeID %>" />

    <label for="checkInDate">Check-In Date:</label>
    <input type="date" id="checkInDate" name="checkInDate" required value="<%= b.getCheckInDate() %>" />

    <label for="checkOutDate">Check-Out Date:</label>
    <input type="date" id="checkOutDate" name="checkOutDate" required value="<%= b.getCheckOutDate() %>" />

    <input type="submit" value="Update Booking" />
</form>
<form class="form-inline" action="DeleteBookingServlet" method="post">
    <input type="hidden" name="bookingID" value="<%= bookingID %>" />
    <input type="submit" value="Delete Booking" class="btn btn-danger" />
</form>
<%
} else {
%>
<p class="message">No booking selected. Please select a booking to edit.</p>
<%
    }
%>
</body>
</html>
