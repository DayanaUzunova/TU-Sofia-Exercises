SELECT coaches.name, sports.name
FROM coaches JOIN sports
ON coaches.id IN(
SELECT coach_id FROM sportGroups 
WHERE sportGroups.sport_id=sports.id);

SELECT distinct coaches.name, sports.name
FROM coaches JOIN sportGroups ON coaches.id=sportGroups.coach_id
JOIN sports ON sports.id=sportGroups.sport_id;