SET search_path TO canvas;

CREATE OR REPLACE VIEW additional_attempt_assignments AS 
    SELECT 
        a1."name" AS "account_name",
        a1.id AS "account_id",
	    c."name" AS "course_name",
	    c.id AS "course_id",
	    a.title AS "assignment_name",
	    a.id AS "assignment_id",
	    a.updated_at AS "assignment_updated_at",
	    c.workflow_state AS "course_workflow_state",
	    a.workflow_state AS "assignment_workflow_state"
    FROM assignments a
    JOIN courses c 
        ON c.id = a.context_id 
    JOIN accounts a1 
        ON a1.id  = c.account_id
    WHERE
        a.workflow_state != 'deleted' AND
	    a.title LIKE '%dditional%' AND
	    c.workflow_state != 'deleted';