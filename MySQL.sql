-- CREATING DATABASE
CREATE DATABASE TickLabInfoSystem;
-- CREATING TABLE
    -- TickLab ID CARD
        CREATE TABLE TickLabIDCard (
            profileNumber int,
            dateOfIssue datetime,
            rfidNumber int,
            PRIMARY KEY(rfidNumber)
        )
    -- Contact address
        