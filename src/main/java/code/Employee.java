package code;

public class Employee {
    private String id;
    private String sin;
    private String firstName;
    private String lastName;
    private String middleInitials;
    private String address;
    private String email;
    //maybe make this an enum
    private String role;

    public Employee(String id, String sin, String firstName, String lastName, String middleInitials, String address, String email, String role) {
        this.id = id;
        this.sin = sin;
        this.firstName = firstName;
        this.lastName = lastName;
        this.middleInitials = middleInitials;
        this.address = address;
        this.email = email;
        this.role = role;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSin() {
        return sin;
    }

    public void setSin(String sin) {
        this.sin = sin;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getMiddleInitials() {
        return middleInitials;
    }

    public void setMiddleInitials(String middleInitials) {
        this.middleInitials = middleInitials;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "id='" + id + '\'' +
                ", sin='" + sin + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", middleInitials='" + middleInitials + '\'' +
                ", address='" + address + '\'' +
                ", email='" + email + '\'' +
                ", role='" + role + '\'' +
                '}';
    }

    public String toStringWA() {
        return "<ul>" +
                "<li> id='" + id + "</li>" +
                "<li> sin='" + sin + "</li>" +
                "<li> firstName='" + firstName +"</li>" +
                "<li> lastName='" + lastName + "</li>" +
                "<li> middleInitials='" + middleInitials + "</li>" +
                "<li> address='" + address + "</li>" +
                "<li> email='" + email + "</li>" +
                "<li> role='" + role + "</li>" ;
    }
}
