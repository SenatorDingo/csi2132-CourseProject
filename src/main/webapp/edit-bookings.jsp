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
</head>
<body>
<h1>Edit Booking</h1>
<%

    String bookingID = request.getParameter("book");
    Booking b = BookingDAO.getBookingBasedOnID(bookingID);

    if (b != null) {
%>
<p>Booking ID: <%= bookingID %></p>
<form action="EditBookingsServlet" method="post">
    <input type="hidden" name="bookingID" value="<%= bookingID %>" />

    <label for="checkInDate">Check-In Date:</label>
    <input type="date" id="checkInDate" name="checkInDate" required value="<%=b.getCheckInDate()%>"/>

    <label for="checkOutDate">Check-Out Date:</label>
    <input type="date" id="checkOutDate" name="checkOutDate" required value="<%=b.getCheckOutDate()%>"/>

    <input type="submit" value="Update Booking" />
</form>
<button>Cancel Booking</button>
<%
} else {
%>
<p>No booking selected. Please select a booking to edit.</p>
<%
    }
%>
</body>
</html>
