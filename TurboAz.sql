CREATE DATABASE TurboAz

USE TurboAz


CREATE TABLE Marka(
Id int identity primary key,
Name nvarchar(50) not null unique
)
 

CREATE TABLE Models(
Id int identity primary key,
Name nvarchar(50) not null unique,
MarkaId int references Marka(Id)
)


CREATE TABLE BanTypes(
Id int identity primary key,
Name nvarchar(50) not null unique
)



CREATE TABLE EnginePowerTypes(
Id int identity primary key,
EnginePowerCapacity int not null unique
)


CREATE TABLE Colors(
Id int identity primary key,
Name nvarchar(50) not null unique
)


CREATE TABLE FuelTypes(
Id int identity primary key,
Name nvarchar(50) not null unique
)


CREATE TABLE MarchTypes(
Id int identity primary key,
Name nvarchar(50) not null unique
)

CREATE TABLE TransMissionTypes(
Id int identity primary key,
Name nvarchar(50) not null unique
)

CREATE TABLE PriceTypes(
Id int identity primary key,
Name nvarchar(50) not null unique
)

CREATE TABLE CarCanditionTypes(
Id int identity primary key,
Name nvarchar(10)
)


CREATE TABLE TurboElan(
Id int identity primary key,
ModelId int references Models(Id),
ColorId int references Colors(Id),
BanTypeId int references BanTypes(Id),
FuelTypeId int references FuelTypes (Id),
MarchTypeId int references MarchTypes (Id),
Marchs int,
PriceTypeId int references PriceTypes (Id),
Price int not null,
EnginePowerTypeId int references EnginePowerTypes(Id),
TransMissionTypeId int references TransMissionTypes(Id),
CarYears datetime not null,
CarCanditionTypeId int references CarCanditionTypes(Id),
ElanOwnerName nvarchar (50) not null,
ElanOwnerCity nvarchar(100),
Phone nvarchar(100) not null unique,
Email nvarchar(255) not null unique
)

Alter table TurboElan
Add  MarkaID int  references Marka(Id)

SELECT  Marka.Name 'Model',  Models.Name 'Marka'FROM Marka
Join Models
On
Models.MarkaId=Marka.Id


CREATE VIEW TurboAzToAllElan
AS
SELECT 
	   Marka.Name'Marka',
       Models.Name 'Model',
	   Colors.Name  'Reng',
	   BanTypes.Name 'Ban novu',
	   FuelTypes.Name 'Yanacaq novu',
	   TE.Marchs 'Yurus',
	   MarchTypes.NAme 'Yurus dəyəri',
	   TE.Price  'Qiymet',
	   PriceTypes.Name 'Pulun novu',
	   EnginePowerTypes.EnginePowerCapacity 'Muherrikin gucu',
	   TransMissionTypes.Name 'Suret qutusu',
	   TE.CarYears 'İli',
	   CarCanditionTypes.Name 'Veziyyeti',
	   TE.ElanOwnerName 'Name',
	   TE.ElanOwnerCity 'City',
	   TE.Phone 'Telefon',
	   TE.Email 'Email'

From TurboElan TE
Join Marka
ON Marka.Id=TE.MarkaId
JOIN Models 
ON Models.Id=TE.ModelId
JOIN Colors
ON Colors.Id=TE.ColorId
JOIN BanTypes
ON BanTypes.Id=TE.BanTypeId
JOIN FuelTypes
ON FuelTypes.Id=TE.FuelTypeId	
JOIN MarchTypes
ON MarchTypes.Id=TE.MarchTypeId
JOIN PriceTypes
ON PriceTypes.Id=TE.PriceTypeId
JOIN EnginePowerTypes
On EnginePowerTypes.Id=TE.EnginePowerTypeId
JOIN TransMissionTypes
On TransMissionTypes.Id=TE.TransMissionTypeId 
Join CarCanditionTypes
On CarCanditionTypes.Id=TE.CarCanditionTypeId

Select *From  TurboAzToAllElan
--Model adina gore axtaris
CREATE PROCEDURE ChoiceByMarka @Name nvarchar(50)
As
SELECT *FROM TurboAzToAllElan
WHERE Marka = @Name 

EXEC ChoiceByMarka 'Porseche'


--Renge gore Axtaris
CREATE PROCEDURE ChoiceByMarkaColor @Color nvarchar(50)
As
SELECT *FROM TurboAzToAllElan
WHERE [Reng]= @Color 

EXEC ChoiceByMarkaColor 'Qara'

--Ban novune gore axtaris
CREATE PROCEDURE ChoiceByBanType @BanType nvarchar(50)
As
SELECT *FROM TurboAzToAllElan
WHERE [Ban novu] = @BanType 

EXEC ChoiceByBanType 'Suv'

--Yanacaq novune gore axtaris
CREATE PROCEDURE ChoiceByFuelType @FuelType nvarchar(50)
As
SELECT *FROM TurboAzToAllElan
WHERE [Yanacaq novu] = @FuelType 

EXEC ChoiceByFuelType 'Benzin'

--Qiymete gore axtaris
CREATE PROCEDURE ChoiceByPrice @MinPrice int ,@MaxPrice int
As
SELECT *FROM TurboAzToAllElan
WHERE [Qiymet] BETWEEN @MinPrice AND @MaxPrice 

EXEC  ChoiceByPrice 33000 ,100000  


--Suretler qutusuna gore axtaris
CREATE PROCEDURE ChoiceByTransMissionType @TransMissionType nvarchar(50)
As
SELECT *FROM TurboAzToAllElan
WHERE [Suret qutusu] = @TransMissionType 

EXEC ChoiceByTransMissionType 'Avtomat'


--Avtomabilin veziyyetine gore axtaris  (Yeni ve ya islenmis)
CREATE PROCEDURE ChoiceByCarConditionType @ConditionType nvarchar(50)
As
SELECT *FROM TurboAzToAllElan
WHERE [Veziyyeti] = @ConditionType 

EXEC ChoiceByCarConditionType 'Yeni'

--Verilen elanin unvanina gore axtaris
CREATE PROCEDURE ChoiceByCarCity @CarCity nvarchar(50)
As
SELECT *FROM TurboAzToAllElan
WHERE [City]=@CarCity 

EXEC ChoiceByCarCity 'Sumqayit'


USE TurboAz



--Markaya adina gore elan sayi
CREATE FUNCTION CarNameCount(@Name nvarchar (50))
RETURNS nvarchar (50)
AS
BEGIN
      DECLARE @COUNT nvarchar (50)
      SELECT @COUNT= COUNT(*)  From TurboAzToAllElan 
      WHERE Marka = @Name
	  RETURN @Name+'nin' + ' Sayi: '+ @COUNT
END



SELECT dbo.CarNameCount ('Porseche')



