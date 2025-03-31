package code;

public class Room {
    private String id;
    private int roomNumber;
    private int capacity;
    private float price;
    private String view;
    private String amenity;
    private boolean knownIssues;
    private boolean extendable;

    public Room(){}

    public Room(String id, int roomNumber, int capacity, float price, String view, String amenity, boolean knownIssues, boolean extendable) {
        this.id = id;
        this.roomNumber = roomNumber;
        this.capacity = capacity;
        this.price = price;
        this.view = view;
        this.amenity = amenity;
        this.knownIssues = knownIssues;
        this.extendable = extendable;
    }

    // Getters
    public String getId() { return id; }
    public int getRoomNumber() { return roomNumber; }
    public int getCapacity() { return capacity; }
    public float getPrice() { return price; }
    public String getView() { return view; }
    public String getAmenity() { return amenity; }
    public boolean isKnownIssues() { return knownIssues; }
    public boolean isExtendable() { return extendable; }

    public void setId(String id) {
        this.id = id;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setView(String view) {
        this.view = view;
    }

    public void setAmenity(String amenity) {
        this.amenity = amenity;
    }

    public void setKnownIssues(boolean knownIssues) {
        this.knownIssues = knownIssues;
    }

    public void setExtendable(boolean extendable) {
        this.extendable = extendable;
    }
}
