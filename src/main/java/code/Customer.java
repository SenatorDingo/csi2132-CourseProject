package code;

import java.util.Date;

public class Customer {
    private String id;
    private String name;
    //maybe make this an enum
    private String idType;
    private Date dateOfRegistration;
    private String address;

    public Customer(String id, String name, String idType, Date dateOfRegistration, String address) {
        this.id = id;
        this.name = name;
        this.idType = idType;
        this.dateOfRegistration = dateOfRegistration;
        this.address = address;
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
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

    public Date getDateOfRegistration() {
        return dateOfRegistration;
    }

    public void setDateOfRegistration(Date dateOfRegistration) {
        this.dateOfRegistration = dateOfRegistration;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", idType='" + idType + '\'' +
                ", dateOfRegistration=" + dateOfRegistration +
                ", address='" + address + '\'' +
                '}';
    }

    public String toStringWA() {
        return "<ul>" +
                "<li> id='" + id + "</li>" +
                "<li> name='" + name + "</li>" +
                "<li> idType='" + idType + "</li>" +
                "<li> dateOfRegistration=" + dateOfRegistration + "</li>" +
                "<li> address='" + address + "</li>";
    }


}
