CREATE TABLE projects (
    project_id number(6) PRIMARY KEY,
    project_description varchar2(200) CHECK (LENGTH(project_description) > 10),
    project_investments number CHECK (project_investments > 0),
    project_revenue number(10, -3)
);

CREATE SEQUENCE projects_seq START WITH 100 INCREMENT BY 1 NOCACHE;

ALTER TABLE projects
    MODIFY project_id DEFAULT projects_seq.NEXTVAL;