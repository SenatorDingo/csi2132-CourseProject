CREATE TABLE hotelChain
(
    chainName VARCHAR(100) PRIMARY KEY,
    address   VARCHAR(100),
    numHotels INT CHECK (NumHotels > 0),
    email     VARCHAR(255) CHECK (Email ~ '^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$'),
    phone     BIGINT CHECK (phone >= 100000000 AND phone <= 9999999999)
);

--enum used for hotels 
CREATE TYPE categoryHotel AS ENUM ('Motel', 'Business', 'Airport', 'Hotel');

CREATE TABLE hotel
(
    id       VARCHAR(50) PRIMARY KEY,
    name     VARCHAR(100),
    address  VARCHAR(100),
    email    VARCHAR(255) CHECK (Email ~ '^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$'),
    phone    INT CHECK (phone >= 100000000 AND phone <= 9999999999),
    numRooms INT CHECK (numRooms > 0),
    category categoryHotel
);

CREATE TYPE viewType AS ENUM ('mountainView', 'oceanView', 'both', 'neither');
CREATE TYPE amenityType AS ENUM ('tv', 'airCondition', 'fridge', 'heating', 'microwave');

CREATE TABLE room
(
    hotelID     VARCHAR(50),
    roomNumber  INT CHECK (roomNumber > 0),
    capacity    INT CHECK (capacity > 0),
    price       float CHECK (price > 0),
    view        viewType,
    amenity     amenityType,
    knownIssues boolean,
    extendable  boolean,
    PRIMARY KEY (hotelID, roomNumber),
    --child relationship gets deleted when hotel gets deleted
    FOREIGN KEY (hotelID) REFERENCES hotel (id) ON DELETE CASCADE
);


CREATE TYPE idType AS ENUM ('SSN','photoCard', 'driversLicence', 'passport');

CREATE TABLE customer
(
    customerID         VARCHAR(50) PRIMARY KEY,
    name               VARCHAR(100),
    idType             idType,
    dateOfRegistration Date,
    address            VARCHAR(50)
);

CREATE TYPE roleType AS ENUM ('custodian', 'cleaner', 'clerk', 'bellBoy');

--MAKE FUNCTION TO CREATE THE NAME
CREATE TABLE employee
(
    employeeID     VARCHAR(50) PRIMARY KEY,
    sin            VARCHAR(50) UNIQUE,
    firstName      VARCHAR(50),
    lastName       VARCHAR(50),
    middleInitials VARCHAR(5),
    address        VARCHAR(50),
    role           roleType
);
CREATE TABLE manager
(
    SSN            VARCHAR(50) PRIMARY KEY,
    employeeID     VARCHAR(50) UNIQUE,
    firstName      VARCHAR(50),
    lastName       VARCHAR(50),
    middleInitials VARCHAR(5),
    FOREIGN KEY (employeeID) REFERENCES employee (employeeID) ON DELETE CASCADE
);

CREATE TABLE booking
(
    bookingID VARCHAR(50) PRIMARY KEY
);
CREATE TABLE renting
(
    rentingID     VARCHAR(50) PRIMARY KEY,
    checkInDate   Date NOT NULL,
    checkOutDate  Date NOT NULL,
    paymentMethod paymentType
        CHECK (checkInDate < checkOutDate)
);
CREATE TABLE archiveRecord
(
    bookingID    VARCHAR(50),
    rentingID    VARCHAR(50),
    checkInDate  Date NOT NULL,
    checkOutDate Date NOT NULL,
    PRIMARY KEY (bookingID, rentingID),
    FOREIGN KEY (bookingID) REFERENCES booking (bookingID) ON DELETE CASCADE,
    FOREIGN KEY (rentingID) REFERENCES renting (rentingID) ON DELETE CASCADE,
    CHECK (checkInDate < checkOutDate)
);


CREATE TABLE owns
(
    hotelID   VARCHAR(50),
    chainName VARCHAR(50),
    PRIMARY KEY (hotelID, chainName),
    FOREIGN KEY (hotelID) REFERENCES hotel (id) ON DELETE CASCADE,
    FOREIGN KEY (chainName) REFERENCES hotelChain (chainName) ON DELETE CASCADE
);
CREATE TABLE employs
(
    employeeID VARCHAR(50),
    hotelID    VARCHAR(50),
    PRIMARY KEY (employeeID, hotelID),
    FOREIGN KEY (hotelID) REFERENCES hotel (id) ON DELETE CASCADE,
    FOREIGN KEY (employeeID) REFERENCES employee (employeeID) ON DELETE CASCADE
);


--do we need this one
Create TABLE contains
(
    roomNumber INT,
    hotelID    VARCHAR(50),

    FOREIGN KEY (hotelID) REFERENCES hotel (id),
    FOREIGN KEY (roomNumber) REFERENCES room (roomNumber)
);


CREATE TABLE checkIn
(
    customerID VARCHAR(50),
    hotelID    VARCHAR(50),
    employeeID VARCHAR(50),
    PRIMARY KEY (customerID, hotelID, employeeID),
    FOREIGN KEY (hotelID) REFERENCES hotel (id) ON DELETE CASCADE,
    FOREIGN KEY (employeeID) REFERENCES employee (employeeID) ON DELETE CASCADE,
    FOREIGN KEY (customerID) REFERENCES customer (customerID) ON DELETE CASCADE
);



CREATE TABLE reserves
(
    roomNumber INT,
    bookingID  VARCHAR(50),
    hotelID    varchar(50),
    PRIMARY KEY (hotelID, roomNumber, bookingID),
    FOREIGN KEY (bookingID) REFERENCES booking (bookingID) ON DELETE CASCADE,
    FOREIGN KEY (hotelID, roomNumber) REFERENCES room (hotelID, roomNumber) ON DELETE CASCADE
);

CREATE TABLE occupies
(
    roomNumber INT,
    rentingID  VARCHAR(50),
    hotelID    VARCHAR(50),
    PRIMARY KEY (hotelID, roomNumber, rentingID),
    FOREIGN KEY (hotelID, roomNumber) REFERENCES room (hotelID, roomNumber) ON DELETE CASCADE,
    FOREIGN KEY (rentingID) REFERENCES renting (rentingID) ON DELETE CASCADE
);

CREATE TYPE paymentType AS ENUM ( 'Debit', 'Credit', 'Cash' );


CREATE TABLE addedTo
(
    bookingID VARCHAR(50),
    rentingID VARCHAR(50),
    FOREIGN KEY (bookingID) REFERENCES booking (bookingID),
    FOREIGN KEY (rentingID) REFERENCES renting (rentingID)
);

CREATE TABLE manages
(
    employeeID VARCHAR(50),
    hotelID    VARCHAR(50),
    PRIMARY KEY (employeeID, hotelID),
    FOREIGN KEY (hotelID) REFERENCES hotel (id) ON DELETE CASCADE,
    FOREIGN KEY (employeeID) REFERENCES manager (employeeID) ON DELETE CASCADE
);

CREATE TABLE onlineBook
(
    bookingID  VARCHAR(50),
    customerID VARCHAR(50),
    PRIMARY KEY (bookingID, customerID),
    FOREIGN KEY (bookingID) REFERENCES booking (bookingID) ON DELETE CASCADE,
    FOREIGN KEY (customerID) REFERENCES customer (customerID) ON DELETE CASCADE
);

CREATE TABLE checkInWithOutBooking
(
    customerID VARCHAR(50),
    employeeID VARCHAR(50),
    PRIMARY KEY (customerID, employeeID),
    FOREIGN KEY (customerID) REFERENCES customer (customerID) ON DELETE CASCADE,
    FOREIGN KEY (employeeID) REFERENCES employee (employeeID) ON DELETE CASCADE
);

--populating the database
--5 hotelsChains 
INSERT INTO hotelChain (chainName, address, numHotels, email, phone)
VALUES ('Holiday Inn', '123 Sparks Street', 8, 'h.inn@holiday.com', 6470013636),
       ('Best Western', '425 Bronson Avenue', 8, 'b.western@bestwestern.ca', 8765439211),
       ('Swiss Hotel', '32 Cumberland Avenue', 8, 's.hotel@swisshotel.ca', 9299226745),
       ('Hilton Garden Inn', '45 Kent Street', 8, 'h.garden@hiltongardeninn.com', 754678090),
       ('Double Tree', '78 Young Street', 8, 'd.tree@gmail.com', 678923456);


CREATE TYPE categoryHotel AS ENUM ('Motel', 'Business', 'Airport', 'Hotel');



ALTER TABLE hotel
    ALTER COLUMN phone TYPE BIGINT;

INSERT INTO hotel (id, name, address, email, phone, numRooms, category)
VALUES ('1', 'BW1', '388 Germaine Valley', 'b1.western@bestwestern.ca', 7904404654, 5, 'Motel'),
       ('2', 'BW2', '0611 Wilford Lodge', 'b2.western@bestwestern.ca', 4709318906, 5, 'Business'),
       ('3', 'BW3', '5527 Connie Ranch', 'b3.western@bestwestern.ca', 5389235961, 5, 'Airport'),
       ('4', 'BW4', '1511 Bartell Motorway', 'b4.western@bestwestern.ca', 1192895758, 5, 'Hotel'),
       ('5', 'BW5', '29443 Fisher Gateway', 'b5.western@bestwestern.ca', 3246054953, 5, 'Motel'),
       ('6', 'BW6', '25961 Bobby Unions', 'b6.western@bestwestern.ca', 4610585045, 5, 'Business'),
       ('7', 'BW7', '806 Dickinson Roads', 'b7.western@bestwestern.ca', 8825389859, 5, 'Airport'),
       ('8', 'BW8', '54213 Cole Park', 'b8.western@bestwestern.ca', 1397203468, 5, 'Hotel'),
       ('9', 'HI1', '1370 Murphy Island', 'h1.inn@holiday.com', 9834567890, 5, 'Motel'),
       ('10', 'HI2', '0340 Sage Landing', 'h2.inn@holiday.com', 8765432190, 5, 'Business'),
       ('11', 'HI3', '0195 Dulce Cove', 'h3.inn@holiday.com', 7654987321, 5, 'Airport'),
       ('12', 'HI4', '390 Pattie Highway', 'h4.inn@holiday.com', 9548371620, 5, 'Hotel'),
       ('13', 'HI5', '8819 Waters Corners', 'h5.inn@holiday.com', 8245369701, 5, 'Motel'),
       ('14', 'HI6', '25961 Bobby Unions', 'h6.inn@holiday.com', 9038256742, 5, 'Business'),
       ('15', 'HI7', '30856 Lavina Lock', 'h7.inn@holiday.com', 6894073256, 5, 'Airport'),
       ('16', 'HI8', '5301 Prudence Views', 'h8.inn@holiday.com', 7103954826, 5, 'Hotel'),
       ('17', 'SW1', '54217 Jevon Roads', 's1.hotel@swisshotel.ca', 9812345678, 5, 'Motel'),
       ('18', 'SW2', '7669 Adalberto Street', 's2.hotel@swisshotel.ca', 8745623190, 5, 'Business'),
       ('19', 'SW3', '887 Ivory Roads', 's3.hotel@swisshotel.ca', 7632514890, 5, 'Airport'),
       ('20', 'SW4', '432 Alena Village', 's4.hotel@swisshotel.ca', 9058473621, 5, 'Hotel'),
       ('21', 'SW5', '898 Fadel Viaduct', 's5.hotel@swisshotel.ca', 8124396750, 5, 'Motel'),
       ('22', 'SW6', '385 Hansen Common', 's6.hotel@swisshotel.ca', 7348052961, 5, 'Business'),
       ('23', 'SW7', '6611 Tressa Curve', 's7.hotel@swisshotel.ca', 6925473801, 5, 'Airport'),
       ('24', 'SW8', '6365 Thiel Stream', 's8.hotel@swisshotel.ca', 8579034612, 5, 'Hotel'),
       ('25', 'HGI1', '1555 Fahey Crescent', 'h1.garden@hiltongardeninn.com', 9812345679, 5, 'Motel'),
       ('26', 'HGI2', '9519 Josue Extension', 'h2.garden@hiltongardeninn.com', 8745623198, 5, 'Business'),
       ('27', 'HGI3', '57809 Smith Extension', 'h3.garden@hiltongardeninn.com', 7632514899, 5, 'Airport'),
       ('28', 'HGI4', '8596 Lynch Lodge', 'h4.garden@hiltongardeninn.com', 9058473623, 5, 'Hotel'),
       ('29', 'HGI5', '329 Boyer Dale', 'h5.garden@hiltongardeninn.com', 8124396753, 5, 'Motel'),
       ('30', 'HGI6', '742 Lavon Prairie', 'h6.garden@hiltongardeninn.com', 7348052963, 5, 'Business'),
       ('31', 'HGI7', '0956 Gretchen Knoll', 'h7.garden@hiltongardeninn.com', 6925473801, 5, 'Airport'),
       ('32', 'HGI8', '612 Hodkiewicz Ranch', 'h8.garden@hiltongardeninn.com', 8579034652, 5, 'Hotel'),
       ('33', 'DT1', '15645 Linda Vista', 'd1.tree@gmail.com', 1812345679, 5, 'Motel'),
       ('34', 'DT2', '805 Justine Landing', 'd2.tree@gmail.com', 9745623198, 5, 'Business'),
       ('35', 'DT3', '003 Ardella Roads', 'd3.tree@gmail.com', 7662514899, 5, 'Airport'),
       ('36', 'DT4', '1810 Stephen Courts', 'd4.tree@gmail.com', 9658473623, 5, 'Hotel'),
       ('37', 'DT5', '74792 Wilburn Highway', 'd5.tree@gmail.com', 6124396753, 5, 'Motel'),
       ('38', 'DT6', '77624 McCullough Groves', 'd6.tree@gmail.com', 7648052963, 5, 'Business'),
       ('39', 'DT7', '24666 Oleta Ports', 'd7.tree@gmail.com', 6925473601, 5, 'Airport'),
       ('40', 'DT8', '298 Maxine Greens', 'd8.tree@gmail.com', 8579036652, 5, 'Hotel');



INSERT INTO room (hotelID, roomNumber, capacity, price, view, amenity, knownIssues, extendable)
VALUES ('1', 101, 2, 100.0, 'mountainView', 'tv', false, true),
       ('1', 102, 3, 120.0, 'oceanView', 'fridge', false, true),
       ('1', 103, 2, 90.0, 'both', 'heating', true, false),
       ('1', 104, 4, 150.0, 'neither', 'microwave', false, true),
       ('1', 105, 1, 80.0, 'mountainView', 'tv', false, false),
       ('2', 201, 2, 110.0, 'oceanView', 'tv', true, true),
       ('2', 202, 3, 130.0, 'both', 'airCondition', false, true),
       ('2', 203, 2, 100.0, 'neither', 'fridge', false, false),
       ('2', 204, 4, 160.0, 'mountainView', 'microwave', true, false),
       ('2', 205, 1, 70.0, 'oceanView', 'heating', false, true),
       ('3', 301, 2, 105.0, 'both', 'microwave', false, true),
       ('3', 302, 3, 135.0, 'mountainView', 'airCondition', true, false),
       ('3', 303, 2, 95.0, 'oceanView', 'tv', false, false),
       ('3', 304, 4, 145.0, 'neither', 'fridge', false, true),
       ('3', 305, 1, 85.0, 'mountainView', 'heating', true, true),
       ('4', 401, 2, 110.0, 'oceanView', 'tv', false, true),
       ('4', 402, 3, 125.0, 'both', 'microwave', true, false),
       ('4', 403, 2, 105.0, 'neither', 'airCondition', false, true),
       ('4', 404, 4, 140.0, 'mountainView', 'fridge', true, true),
       ('4', 405, 1, 95.0, 'oceanView', 'heating', false, false),
       ('5', 501, 2, 95.0, 'neither', 'microwave', false, true),
       ('5', 502, 3, 120.0, 'mountainView', 'tv', true, true),
       ('5', 503, 2, 85.0, 'oceanView', 'heating', false, false),
       ('5', 504, 4, 150.0, 'both', 'airCondition', false, true),
       ('5', 505, 1, 75.0, 'mountainView', 'fridge', true, false),
       ('6', 601, 2, 115.0, 'both', 'fridge', false, true),
       ('6', 602, 3, 125.0, 'oceanView', 'microwave', true, true),
       ('6', 603, 2, 100.0, 'neither', 'heating', false, false),
       ('6', 604, 4, 160.0, 'mountainView', 'tv', true, true),
       ('6', 605, 1, 85.0, 'both', 'airCondition', false, false),
       ('7', 701, 2, 105.0, 'mountainView', 'tv', false, true),
       ('7', 702, 3, 125.0, 'oceanView', 'microwave', true, false),
       ('7', 703, 2, 95.0, 'both', 'airCondition', false, true),
       ('7', 704, 4, 140.0, 'neither', 'fridge', true, false),
       ('7', 705, 1, 80.0, 'mountainView', 'heating', false, false);

INSERT INTO room (hotelID, roomNumber, capacity, price, view, amenity, knownIssues, extendable)
VALUES ('8', 801, 2, 110.0, 'oceanView', 'tv', false, true),
       ('8', 802, 3, 130.0, 'both', 'fridge', true, false),
       ('8', 803, 2, 95.0, 'neither', 'heating', false, true),
       ('8', 804, 4, 140.0, 'mountainView', 'microwave', false, true),
       ('8', 805, 1, 85.0, 'oceanView', 'airCondition', false, false),
       ('9', 901, 2, 105.0, 'neither', 'heating', false, true),
       ('9', 902, 3, 125.0, 'mountainView', 'tv', true, false),
       ('9', 903, 2, 100.0, 'oceanView', 'microwave', false, true),
       ('9', 904, 4, 130.0, 'both', 'airCondition', true, false),
       ('9', 905, 1, 75.0, 'neither', 'fridge', false, false),
       ('10', 1001, 2, 110.0, 'oceanView', 'microwave', true, false),
       ('10', 1002, 3, 125.0, 'mountainView', 'fridge', false, true),
       ('10', 1003, 2, 95.0, 'both', 'tv', false, true),
       ('10', 1004, 4, 145.0, 'neither', 'airCondition', true, false),
       ('10', 1005, 1, 85.0, 'oceanView', 'heating', false, false),
       ('11', 1101, 2, 100.0, 'both', 'tv', false, true),
       ('11', 1102, 3, 115.0, 'mountainView', 'fridge', true, false),
       ('11', 1103, 2, 90.0, 'oceanView', 'microwave', false, true),
       ('11', 1104, 4, 125.0, 'neither', 'heating', true, false),
       ('11', 1105, 1, 80.0, 'both', 'airCondition', false, true),
       ('12', 1201, 2, 105.0, 'neither', 'microwave', false, true),
       ('12', 1202, 3, 125.0, 'mountainView', 'airCondition', true, false),
       ('12', 1203, 2, 95.0, 'oceanView', 'fridge', true, true),
       ('12', 1204, 4, 140.0, 'both', 'tv', false, true),
       ('12', 1205, 1, 85.0, 'neither', 'heating', false, false),
       ('13', 1301, 2, 95.0, 'neither', 'heating', true, true),
       ('13', 1302, 3, 120.0, 'mountainView', 'microwave', false, false),
       ('13', 1303, 2, 100.0, 'oceanView', 'airCondition', true, false),
       ('13', 1304, 4, 130.0, 'both', 'fridge', false, true),
       ('13', 1305, 1, 75.0, 'neither', 'tv', true, false),
       ('14', 1401, 2, 110.0, 'oceanView', 'fridge', true, false),
       ('14', 1402, 3, 120.0, 'mountainView', 'microwave', false, true),
       ('14', 1403, 2, 90.0, 'both', 'tv', true, true),
       ('14', 1404, 4, 135.0, 'neither', 'heating', false, false),
       ('14', 1405, 1, 80.0, 'oceanView', 'airCondition', false, true),
       ('15', 1501, 2, 95.0, 'neither', 'fridge', true, false),
       ('15', 1502, 3, 115.0, 'mountainView', 'microwave', false, true),
       ('15', 1503, 2, 90.0, 'oceanView', 'heating', true, true),
       ('15', 1504, 4, 125.0, 'both', 'tv', false, false),
       ('15', 1505, 1, 70.0, 'neither', 'airCondition', true, false),
       ('16', 1601, 2, 110.0, 'oceanView', 'tv', false, true),
       ('16', 1602, 3, 125.0, 'mountainView', 'fridge', true, false),
       ('16', 1603, 2, 100.0, 'both', 'microwave', true, true),
       ('16', 1604, 4, 130.0, 'neither', 'airCondition', false, true),
       ('16', 1605, 1, 80.0, 'oceanView', 'heating', false, false);
INSERT INTO room (hotelID, roomNumber, capacity, price, view, amenity, knownIssues, extendable)
VALUES ('16', 1606, 2, 105.0, 'mountainView', 'tv', true, false),
       ('16', 1607, 3, 120.0, 'oceanView', 'microwave', false, true),
       ('16', 1608, 2, 95.0, 'both', 'heating', true, false),
       ('16', 1609, 4, 135.0, 'neither', 'airCondition', false, true),
       ('16', 1610, 1, 85.0, 'mountainView', 'fridge', false, true),
       ('17', 1701, 2, 105.0, 'oceanView', 'microwave', true, false),
       ('17', 1702, 3, 120.0, 'mountainView', 'tv', false, true),
       ('17', 1703, 2, 95.0, 'both', 'heating', false, false),
       ('17', 1704, 4, 130.0, 'neither', 'fridge', true, true),
       ('17', 1705, 1, 85.0, 'oceanView', 'airCondition', false, true),
       ('18', 1801, 2, 110.0, 'both', 'tv', false, true),
       ('18', 1802, 3, 125.0, 'mountainView', 'microwave', true, false),
       ('18', 1803, 2, 95.0, 'oceanView', 'fridge', true, false),
       ('18', 1804, 4, 140.0, 'neither', 'heating', false, true),
       ('18', 1805, 1, 85.0, 'both', 'airCondition', false, false),
       ('19', 1901, 2, 95.0, 'oceanView', 'heating', true, false),
       ('19', 1902, 3, 110.0, 'mountainView', 'microwave', false, true),
       ('19', 1903, 2, 90.0, 'both', 'tv', true, false),
       ('19', 1904, 4, 125.0, 'neither', 'fridge', false, true),
       ('19', 1905, 1, 80.0, 'oceanView', 'airCondition', true, true),
       ('20', 2001, 2, 105.0, 'mountainView', 'fridge', false, true),
       ('20', 2002, 3, 120.0, 'oceanView', 'microwave', true, false),
       ('20', 2003, 2, 90.0, 'both', 'heating', false, true),
       ('20', 2004, 4, 135.0, 'neither', 'tv', true, false),
       ('20', 2005, 1, 80.0, 'mountainView', 'airCondition', false, false),
       ('21', 2101, 2, 95.0, 'neither', 'fridge', true, false),
       ('21', 2102, 3, 115.0, 'mountainView', 'microwave', false, true),
       ('21', 2103, 2, 90.0, 'oceanView', 'tv', true, true),
       ('21', 2104, 4, 120.0, 'both', 'heating', false, false),
       ('21', 2105, 1, 75.0, 'neither', 'airCondition', true, true),
       ('22', 2201, 2, 105.0, 'oceanView', 'microwave', false, false),
       ('22', 2202, 3, 120.0, 'mountainView', 'fridge', true, true),
       ('22', 2203, 2, 95.0, 'both', 'tv', true, false),
       ('22', 2204, 4, 140.0, 'neither', 'heating', false, true),
       ('22', 2205, 1, 85.0, 'oceanView', 'airCondition', false, true),
       ('23', 2301, 2, 110.0, 'mountainView', 'heating', true, false),
       ('23', 2302, 3, 125.0, 'oceanView', 'microwave', false, true),
       ('23', 2303, 2, 95.0, 'both', 'fridge', true, false),
       ('23', 2304, 4, 130.0, 'neither', 'tv', true, true),
       ('23', 2305, 1, 85.0, 'mountainView', 'airCondition', false, true),
       ('24', 2401, 2, 95.0, 'neither', 'microwave', false, true),
       ('24', 2402, 3, 110.0, 'mountainView', 'fridge', true, false),
       ('24', 2403, 2, 90.0, 'oceanView', 'heating', false, false),
       ('24', 2404, 4, 120.0, 'both', 'tv', true, true),
       ('24', 2405, 1, 75.0, 'neither', 'airCondition', false, true),
       ('25', 2501, 2, 100.0, 'oceanView', 'tv', false, true),
       ('25', 2502, 3, 120.0, 'mountainView', 'microwave', true, false),
       ('25', 2503, 2, 95.0, 'both', 'fridge', false, true),
       ('25', 2504, 4, 130.0, 'neither', 'heating', true, false),
       ('25', 2505, 1, 85.0, 'oceanView', 'airCondition', true, false),
       ('26', 2601, 2, 105.0, 'mountainView', 'microwave', false, true),
       ('26', 2602, 3, 120.0, 'oceanView', 'tv', true, false),
       ('26', 2603, 2, 95.0, 'both', 'airCondition', false, true),
       ('26', 2604, 4, 140.0, 'neither', 'fridge', true, false),
       ('26', 2605, 1, 85.0, 'mountainView', 'heating', false, true),
       ('27', 2701, 2, 110.0, 'oceanView', 'fridge', true, false),
       ('27', 2702, 3, 120.0, 'mountainView', 'microwave', false, true),
       ('27', 2703, 2, 100.0, 'both', 'tv', true, false),
       ('27', 2704, 4, 130.0, 'neither', 'heating', false, true),
       ('27', 2705, 1, 85.0, 'oceanView', 'airCondition', true, false),
       ('28', 2801, 2, 105.0, 'neither', 'heating', true, true),
       ('28', 2802, 3, 120.0, 'mountainView', 'tv', false, false),
       ('28', 2803, 2, 95.0, 'oceanView', 'microwave', true, true),
       ('28', 2804, 4, 135.0, 'both', 'fridge', true, false),
       ('28', 2805, 1, 75.0, 'neither', 'airCondition', false, true),
       ('29', 2901, 2, 110.0, 'mountainView', 'fridge', true, false),
       ('29', 2902, 3, 120.0, 'oceanView', 'tv', false, true),
       ('29', 2903, 2, 95.0, 'both', 'microwave', true, false),
       ('29', 2904, 4, 135.0, 'neither', 'heating', false, true),
       ('29', 2905, 1, 85.0, 'mountainView', 'airCondition', false, true),
       ('30', 3001, 2, 105.0, 'oceanView', 'microwave', false, true),
       ('30', 3002, 3, 120.0, 'mountainView', 'fridge', true, false),
       ('30', 3003, 2, 90.0, 'both', 'tv', false, true),
       ('30', 3004, 4, 130.0, 'neither', 'heating', true, false),
       ('30', 3005, 1, 80.0, 'oceanView', 'airCondition', false, true),
       ('31', 3101, 2, 100.0, 'mountainView', 'heating', true, false),
       ('31', 3102, 3, 115.0, 'oceanView', 'microwave', false, true),
       ('31', 3103, 2, 90.0, 'both', 'fridge', true, false),
       ('31', 3104, 4, 125.0, 'neither', 'tv', false, true),
       ('31', 3105, 1, 75.0, 'mountainView', 'airCondition', true, false),
       ('32', 3201, 2, 110.0, 'oceanView', 'tv', true, false),
       ('32', 3202, 3, 125.0, 'mountainView', 'microwave', false, true),
       ('32', 3203, 2, 95.0, 'both', 'fridge', true, true),
       ('32', 3204, 4, 140.0, 'neither', 'heating', false, true),
       ('32', 3205, 1, 85.0, 'oceanView', 'airCondition', false, false),
       ('33', 3301, 2, 95.0, 'mountainView', 'microwave', true, true),
       ('33', 3302, 3, 110.0, 'oceanView', 'fridge', false, false),
       ('33', 3303, 2, 90.0, 'both', 'tv', true, false),
       ('33', 3304, 4, 120.0, 'neither', 'heating', false, true),
       ('33', 3305, 1, 75.0, 'mountainView', 'airCondition', true, false),
       ('34', 3401, 2, 105.0, 'oceanView', 'microwave', false, true),
       ('34', 3402, 3, 120.0, 'mountainView', 'tv', true, false),
       ('34', 3403, 2, 95.0, 'both', 'heating', true, true),
       ('34', 3404, 4, 130.0, 'neither', 'fridge', false, false),
       ('34', 3405, 1, 80.0, 'oceanView', 'airCondition', true, false),
       ('35', 3501, 2, 110.0, 'mountainView', 'heating', true, false),
       ('35', 3502, 3, 120.0, 'oceanView', 'microwave', false, true),
       ('35', 3503, 2, 95.0, 'both', 'fridge', true, false),
       ('35', 3504, 4, 135.0, 'neither', 'tv', true, true),
       ('35', 3505, 1, 85.0, 'mountainView', 'airCondition', false, true),
       ('36', 3601, 2, 100.0, 'oceanView', 'fridge', false, true),
       ('36', 3602, 3, 115.0, 'mountainView', 'microwave', true, false),
       ('36', 3603, 2, 90.0, 'both', 'heating', false, true),
       ('36', 3604, 4, 125.0, 'neither', 'tv', true, false),
       ('36', 3605, 1, 75.0, 'oceanView', 'airCondition', true, true),
       ('37', 3701, 2, 105.0, 'mountainView', 'microwave', true, false),
       ('37', 3702, 3, 120.0, 'oceanView', 'fridge', true, true),
       ('37', 3703, 2, 95.0, 'both', 'tv', true, false),
       ('37', 3704, 4, 130.0, 'neither', 'heating', false, true),
       ('37', 3705, 1, 85.0, 'mountainView', 'airCondition', false, true),
       ('38', 3801, 2, 100.0, 'oceanView', 'tv', true, true),
       ('38', 3802, 3, 115.0, 'mountainView', 'microwave', false, true),
       ('38', 3803, 2, 90.0, 'both', 'fridge', true, false),
       ('38', 3804, 4, 120.0, 'neither', 'heating', true, false),
       ('38', 3805, 1, 75.0, 'oceanView', 'airCondition', false, true),
       ('39', 3901, 2, 105.0, 'mountainView', 'microwave', true, false),
       ('39', 3902, 3, 120.0, 'oceanView', 'fridge', false, true),
       ('39', 3903, 2, 95.0, 'both', 'tv', true, false),
       ('39', 3904, 4, 130.0, 'neither', 'heating', false, true),
       ('39', 3905, 1, 85.0, 'mountainView', 'airCondition', true, false),
       ('40', 4001, 2, 100.0, 'oceanView', 'heating', false, true),
       ('40', 4002, 3, 115.0, 'mountainView', 'microwave', true, false),
       ('40', 4003, 2, 90.0, 'both', 'fridge', false, true),
       ('40', 4004, 4, 120.0, 'neither', 'tv', true, false),
       ('40', 4005, 1, 75.0, 'oceanView', 'airCondition', true, true);

INSERT INTO customer (customerID, name, idType, dateOfRegistration, address)
VALUES ('C001', 'Shay Software', 'SSN', '2023-01-15', '123 Elm St, Springfield'),
       ('C002', 'Tony Stark', 'photoCard', '2024-02-01', '456 Oak Ave, Rivertown'),
       ('C003', 'Markle Sparkle', 'driversLicence', '2024-03-05', '789 Pine Blvd, Lakeside'),
       ('C004', 'Elvis Davis', 'passport', '2023-04-12', '101 Maple Rd, Greenfield'),
       ('C005', 'Michael longfellow', 'SSN', '2023-01-25', '202 Birch Dr, Meadowbrook'),
       ('C006', 'Kate McKinnon', 'photoCard', '2023-02-18', '303 Cedar Ln, Hilltop'),
       ('C007', 'James Taylor', 'driversLicence', '2020-03-22', '404 Willow Way, Brookside'),
       ('C008', 'Chappel Roan', 'passport', '2021-04-09', '505 Redwood St, Seaside'),
       ('C009', 'Taylor Swift', 'SSN', '2025-01-30', '606 Oakwood Cir, Summitview'),
       ('C010', 'Kamala Harris', 'photoCard', '2025-02-12', '707 Ash Dr, Crestwood');



INSERT INTO employee (employeeID, sin, firstName, lastName, middleInitials, address, role)
VALUES ('E001', '111-22-3333', 'John', 'Doe', 'A', '123 Elm St, Springfield', 'custodian'),
       ('E002', '111-22-3334', 'Jane', 'Smith', 'B', '124 Elm St, Springfield', 'cleaner'),
       ('E003', '111-22-3335', 'Mark', 'Johnson', 'C', '456 Oak Ave, Rivertown', 'clerk'),
       ('E004', '111-22-3336', 'Emily', 'Davis', 'D', '457 Oak Ave, Rivertown', 'bellBoy'),
       ('E005', '111-22-3337', 'Michael', 'Brown', 'E', '789 Pine Blvd, Lakeside', 'custodian'),
       ('E006', '111-22-3338', 'Olivia', 'Wilson', 'F', '790 Pine Blvd, Lakeside', 'cleaner'),
       ('E007', '111-22-3339', 'James', 'Taylor', 'G', '101 Maple Rd, Greenfield', 'clerk'),
       ('E008', '111-22-3340', 'Sophia', 'Martinez', 'H', '102 Maple Rd, Greenfield', 'bellBoy'),
       ('E009', '111-22-3341', 'Daniel', 'Lee', 'I', '202 Birch Dr, Meadowbrook', 'custodian'),
       ('E010', '111-22-3342', 'Mia', 'Harris', 'J', '203 Birch Dr, Meadowbrook', 'cleaner'),
       ('E011', '111-22-3343', 'Liam', 'Young', 'K', '303 Cedar Ln, Hilltop', 'clerk'),
       ('E012', '111-22-3344', 'Isabella', 'King', 'L', '304 Cedar Ln, Hilltop', 'bellBoy'),
       ('E013', '111-22-3345', 'Lucas', 'Scott', 'M', '404 Willow Way, Brookside', 'custodian'),
       ('E014', '111-22-3346', 'Amelia', 'Adams', 'N', '405 Willow Way, Brookside', 'cleaner'),
       ('E015', '111-22-3347', 'Henry', 'Baker', 'O', '505 Redwood St, Seaside', 'clerk'),
       ('E016', '111-22-3348', 'Charlotte', 'Carter', 'P', '506 Redwood St, Seaside', 'bellBoy'),
       ('E017', '111-22-3349', 'Ethan', 'Nelson', 'Q', '606 Oakwood Cir, Summitview', 'custodian'),
       ('E018', '111-22-3350', 'Zoe', 'Perez', 'R', '607 Oakwood Cir, Summitview', 'cleaner'),
       ('E019', '111-22-3351', 'Aiden', 'Miller', 'S', '707 Ash Dr, Crestwood', 'clerk'),
       ('E020', '111-22-3352', 'Lily', 'Taylor', 'T', '708 Ash Dr, Crestwood', 'bellBoy'),
       ('E021', '111-22-3353', 'Mason', 'Wilson', 'U', '809 Cedar St, Pinehill', 'custodian'),
       ('E022', '111-22-3354', 'Grace', 'Moore', 'V', '810 Cedar St, Pinehill', 'cleaner'),
       ('E023', '111-22-3355', 'Jacob', 'Anderson', 'W', '911 Pine Dr, Hillcrest', 'clerk'),
       ('E024', '111-22-3356', 'Ella', 'Thomas', 'X', '912 Pine Dr, Hillcrest', 'bellBoy'),
       ('E025', '111-22-3357', 'Logan', 'Jackson', 'Y', '1010 Oak Ln, Forestview', 'custodian'),
       ('E026', '111-22-3358', 'Chloe', 'White', 'Z', '1011 Oak Ln, Forestview', 'cleaner'),
       ('E027', '111-22-3359', 'Carter', 'Harris', 'A', '1122 Maple Blvd, Evergreen', 'clerk'),
       ('E028', '111-22-3360', 'Harper', 'Martin', 'B', '1123 Maple Blvd, Evergreen', 'bellBoy'),
       ('E029', '111-22-3361', 'Sebastian', 'Garcia', 'C', '1234 Birch St, Silverlake', 'custodian'),
       ('E030', '111-22-3362', 'Scarlett', 'Lopez', 'D', '1235 Birch St, Silverlake', 'cleaner'),
       ('E031', '111-22-3363', 'Wyatt', 'Martinez', 'E', '1345 Oakwood Dr, Riverside', 'clerk'),
       ('E032', '111-22-3364', 'Amos', 'Gonzalez', 'F', '1346 Oakwood Dr, Riverside', 'bellBoy'),
       ('E033', '111-22-3365', 'Elijah', 'Perez', 'G', '1456 Cedar St, Beachwood', 'custodian'),
       ('E034', '111-22-3366', 'Violet', 'Rodriguez', 'H', '1457 Cedar St, Beachwood', 'cleaner'),
       ('E035', '111-22-3367', 'Benjamin', 'Sanchez', 'I', '1567 Birch Ln, Lakedale', 'clerk'),
       ('E036', '111-22-3368', 'Maya', 'King', 'J', '1568 Birch Ln, Lakedale', 'bellBoy'),
       ('E037', '111-22-3369', 'Alexander', 'Lee', 'K', '1678 Oak Blvd, Maplewood', 'custodian'),
       ('E038', '111-22-3370', 'Evelyn', 'Wright', 'L', '1679 Oak Blvd, Maplewood', 'cleaner'),
       ('E039', '111-22-3371', 'Maverick', 'Young', 'M', '1789 Pine Rd, Sunview', 'clerk'),
       ('E040', '111-22-3372', 'Madison', 'Hernandez', 'N', '1790 Pine Rd, Sunview', 'bellBoy'),
       ('E041', '111-22-3373', 'Zane', 'Scott', 'O', '1901 Oak Dr, Willowbrook', 'custodian'),
       ('E042', '111-22-3374', 'Charlotte', 'Green', 'P', '1902 Oak Dr, Willowbrook', 'cleaner'),
       ('E043', '111-22-3375', 'Eli', 'Adams', 'Q', '2012 Maple Blvd, Riverview', 'clerk'),
       ('E044', '111-22-3376', 'Ava', 'Roberts', 'R', '2013 Maple Blvd, Riverview', 'bellBoy'),
       ('E045', '111-22-3377', 'Noah', 'Walker', 'S', '2124 Cedar Ave, Pineview', 'custodian'),
       ('E046', '111-22-3378', 'Sophie', 'Hall', 'T', '2125 Cedar Ave, Pineview', 'cleaner'),
       ('E047', '111-22-3379', 'Nathan', 'Bell', 'U', '2250 Oak St, Lakeside', 'clerk'),
       ('E048', '111-22-3380', 'Isaac', 'Fox', 'V', '2300 Maple Ave, Highland', 'bellBoy'),
       ('E049', '111-22-3381', 'Caleb', 'Reed', 'W', '2400 Pine St, Summitview', 'custodian'),
       ('E050', '111-22-3382', 'Megan', 'Foster', 'X', '2500 Birch St, Riverwood', 'cleaner'),
       ('E051', '960-51-5467', 'Emma', 'Murray', 'Z', '4495 Dixon St, Alexanderville', 'custodian'),
       ('E052', '435-99-2454', 'Aurora', 'Fowler', 'X', '7142 Drake St, Alexanderville', 'clerk'),
       ('E053', '700-51-3307', 'Ella', 'Little', 'P', '1997 Hicks St, Lilyville', 'cleaner'),
       ('E054', '131-92-6773', 'Samuel', 'Rhodes', 'D', '4487 Jenkins St, Alexanderville', 'cleaner'),
       ('E055', '242-18-6046', 'Megan', 'Fuller', 'R', '5245 Simpson St, Meganville', 'clerk'),
       ('E056', '792-17-5326', 'Hazel', 'Gibson', 'M', '3136 Sullivan St, Zoeyville', 'custodian'),
       ('E057', '325-42-8536', 'Sebastian', 'Ford', 'A', '3821 Ray St, Stellaville', 'bellBoy'),
       ('E058', '862-21-3269', 'James', 'Terry', 'J', '4626 Stone St, Victoriaville', 'custodian'),
       ('E059', '749-19-6120', 'Logan', 'Bell', 'A', '1419 Baldwin St, Abigailville', 'cleaner'),
       ('E060', '915-64-4849', 'Wyatt', 'Reynolds', 'B', '1150 Harvey St, Jamesville', 'cleaner'),
       ('E061', '940-74-9667', 'David', 'Fuller', 'S', '2231 Greene St, Leviville', 'cleaner'),
       ('E062', '123-31-4320', 'Aurora', 'Hudson', 'R', '9606 Hart St, Zoeyville', 'clerk'),
       ('E063', '644-77-2206', 'Abigail', 'Hicks', 'I', '4656 Harrison St, Samuelville', 'custodian'),
       ('E064', '673-89-8299', 'Owen', 'Simpson', 'Y', '8331 Parker St, Isaacville', 'clerk'),
       ('E065', '777-44-3763', 'Gabriel', 'Ray', 'Z', '9770 Cole St, Lunaville', 'bellBoy'),
       ('E066', '341-26-4352', 'Olivia', 'Rogers', 'K', '2182 Lane St, Nathanville', 'cleaner'),
       ('E067', '952-12-6413', 'Mia', 'Dean', 'P', '9483 Bell St, Lilyville', 'custodian'),
       ('E068', '774-98-3015', 'Ryan', 'Cole', 'U', '8842 Harvey St, Avaville', 'cleaner'),
       ('E069', '507-32-4578', 'Harper', 'Bishop', 'B', '3720 Russell St, Samuelville', 'custodian'),
       ('E070', '524-98-4993', 'Henry', 'Hicks', 'A', '6462 Ford St, Josephville', 'bellBoy'),
       ('E071', '839-16-2725', 'Nora', 'Dixon', 'V', '5674 Gibson St, Ethanville', 'bellBoy'),
       ('E072', '672-30-2359', 'Owen', 'Stewart', 'D', '7289 Hicks St, Elijahville', 'cleaner'),
       ('E073', '543-43-1720', 'Penelope', 'Baldwin', 'I', '9431 Barnes St, Penelopeville', 'clerk'),
       ('E074', '805-85-6905', 'Victoria', 'Reynolds', 'Y', '2563 Harvey St, Zoeyville', 'clerk'),
       ('E075', '258-39-4142', 'Ava', 'Harrison', 'Z', '4926 Stevenson St, Julianville', 'clerk'),
       ('E076', '710-92-7354', 'Megan', 'Greene', 'L', '8985 Wells St, Danielville', 'bellBoy'),
       ('E077', '582-34-7317', 'Hazel', 'Ward', 'D', '5371 Hart St, Jamesville', 'custodian'),
       ('E078', '582-62-8695', 'Carter', 'Caldwell', 'Q', '6381 Hicks St, Ellaville', 'custodian'),
       ('E079', '474-42-4667', 'Gabriel', 'Parker', 'X', '4256 Carson St, Jackville', 'custodian'),
       ('E080', '940-52-2822', 'Alexander', 'Ward', 'P', '8514 Murray St, Elijahville', 'custodian'),
       ('E081', '886-48-5175', 'Lily', 'Fowler', 'W', '4892 Simpson St, Hazelville', 'clerk'),
       ('E082', '216-46-6581', 'Sophia', 'Bishop', 'Y', '3020 Cole St, Alexanderville', 'cleaner'),
       ('E083', '642-70-8566', 'Stella', 'Harvey', 'B', '3160 Harrison St, Danielville', 'bellBoy'),
       ('E084', '600-25-8187', 'Victoria', 'Bishop', 'C', '5973 Manning St, Avaville', 'custodian'),
       ('E085', '414-33-1768', 'Isaac', 'Reed', 'D', '5133 Harvey St, Gabrielville', 'cleaner'),
       ('E086', '486-72-4905', 'Jacob', 'Rogers', 'C', '2027 Ford St, Nathanville', 'cleaner'),
       ('E087', '517-81-2416', 'Madison', 'Caldwell', 'H', '4408 Reed St, Auroraville', 'custodian'),
       ('E088', '429-69-9850', 'Stella', 'Dixon', 'P', '3620 Morris St, Oliviaville', 'custodian'),
       ('E089', '833-93-5958', 'Penelope', 'Stewart', 'R', '5672 Simpson St, Wyattville', 'cleaner'),
       ('E090', '436-52-3931', 'Sophia', 'Grant', 'J', '1277 Reynolds St, Josephville', 'custodian'),
       ('E091', '772-38-1705', 'Gabriel', 'Hicks', 'I', '8775 Drake St, Julianville', 'cleaner'),
       ('E092', '652-50-2921', 'Lucas', 'Bell', 'L', '4942 Carson St, Zoeyville', 'cleaner'),
       ('E093', '904-45-1909', 'Henry', 'Lane', 'S', '6122 Hart St, Josephville', 'cleaner'),
       ('E094', '174-64-8087', 'Caleb', 'Stevenson', 'N', '5218 Barnes St, Benjaminville', 'bellBoy'),
       ('E095', '627-82-1674', 'Jack', 'Terry', 'M', '2393 Gibson St, Alexanderville', 'custodian'),
       ('E096', '856-33-6631', 'Mia', 'Bennett', 'Z', '3666 Jenkins St, Lucasville', 'custodian'),
       ('E097', '775-55-5733', 'Jack', 'Russell', 'R', '2081 Fowler St, Jamesville', 'bellBoy'),
       ('E098', '723-93-7602', 'Wyatt', 'Murray', 'O', '8868 Reynolds St, Scarlettville', 'clerk'),
       ('E099', '301-25-9429', 'Mateo', 'Lane', 'F', '6762 Manning St, Samuelville', 'cleaner'),
       ('E100', '306-66-1816', 'Ethan', 'Russell', 'J', '2242 Reed St, Auroraville', 'bellBoy');


INSERT INTO booking (bookingID)
VALUES ('1'),
       ('2'),
       ('3'),
       ('4'),
       ('5');

INSERT INTO renting (RentingID, checkInDate, checkOutDate, paymentMethod)
VALUES ('1', '2025-03-01', '2025-03-05', 'Credit'),
       ('2', '2025-03-03', '2025-03-07', 'Debit'),
       ('3', '2025-03-10', '2025-03-15', 'Cash'),
       ('4', '2025-03-12', '2025-03-16', 'Credit'),
       ('5', '2025-03-20', '2025-03-25', 'Cash');

INSERT INTO archiveRecord (bookingID, rentingID, checkInDate, checkOutDate)
VALUES ('1', '1', '2025-03-01', '2025-03-05'),
       ('2', '2', '2025-03-03', '2025-03-07'),
       ('3', '3', '2025-03-10', '2025-03-15'),
       ('4', '4', '2025-03-12', '2025-03-16'),
       ('5', '5', '2025-03-20', '2025-03-25');

INSERT INTO manager (SSN, employeeID, firstName, lastName, middleInitials)
VALUES ('SSN001', 'E001', 'Luke', 'Skywalker', 'A'),
       ('SSN002', 'E002', 'Leia', 'Organa', 'B'),
       ('SSN003', 'E003', 'Indiana', 'Jones', 'C'),
       ('SSN004', 'E004', 'Hermione', 'Granger', 'D'),
       ('SSN005', 'E005', 'Tony', 'Stark', 'E'),
       ('SSN006', 'E006', 'Bruce', 'Wayne', 'F'),
       ('SSN007', 'E007', 'Clark', 'Kent', 'G'),
       ('SSN008', 'E008', 'Peter', 'Parker', 'H'),
       ('SSN009', 'E009', 'Wolverine', 'Logan', 'I'),
       ('SSN010', 'E010', 'Natasha', 'Romanoff', 'J'),
       ('SSN011', 'E011', 'Jon', 'Snow', 'K'),
       ('SSN012', 'E012', 'Arya', 'Stark', 'L'),
       ('SSN013', 'E013', 'Daenerys', 'Targaryen', 'M'),
       ('SSN014', 'E014', 'Gandalf', 'the Grey', 'N'),
       ('SSN015', 'E015', 'Frodo', 'Baggins', 'O'),
       ('SSN016', 'E016', 'Samwise', 'Gamgee', 'P'),
       ('SSN017', 'E017', 'Voldemort', 'Riddle', 'Q'),
       ('SSN018', 'E018', 'Darth', 'Vader', 'R'),
       ('SSN019', 'E019', 'Yoda', 'Master', 'S'),
       ('SSN020', 'E020', 'Leia', 'Solo', 'T'),
       ('SSN021', 'E021', 'Sherlock', 'Holmes', 'U'),
       ('SSN022', 'E022', 'Watson', 'John', 'V'),
       ('SSN023', 'E023', 'Maximus', 'Decimus', 'W'),
       ('SSN024', 'E024', 'Ragnar', 'Lothbrok', 'X'),
       ('SSN025', 'E025', 'Thor', 'Odinson', 'Y'),
       ('SSN026', 'E026', 'Loki', 'Mischief', 'Z'),
       ('SSN027', 'E027', 'Jack', 'Sparrow', 'A'),
       ('SSN028', 'E028', 'Elizabeth', 'Swan', 'B'),
       ('SSN029', 'E029', 'Captain', 'America', 'C'),
       ('SSN030', 'E030', 'Black', 'Widow', 'D'),
       ('SSN031', 'E031', 'Ant', 'Man', 'E'),
       ('SSN032', 'E032', 'Hawkeye', 'Barton', 'F'),
       ('SSN033', 'E033', 'Rocket', 'Raccoon', 'G'),
       ('SSN034', 'E034', 'Groot', 'Tree', 'H'),
       ('SSN035', 'E035', 'Star', 'Lord', 'I'),
       ('SSN036', 'E036', 'Gamora', 'Green', 'J'),
       ('SSN037', 'E037', 'Nebula', 'Cybernetic', 'K'),
       ('SSN038', 'E038', 'Wanda', 'Maximoff', 'L'),
       ('SSN039', 'E039', 'Vision', 'Avenger', 'M'),
       ('SSN040', 'E040', 'Doctor', 'Strange', 'N');


INSERT INTO owns(hotelID, chainName)
VALUES ('1', 'Best Western'),
       ('2', 'Best Western'),
       ('3', 'Best Western'),
       ('4', 'Best Western'),
       ('5', 'Best Western'),
       ('6', 'Best Western'),
       ('7', 'Best Western'),
       ('8', 'Best Western'),
       ('9', 'Holiday Inn'),
       ('10', 'Holiday Inn'),
       ('11', 'Holiday Inn'),
       ('12', 'Holiday Inn'),
       ('13', 'Holiday Inn'),
       ('14', 'Holiday Inn'),
       ('15', 'Holiday Inn'),
       ('16', 'Holiday Inn'),
       ('17', 'Swiss Hotel'),
       ('18', 'Swiss Hotel'),
       ('19', 'Swiss Hotel'),
       ('20', 'Swiss Hotel'),
       ('21', 'Swiss Hotel'),
       ('22', 'Swiss Hotel'),
       ('23', 'Swiss Hotel'),
       ('24', 'Swiss Hotel'),
       ('25', 'Hilton Garden Inn'),
       ('26', 'Hilton Garden Inn'),
       ('27', 'Hilton Garden Inn'),
       ('28', 'Hilton Garden Inn'),
       ('29', 'Hilton Garden Inn'),
       ('30', 'Hilton Garden Inn'),
       ('31', 'Hilton Garden Inn'),
       ('32', 'Hilton Garden Inn'),
       ('33', 'Double Tree'),
       ('34', 'Double Tree'),
       ('35', 'Double Tree'),
       ('36', 'Double Tree'),
       ('37', 'Double Tree'),
       ('38', 'Double Tree'),
       ('39', 'Double Tree'),
       ('40', 'Double Tree');



INSERT INTO employs (employeeID, hotelID)
VALUES ('E001', '1'),
       ('E002', '2'),
       ('E003', '3'),
       ('E004', '4'),
       ('E005', '5'),
       ('E006', '6'),
       ('E007', '7'),
       ('E008', '8'),
       ('E009', '9'),
       ('E010', '10'),
       ('E011', '11'),
       ('E012', '12'),
       ('E013', '13'),
       ('E014', '14'),
       ('E015', '15'),
       ('E016', '16'),
       ('E017', '17'),
       ('E018', '18'),
       ('E019', '19'),
       ('E020', '20'),
       ('E021', '21'),
       ('E022', '22'),
       ('E023', '23'),
       ('E024', '24'),
       ('E025', '25'),
       ('E026', '26'),
       ('E027', '27'),
       ('E028', '28'),
       ('E029', '29'),
       ('E030', '30'),
       ('E031', '31'),
       ('E032', '32'),
       ('E033', '33'),
       ('E034', '34'),
       ('E035', '35'),
       ('E036', '36'),
       ('E037', '37'),
       ('E038', '38'),
       ('E039', '39'),
       ('E040', '40'),
       ('E041', '1'),
       ('E042', '2'),
       ('E043', '3'),
       ('E044', '4'),
       ('E045', '5'),
       ('E046', '6'),
       ('E047', '7'),
       ('E048', '8'),
       ('E049', '9'),
       ('E050', '10'),
       ('E051', '11'),
       ('E052', '12'),
       ('E053', '13'),
       ('E054', '14'),
       ('E055', '15'),
       ('E056', '16'),
       ('E057', '17'),
       ('E058', '18'),
       ('E059', '19'),
       ('E060', '20'),
       ('E061', '21'),
       ('E062', '22'),
       ('E063', '23'),
       ('E064', '24'),
       ('E065', '25'),
       ('E066', '26'),
       ('E067', '27'),
       ('E068', '28'),
       ('E069', '29'),
       ('E070', '30'),
       ('E071', '31'),
       ('E072', '32'),
       ('E073', '33'),
       ('E074', '34'),
       ('E075', '35'),
       ('E076', '36'),
       ('E077', '37'),
       ('E078', '38'),
       ('E079', '39'),
       ('E080', '40');

INSERT INTO checkIn(customerID, hotelID, employeeID)
VALUES ('C001', '1', 'E080'),
       ('C002', '2', 'E045'),
       ('C004', '5', 'E020');
INSERT INTO addedTo(bookingID, rentingID)
VALUES ('1', '1'),
       ('2', '2');
INSERT INTO reserves(roomNumber, bookingID, hotelID)
VALUES (101, '1', '1'),
       (201, '2', '2');
INSERT INTO occupies(roomNumber, rentingID, hotelID)
VALUES (102, '3', '1'),
       (202, '4', '2');
INSERT INTO manages(employeeID, hotelID)
VALUES ('E001', '1'),
       ('E002', '2'),
       ('E003', '3'),
       ('E004', '4'),
       ('E005', '5'),
       ('E006', '6'),
       ('E007', '7'),
       ('E008', '8'),
       ('E009', '9'),
       ('E010', '10'),
       ('E011', '11'),
       ('E012', '12'),
       ('E013', '13'),
       ('E014', '14'),
       ('E015', '15'),
       ('E016', '16'),
       ('E017', '17'),
       ('E018', '18'),
       ('E019', '19'),
       ('E020', '20'),
       ('E021', '21'),
       ('E022', '22'),
       ('E023', '23'),
       ('E024', '24'),
       ('E025', '25'),
       ('E026', '26'),
       ('E027', '27'),
       ('E028', '28'),
       ('E029', '29'),
       ('E030', '30'),
       ('E031', '31'),
       ('E032', '32'),
       ('E033', '33'),
       ('E034', '34'),
       ('E035', '35'),
       ('E036', '36'),
       ('E037', '37'),
       ('E038', '38'),
       ('E039', '39'),
       ('E040', '40');
INSERT INTO onlineBook(bookingID, customerID)
VALUES ('4', 'C004'),
       ('5', 'C005');

INSERT INTO checkInWithOutBooking(customerID, employeeID)
VALUES ('C006', 'E075'),
       ('C007', 'E076');



	
	


	







	
	
		
		
	
	
	
	
