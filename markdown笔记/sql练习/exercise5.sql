-- https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers

CREATE TABLE Pieces (
                        Code INTEGER PRIMARY KEY NOT NULL,
                        Name TEXT NOT NULL
);
CREATE TABLE Providers (
                           Code VARCHAR(40)
                               PRIMARY KEY NOT NULL,
                           Name TEXT NOT NULL
);
CREATE TABLE Provides (
                          Piece INTEGER,
                          FOREIGN KEY (Piece) REFERENCES Pieces(Code),
                          Provider VARCHAR(40),
                          FOREIGN KEY (Provider) REFERENCES Providers(Code),
                          Price INTEGER NOT NULL,
                          PRIMARY KEY(Piece, Provider)
);

-- alternative one for SQLite
/*
CREATE TABLE Provides (
Piece INTEGER,
Provider VARCHAR(40),
Price INTEGER NOT NULL,
PRIMARY KEY(Piece, Provider)
);
*/


INSERT INTO Providers(Code, Name) VALUES('HAL','Clarke Enterprises');
INSERT INTO Providers(Code, Name) VALUES('RBT','Susan Calvin Corp.');
INSERT INTO Providers(Code, Name) VALUES('TNBC','Skellington Supplies');

INSERT INTO Pieces(Code, Name) VALUES(1,'Sprocket');
INSERT INTO Pieces(Code, Name) VALUES(2,'Screw');
INSERT INTO Pieces(Code, Name) VALUES(3,'Nut');
INSERT INTO Pieces(Code, Name) VALUES(4,'Bolt');

INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'HAL',10);
INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'HAL',20);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'TNBC',14);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'RBT',50);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'TNBC',45);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'HAL',5);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'RBT',7);


-- https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers
-- 5.1 Select the name of all the pieces.
select Name from Pieces;
-- 5.2  Select all the providers' data.
select Piece,Provider,Price
from Provides;
-- 5.3 Obtain the average price of each piece
-- (show only the piece code and the average price).
select Piece,avg(Price)
from Provides
group by Piece;
-- 5.4  Obtain the names of all providers who supply piece 1.
select Name
from Providers
where Code in (
    select Provider from Provides where Piece = 1
    );
-- 5.5 Select the name of pieces provided by provider with code "HAL".
select Name
from Pieces
where Code in(
    select Piece
    from Provides
    where Provider = 'HAL'
    );
-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece
-- and include the piece name, provider name, and price
-- (note that there could be two providers who supply the same piece
-- at the most expensive price).
select Pieces.Name,max(Provides.Price)
from Provides,Pieces
where Provides.Piece = Pieces.Code
group by Pieces.Name;

SELECT Pieces.Name, Providers.Name, Price
FROM Pieces INNER JOIN Provides ON Pieces.Code = Piece
            INNER JOIN Providers ON Providers.Code = Provider
WHERE Price =
      (
          SELECT MAX(Price) FROM Provides
          WHERE Piece = Pieces.Code
      );
-- ---------------------------------------------
select Pieces.Name,Providers.Name,Provides.Price
from Pieces
join Provides  on Pieces.Code = Provides.Piece
join Providers  on Providers.Code = Provides.Provider
where Price = (
    select max(price) from Provides
    where Piece = Pieces.Code
    )
-- 5.7 Add an entry to the database to indicate
-- that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
insert into Provides(piece, provider, price) VALUES (1,'TNBC',7);
-- 5.8 Increase all prices by one cent.
update Provides set Price = Price + 1;
-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
delete from Provides where Provider = 'RBT' and Piece = 4;
-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces
-- (the provider should still remain in the database).
delete from Provides where Provider = 'RBT';