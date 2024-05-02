SET search_path TO canvas;

DROP VIEW IF EXISTS additional_attempt_assignments;

-- In PostgreSQL, when you use CREATE OR REPLACE VIEW, the view definition is replaced with the new definition provided.
-- However, if you change the sequence of columns in the new view definition compared to the existing view,
-- it can indeed throw an error. This is because PostgreSQL compares the new view definition with the existing one
-- and expects them to match in terms of the column sequence.

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