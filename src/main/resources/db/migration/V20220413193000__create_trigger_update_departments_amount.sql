ALTER TABLE locations
ADD department_amount number;

COMMENT ON COLUMN locations.department_amount IS 'Contains the amount of departments in the location';

CREATE OR REPLACE TRIGGER update_amount_of_departments
AFTER insert or delete
ON departments
BEGIN
FOR i IN ( SELECT location_id, COUNT(department_id) as department_amount FROM departments GROUP BY location_id)
LOOP
UPDATE locations
SET department_amount = i.department_amount
WHERE location_id = i.location_id;
END LOOP;
END;