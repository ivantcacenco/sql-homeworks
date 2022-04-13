CREATE TABLE employment_logs (
    employment_log_id number(6),
    first_name varchar2(20),
    last_name varchar2(25),
    employment_action varchar(5) CHECK (employment_action IN ('FIRED', 'HIRED')),
    employment_status_updtd_tmstmp TIMESTAMP
);

CREATE SEQUENCE emp_log_seq NOCACHE;

ALTER TABLE employment_logs MODIFY
    employment_log_id DEFAULT emp_log_seq.NEXTVAL;

CREATE OR REPLACE PROCEDURE insert_employment_log (
    first_name varchar2, last_name varchar2, employment_action varchar)
AS
BEGIN
    INSERT INTO employment_logs (first_name, last_name, employment_action, employment_status_updtd_tmstmp)
    VALUES (first_name, last_name, employment_action, CURRENT_TIMESTAMP);
END;

CREATE OR REPLACE TRIGGER update_amount_of_departments
AFTER insert or delete
ON employees
BEGIN
    IF INSERTING THEN
		insert_employment_log(:new.first_name, :new.last_name, 'HIRED');
	ELSE
		insert_employment_log(:old.first_name, :old.last_name, 'FIRED');
	END IF;
END;
/