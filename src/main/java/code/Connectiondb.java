package code;

import java.sql.*;

public class Connectiondb {
    public static Connectiondb con;

    public static void main(String[] args) throws Exception {
        try {
            con = (Connectiondb) DriverManager.getConnection("jdbc:postgresql://localhost:5432/WebApp", "postgres", "new_password");
            System.out.println("Connection established");


        } catch (SQLException e) {
            throw new Exception("Could not establish connection with the Database Server: "
                    + e.getMessage());

        }
    }


    //connecting to the db
    public Connectiondb getConnection() throws Exception {

        try {
            con = (Connectiondb) DriverManager.getConnection("jdbc:postgresql://localhost:5432/WebApp", "postgres", "new_password");
            System.out.println("Connection established");
            return con;

        } catch (SQLException e) {
            throw new Exception("Could not establish connection with the Database Server: "
                    + e.getMessage());

        }


    }

    //closing the db
    public void close() throws SQLException {
        try {
            if (con != null)
                con.close();
        } catch (SQLException e) {
            throw new SQLException("Could not close connection with the Database Server: "
                    + e.getMessage());
        }

    }


}
