#1
(Select c.name as Coach, sg.location as Place
FROM coaches as c LEFT JOIN sportGroups as sg
ON c.id = sg.coach_id)
UNION
(Select coaches.id, sportGroups.location
FROM coaches RIGHT JOIN sportGroups
ON coaches.id = sportGroups.coach_id);

#2
Select firstStud.name as Student1, secondStud.name as Student2, sports.name as Sport
FROM students as firstStud JOIN students as secondStud
ON firstStud.id < secondStud.id
JOIN sports ON (firstStud.id IN (Select student_id
								FROM student_sport
								WHERE sportGroup_id IN (Select id FROM
                                                        sportGroups WHERE 
                                                        sportGroups.sport_id = sports.id
                                                        )
												)
AND(secondStud.id IN (Select student_id
					FROM student_sport
                    WHERE 
                    sportGroup_id IN(Select id FROM
                    sportGroups
                    WHERE
                    sportGroups.sport_id = sports.id
                    )
				)
			)
		)
WHERE firstStud.id IN(Select student_id
FROM student_sport
WHERE 
sportGroup_id IN(Select sportGroup_id
FROM student_sport
WHERE
student_id = secondStud.id)
)
ORDER BY SPORT;