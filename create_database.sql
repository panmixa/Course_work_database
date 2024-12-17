-- Create database
CREATE DATABASE IF NOT EXISTS it_company_management;
USE it_company_management;

-- Create departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL
);

-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Create employee skills table
CREATE TABLE employee_skills (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    programming_languages TEXT,
    database_knowledge TEXT,
    operating_systems TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Create clients table
CREATE TABLE clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    organization_name VARCHAR(200) NOT NULL,
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100),
    contact_person_lastname VARCHAR(50),
    contact_person_firstname VARCHAR(50),
    contact_person_middlename VARCHAR(50),
    client_status ENUM('regular', 'permanent') DEFAULT 'regular'
);

-- Create tasks table
CREATE TABLE tasks (
    task_id INT PRIMARY KEY AUTO_INCREMENT,
    task_name VARCHAR(200) NOT NULL,
    issue_date DATE NOT NULL,
    department_id INT,
    employee_id INT,
    work_hours INT NOT NULL,
    status ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Create contracts table
CREATE TABLE contracts (
    contract_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    contract_date DATE NOT NULL,
    discount DECIMAL(5,2),
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

-- Create contract_tasks table (for mapping tasks to contracts)
CREATE TABLE contract_tasks (
    contract_id INT,
    task_id INT,
    PRIMARY KEY (contract_id, task_id),
    FOREIGN KEY (contract_id) REFERENCES contracts(contract_id),
    FOREIGN KEY (task_id) REFERENCES tasks(task_id)
);

-- Insert some sample data for departments
INSERT INTO departments (department_name) VALUES 
('Development'),
('Testing'),
('Design'),
('Management');

-- Create views for common queries

-- View for employee qualifications
CREATE VIEW employee_qualifications AS
SELECT 
    e.employee_id,
    CONCAT(e.last_name, ' ', e.first_name, ' ', COALESCE(e.middle_name, '')) as full_name,
    es.programming_languages,
    es.database_knowledge,
    es.operating_systems,
    d.department_name
FROM 
    employees e
    LEFT JOIN employee_skills es ON e.employee_id = es.employee_id
    LEFT JOIN departments d ON e.department_id = d.department_id;

-- View for client status
CREATE VIEW client_status_view AS
SELECT 
    client_id,
    organization_name,
    phone,
    email,
    client_status,
    CONCAT(contact_person_lastname, ' ', contact_person_firstname, ' ', COALESCE(contact_person_middlename, '')) as contact_person
FROM 
    clients;

-- View for task statistics
CREATE VIEW task_statistics AS
SELECT 
    d.department_name,
    COUNT(t.task_id) as task_count,
    AVG(t.work_hours) as avg_work_hours,
    SUM(t.work_hours) as total_work_hours
FROM 
    departments d
    LEFT JOIN tasks t ON d.department_id = t.department_id
GROUP BY 
    d.department_id, d.department_name;
