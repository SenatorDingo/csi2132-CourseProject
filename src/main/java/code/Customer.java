package code;

import java.sql.Date;

public class Customer {
    private String customerID;
    private String name;
    private String idType;
    private Date dateOfRegistration;
    private String address;

    public Customer(String customerID, String name, String idType, Date dateOfRegistration, String address) {
        this.customerID = customerID;
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

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
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
}
