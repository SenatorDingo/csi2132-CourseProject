package code;

public class Hotel {
    private String id;
    private String name;
    private String address;
    private String email;
    private int phone;
    private int numRooms;
    private String category;


    public Hotel(String id, String name, String address, String email, int phone, int numRooms, String category) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.email = email;
        this.phone = phone;
        this.numRooms = numRooms;
        this.category = category;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
        this.phone = phone;
    }

    public int getNumRooms() {
        return numRooms;
    }

    public void setNumRooms(int numRooms) {
        this.numRooms = numRooms;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }


    @Override
    public String toString() {
        return "Hotel{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", email='" + email + '\'' +
                ", phone=" + phone +
                ", numRooms=" + numRooms +
                ", category='" + category + '\'' +
                '}';
    }

    public String toStringWA() {
        return "<ul>" +
                "<li> id=" + id + "</li>" +
                "<li> name='" + name + "</li>" +
                "<li> address='" + address + "</li>" +
                "<li> email='" + email + "</li>" +
                "<li> phone=" + phone + "</li>" +
                "<li> numRooms=" + numRooms +"</li>" +
                "<li> category='" + category + "</li>" ;
    }
}
