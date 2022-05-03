CREATE TABLE employees_on_projects (
    project_id number(6) NOT NULL,
    employee_id number(6) NOT NULL,
    hours_worked number,
    CONSTRAINT proj_proj_id_emp_id_pk PRIMARY KEY (project_id, employee_id),
    CONSTRAINT FK_employee_id
        FOREIGN KEY (employee_id)
        REFERENCES employees (employee_id),
    CONSTRAINT FK_project_id
        FOREIGN KEY (project_id)
        REFERENCES projects (project_id)
);