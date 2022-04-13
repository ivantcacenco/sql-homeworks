INSERT INTO regions
VALUES(2, null);

INSERT INTO countries
VALUES('US', null, 2);

INSERT INTO locations
VALUES(1400, null, null, null, null, 'US');

INSERT INTO departments
VALUES(60, 'IT', null, 1400);

INSERT INTO jobs
VALUES('AD_VP', 'Administration Vice President', 15000, 30000);

INSERT INTO employees
VALUES(102,	'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '13-JAN-01', 'AD_VP', 17000, null, null, 60);

INSERT INTO job_history
VALUES(102, '13-JAN-01', '24-JUL-06', 'AD_VP', 60);