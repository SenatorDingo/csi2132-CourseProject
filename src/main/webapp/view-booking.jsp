<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="code.Booking" %>
<%@ page import="code.Room" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Bookings</title>
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
    <h2>Your Bookings</h2>

    <%
        Booking booking = (Booking) request.getAttribute("booking");
        Room room = (Room) request.getAttribute("Room");

        if (booking == null) {
    %>
        <p class="no-bookings">No bookings found for this customer.</p>
    <%
        } else {
    %>
        <table>
            <tr>
                <th>Booking ID</th>
                <th>Hotel ID</th>
                <th>Room Number</th>
                <th>Check-in Date</th>
                <th>Check-out Date</th>
                <th>Price</th>
            </tr>
            <tr>
                <td><%= booking.getBookingID() %></td>
                <td><%= request.getAttribute("hotelID") %></td>
                <td><%= request.getAttribute("roomNumber") %></td>
                <td><%= booking.getCheckInDate() %></td>
                <td><%= booking.getCheckOutDate() %></td>
                <td><%= request.getAttribute("price") %></td>
            </tr>
        </table>
    <%
        }
    %>

    <a href="search.jsp" class="back-button">Back to Search</a>
</div>

