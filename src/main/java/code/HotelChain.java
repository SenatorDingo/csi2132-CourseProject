package code;

public class HotelChain {
    private String chainName;
    private String Address;
    private int numHotels;
    private String email;
    private int phone;

    //Constructor
    public HotelChain(String chainName, String address, int numHotels, String email, int phone) {
        this.chainName = chainName;
        Address = address;
        this.numHotels = numHotels;
        this.email = email;
        this.phone = phone;
    }

    //getters & setters
    public String getChainName() {
        return chainName;
    }

    public void setChainName(String chainName) {
        this.chainName = chainName;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String address) {
        Address = address;
    }

    public int getNumHotels() {
        return numHotels;
    }

    public void setNumHotels(int numHotels) {
        this.numHotels = numHotels;
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
    //toString method
    @Override
    public String toString() {
        return "HotelChain{" +
                "chainName='" + chainName + '\'' +
                ", Address='" + Address + '\'' +
                ", numHotels=" + numHotels +
                ", email='" + email + '\'' +
                ", phone=" + phone +
                '}';
    }
    public String toStringWA() {
        return "<ul>" +
                "<li> chainName=" + chainName + "</li>" +
                "<li>Address=" + Address + "</li>" +
                "<li> numHotels=" + numHotels + "</li>" +
                "<li> email='" + email + "</li>" +
                "<li> phone=" + phone +"</li>";
    }


}
