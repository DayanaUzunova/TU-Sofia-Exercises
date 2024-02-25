CREATE VIEW sportLocation
AS
Select sports.name, sportGroups.location
From sports JOIN sportGroups
ON sports.id = sportGroups.sport_id;

Select * from sportLocation;

DROP VIEW sportLocation;