package code;
import java.sql.*;

public class Connectiondb {
    // Database connection parameters
    public static void main(String[] args) {
        try(Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/WebApp","postgres","new_password");){
            System.out.println("Connected");

            Statement stmt = db.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM employees");
            while(rs.next()){

                    System.out.print(rs.getString(3) + ", ");

            }
        }
        catch(SQLException e){
            System.out.println(e.getMessage());
        }



        

        
    }

    
    

}
