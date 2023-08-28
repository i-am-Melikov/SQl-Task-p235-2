--Task 2



--Database Yaradin Adi Ne Olursa Olsun
CREATE DATABASE Shop



USE Shop
--Brands Adinda Table Yaradin 2 dene colum Id ve Name



CREATE TABLE Brands(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50) NOT NULL
)
INSERT INTO Brands VALUES('Apple'),('Samsung'),('Redmi')


--Notebooks Adinda Table Yaradin Id,Name, Price Columlari Olsun.
--1) Notebook ve Brand Arasinda Mentiqe Uygun Relation Qurun.
CREATE TABLE Notebooks(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50) NOT NULL,
Price DECIMAL(10,2),
BrandId INT FOREIGN KEY REFERENCES Brands(Id)
)

INSERT INTO Notebooks VALUES('Macbook air 11',1600,1),('Macbook air 14',2000,1),('Macbook Pro 14',5000,1),('Macbook Pro 16',7000,1),('SamSun',1500,2),('SamSun2',2000,2),('Mibook',1000,3),('Mibook Pro',1500,3)




--Phones Adinda Table Yaradin Id, Name, Price Columlari Olsun.
--2) Phones ve Brand Arasinda Mentiqe Uygun Relation Qurun.
CREATE TABLE Phones(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50) NOT NULL,
Price DECIMAL(10,2) NOT NULL,
BrandId INT FOREIGN KEY REFERENCES Brands(Id)
)

INSERT INTO Phones VALUES('Iphone 14 Ultra', 1200, 1),('Iphone 14',1500,1),('Iphone 14 pro', 2200,1),('Iphone 14 pro max', 3000,1),('Z Fold',2500,2),('S 22 Ultra',2500,2),('Note 11',800,3),('Note 11 pro', 1100, 3)



--3) Notebooks Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
SELECT n.Name, b.Name 'BrandName' FROM Notebooks AS n 
JOIN Brands AS b
ON n.BrandId=b.Id



--4) Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
SELECT p.Name, b.Name 'BrandName' FROM Phones AS p 
JOIN Brands AS b
ON p.BrandId=b.Id



--5) Brand Adinin Terkibinde s Olan Butun Notebooklari Cixardan Query.
SELECT * FROM Notebooks AS n
JOIN Brands AS b
ON n.BrandId=b.Id
WHERE b.Name LIKE '%s%'



--6) Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Notebooklari Cixardan Query.
SELECT * FROM Notebooks AS n where n.Price BETWEEN 2000 AND 5000 OR n.Price>5000



--7) Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.
SELECT * FROM Phones AS p where p.Price BETWEEN 1000 AND 1500 OR p.Price>1500



--8) Her Branda Aid Nece dene Notebook Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
SELECT b.Name, Count(n.BrandId) 'NotebooksCount' FROM Brands AS b
JOIN Notebooks AS n
ON b.Id=n.BrandId
GROUP BY b.Name



--9) Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
SELECT b.Name, Count(p.BrandId) 'NotebooksCount' FROM Brands AS b
JOIN Phones AS p
ON b.Id=p.BrandId
GROUP BY b.Name


--10) Hem Phone Hem de Notebookda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.
SELECT * FROM Notebooks AS n
JOIN Phones AS p
ON n.BrandId=p.BrandId
WHERE n.Name=p.Name And n.BrandId=p.BrandId



--11) Phone ve Notebook da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.
SELECT * FROM Notebooks
Union
SELECT * FROM Phones


--12) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.
SELECT n.Id, n.Name, n.Price,b.Name 'BrandName' FROM Notebooks AS n
JOIN Brands AS b
ON n.BrandId = b.Id
Union
SELECT  p.Id, p.Name, p.Price, b.Name 'BrandName' FROM Phones AS p
JOIN Brands AS b
ON p.BrandId = b.Id



--13) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.
SELECT n.Id, n.Name, n.Price,b.Name 'BrandName' FROM Notebooks AS n
JOIN Brands AS b
ON n.BrandId = b.Id
WHERE n.Price>1000
Union
SELECT  p.Id, p.Name, p.Price, b.Name 'BrandName' FROM Phones AS p
JOIN Brands AS b
ON p.BrandId = b.Id
WHERE p.Price>1000

--14) Phones Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi),
--Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi)
--ve Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olan Datalari Cixardan Query.Misal
--BrandName:        TotalPrice:        ProductCount:
--Apple                   6750                3
--Samsung            3500                4
--Redmi                 800                1

SELECT b.Name 'BrandName', Sum(p.Price) 'TotalPrice', Count(p.BrandId) 'ProductCount'  FROM Phones AS p
JOIN Brands AS b
ON p.BrandId = b.Id
GROUP BY b.Name


--15) Notebooks Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi),
--Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) ,
--Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olacaq ve Sayi 3-ve 3-den Cox Olan Datalari Cixardan Query.Misal
--BrandName:        TotalPrice:        ProductCount:
--Apple                    6750                3
--Samsung              3500                4

SELECT b.Name 'BrandName', Sum(n.Price) 'TotalPrice', Count(n.BrandId) 'ProductCount'  FROM Notebooks AS n
JOIN Brands AS b
ON n.BrandId = b.Id
GROUP BY b.Name
HAVING Count(n.BrandId)>=3