-- Отримання списку всіх співробітників та їх кваліфікації
USE it_company_management;

SELECT * FROM employee_qualifications;

-- Отримання списку клієнтів з їх статусами
SELECT * FROM client_status_view;

-- Отримання списку завдань для конкретного клієнта
SELECT 
    t.task_name,
    t.issue_date,
    t.work_hours,
    t.status,
    CONCAT(e.last_name, ' ', e.first_name) as employee,
    d.department_name
FROM 
    tasks t
    JOIN contract_tasks ct ON t.task_id = ct.task_id
    JOIN contracts c ON ct.contract_id = c.contract_id
    JOIN employees e ON t.employee_id = e.employee_id
    JOIN departments d ON t.department_id = d.department_id
WHERE 
    c.client_id = :client_id;

-- Статистика трудомісткості по відділах
SELECT * FROM task_statistics;

-- Середній час виконання завдань для кожного клієнта
SELECT 
    c.organization_name,
    COUNT(t.task_id) as total_tasks,
    AVG(t.work_hours) as avg_work_hours
FROM 
    clients c
    JOIN contracts co ON c.client_id = co.client_id
    JOIN contract_tasks ct ON co.contract_id = ct.contract_id
    JOIN tasks t ON ct.task_id = t.task_id
GROUP BY 
    c.client_id, c.organization_name;

-- Найбільш завантажений відділ
SELECT 
    department_name,
    task_count,
    total_work_hours
FROM 
    task_statistics
ORDER BY 
    total_work_hours DESC
LIMIT 1;

-- Інформація про договори та знижки
SELECT 
    c.organization_name,
    co.contract_date,
    co.discount,
    COUNT(ct.task_id) as tasks_count
FROM 
    contracts co
    JOIN clients c ON co.client_id = c.client_id
    LEFT JOIN contract_tasks ct ON co.contract_id = ct.contract_id
GROUP BY 
    co.contract_id, c.organization_name, co.contract_date, co.discount;

-- Розподіл завдань між відділами
SELECT 
    d.department_name,
    COUNT(t.task_id) as tasks_count,
    COUNT(DISTINCT t.employee_id) as employees_involved
FROM 
    departments d
    LEFT JOIN tasks t ON d.department_id = t.department_id
GROUP BY 
    d.department_id, d.department_name;

-- Завдання в процесі виконання з виконавцями
SELECT 
    t.task_name,
    t.issue_date,
    t.work_hours,
    t.status,
    CONCAT(e.last_name, ' ', e.first_name) as employee,
    d.department_name
FROM 
    tasks t
    JOIN employees e ON t.employee_id = e.employee_id
    JOIN departments d ON t.department_id = d.department_id
WHERE 
    t.status = 'in_progress';
