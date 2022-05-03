CREATE TABLE pay (
    card_nr number(6) PRIMARY KEY,
    salary number(8,2) CHECK (salary > 0),
    commission_pct number(2,2),
    employee_id number(6),
    CONSTRAINT pay_emp_fk
                FOREIGN KEY (employee_id)
                REFERENCES employees(employee_id)
);

CREATE SEQUENCE pay_seq NOCACHE;

ALTER TABLE pay MODIFY
    card_nr DEFAULT pay_seq.NEXTVAL;

INSERT INTO pay (salary, commission_pct, employee_id)
SELECT salary, commission_pct, employee_id
FROM employees;