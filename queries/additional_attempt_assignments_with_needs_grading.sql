SET search_path TO canvas;

-- Additional attempt assignments from OBC and EB courses with count of needs grading after July 2023
SELECT
    a.account_name AS "Account",
    a.course_name AS "Course",
    a.assignment_name AS "Assignment",
    COUNT(CASE WHEN s.workflow_state='submitted' AND s.graded_at IS NULL THEN 1 END) AS "Needs Grading",
    a.assignment_updated_at AS "Assignment Updated At",
    'https://institution.instructure.com/courses/' || a.course_id || '/assignments/' || a.assignment_id AS "URL"
FROM submissions s
JOIN additional_attempt_assignments a
    ON a.assignment_id = s.assignment_id
WHERE
	(a.course_name LIKE '%OBC%' OR a.course_name LIKE '%EB%') AND
	a.assignment_updated_at >= '2023-07-01'
GROUP BY
    a.account_name,
    a.course_name,
    a.assignment_name,
    a.assignment_updated_at,
    a.course_id,
    a.assignment_id
ORDER BY "Needs Grading" ASC;