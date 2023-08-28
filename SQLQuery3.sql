CREATE DATABASE Library

USE Library

CREATE TABLE Books(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(100) CHECK(LEN(Name)>=2),
PageCount INT CHECK(PageCount>=10),
AuthorId INT FOREIGN KEY REFERENCES Authors(Id)
)

CREATE TABLE Authors(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(100) CHECK(LEN(Name)>=2),
Surname NVARCHAR(100) CHECK(LEN(Surname)>=2)
)

INSERT INTO Books VALUES('Kecel qizin naqillari',120,1),('Almanlar',250,2),('System',240,3)

INSERT INTO Authors(Name,Surname) VALUES('Mustafa','Melikov'),('Amrah','Nasirov'),('Ahmad','Mehdiyev')


--Gonderilmis axtaris deyirene gore hemin axtaris deyeri name ve ya authorFullNamelerinde
--olan Book-lari Id, Name, PageCount, AuthorFullName columnlari seklinde gostern procedure yazin
CREATE VIEW usv_Books_Authors
AS
SELECT b.Id, b.Name, b.PageCount, (a.Name + ' '+ a.Surname) 'AuthorFullName' FROM Books as b 
JOIN Authors as a
On b.AuthorId = a.Id


--Authors tableinin insert, update ve deleti ucun (her biri ucun ayrica) procedure yaradin
CREATE PROCEDURE usp_InsertAuthor
(@name VARCHAR(100), @surname VARCHAR(100))
AS
BEGIN
    INSERT INTO Authors (Name, Surname)
    VALUES (@name, @surname);
END

exec usp_InsertAuthor Pasha, Allahverdiyev




CREATE PROCEDURE usp_UpdateAuthor
(@id INT, @name VARCHAR(100), @surname VARCHAR(100))
AS
BEGIN
    UPDATE Authors
    SET Authors.Name = @name, Authors.Surname=@surname
    WHERE Authors.Id = @id
END


CREATE PROCEDURE usp_DeleteAuthor
(@id INT)
AS
BEGIN
    DELETE FROM Authors
    WHERE Authors.Id= @id;
END 





--Authorslari Id,FullName,BooksCount,MaxPageCount seklinde qaytaran view yaradirsiniz Id-author id-si,
--FullName - Name ve Surname birlesmesi, BooksCount - Hemin authorun elaqeli oldugu kitablarin sayi,
--MaxPageCount - hemin authorun elaqeli oldugu kitablarin icerisindeki max pagecount deyeri


CREATE VIEW usv_AuthorOperations
AS
SELECT
	a.Id,
	(a.Name +' '+ a.Surname) 'AuthorFullName',
    COUNT(b.Id) AS BooksCount,
    MAX(b.PageCount) AS MaxPageCount
FROM
    Authors AS a
LEFT JOIN
    Books AS b ON b.AuthorId = a.Id 
GROUP BY
    a.Id, a.Name, a.Surname;



