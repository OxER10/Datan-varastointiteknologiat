CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    fname VARCHAR(32),
    lname VARCHAR(64),
    salary FLOAT,
    bdate DATE,
    department_id INT
);

CREATE TABLE department (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);