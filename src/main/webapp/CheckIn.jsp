<%@ page import="code.Booking" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: katel
  Date: 2025-03-29
  Time: 12:25 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Check In</title>
</head>
<body>
<%--maybe add a search for the is or last naem here--%>
<div class="container mt-5">
    <h2>All Bookings</h2>
    <div id="resultsContainer">
        <%
            List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
            if (bookings != null && !bookings.isEmpty()) {
                for (Booking booking : bookings) {
        %>
        <div class="card mb-3">
            <div class="card-body">
                <h5 class="card-title">Booking ID: <%= booking.getId() %></h5>
                <p class="card-text">Customer ID: <%= booking.getCustomerID() %> persons</p>
                <p class="card-text">Check In Date: <%= booking.getCheckInDate() %></p>
                <p class="card-text">Check Out Date: <%= booking.getCheckOutDate() %></p>
                <a href="CheckedIn.jsp?roomId=<%= booking.getId() %>" class="btn btn-success">Book Now</a>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <p class="text-center text-muted">No Bookings at the moment.</p>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
