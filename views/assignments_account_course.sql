SET search_path TO canvas;

DROP VIEW IF EXISTS assignments_account_course;

CREATE OR REPLACE VIEW assignments_account_course AS
    SELECT
        a1."name" AS "account_name",
        a1.id AS "account_id",
	    c."name" AS "course_name",
	    c.id AS "course_id",
	    a.title AS "assignment_name",
	    a.id AS "assignment_id",
	    c.workflow_state AS "course_workflow_state",
	    a.workflow_state AS "assignment_workflow_state",
	    a1.workflow_state AS "account_workflow_state",
	    a.created_at AS "assignment_created_at",
	   	a.updated_at AS "assignment_updated_at",
	   	a.points_possible,
	   	a.due_at,
	   	a.unlock_at,
	   	a.lock_at,
	   	a.grading_type,
	   	a.assignment_group_id,
	   	a.grading_standard_id,
	   	a.context_id,
	   	a.context_type
    FROM assignments a
    JOIN courses c
        ON c.id = a.context_id
    JOIN accounts a1
        ON a1.id  = c.account_id
    WHERE
        a.workflow_state != 'deleted' AND
        c.workflow_state != 'deleted' AND
        a1.workflow_state != 'deleted';