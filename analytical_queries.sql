-- 1. Співробітники за конкретною технологією
-- Приклад для мови програмування
USE it_company_management;

SELECT 
    e.employee_id,
    CONCAT(e.last_name, ' ', e.first_name) as employee_name,
    es.programming_languages,
    d.department_name
FROM 
    employees e
    JOIN employee_skills es ON e.employee_id = es.employee_id
    JOIN departments d ON e.department_id = d.department_id
WHERE 
    es.programming_languages LIKE '%Java%'; 

-- Для операційної системи
SELECT 
    e.employee_id,
    CONCAT(e.last_name, ' ', e.first_name) as employee_name,
    es.operating_systems,
    d.department_name
FROM 
    employees e
    JOIN employee_skills es ON e.employee_id = es.employee_id
    JOIN departments d ON e.department_id = d.department_id
WHERE 
    es.operating_systems LIKE '%Linux%';

-- 2. Клієнти за типом завдань і періодом
SELECT 
    c.client_id,
    c.organization_name,
    COUNT(t.task_id) as tasks_count,
    SUM(t.work_hours) as total_work_hours
FROM 
    clients c
    JOIN contracts co ON c.client_id = co.client_id
    JOIN contract_tasks ct ON co.contract_id = ct.contract_id
    JOIN tasks t ON ct.task_id = t.task_id
WHERE 
    t.issue_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND t.work_hours >= 40  
GROUP BY 
    c.client_id, c.organization_name;

-- 3. Кількість завдань по відділах за період
SELECT 
    d.department_name,
    COUNT(t.task_id) as tasks_count,
    SUM(t.work_hours) as total_work_hours
FROM 
    departments d
    LEFT JOIN tasks t ON d.department_id = t.department_id
WHERE 
    t.issue_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY 
    d.department_id, d.department_name;

-- 4. Середня трудомісткість завдань
-- Для співробітника
SELECT 
    CONCAT(e.last_name, ' ', e.first_name) as employee_name,
    COUNT(t.task_id) as tasks_count,
    AVG(t.work_hours) as avg_work_hours
FROM 
    employees e
    LEFT JOIN tasks t ON e.employee_id = t.employee_id
WHERE 
    t.issue_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY 
    e.employee_id, e.last_name, e.first_name;

-- Для відділу
SELECT 
    d.department_name,
    COUNT(t.task_id) as tasks_count,
    AVG(t.work_hours) as avg_work_hours
FROM 
    departments d
    LEFT JOIN tasks t ON d.department_id = t.department_id
WHERE 
    t.issue_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY 
    d.department_id, d.department_name;

-- 5. Кількість завдань для клієнта по відділах
SELECT 
    c.organization_name,
    d.department_name,
    COUNT(t.task_id) as tasks_count,
    SUM(t.work_hours) as total_work_hours
FROM 
    clients c
    JOIN contracts co ON c.client_id = co.client_id
    JOIN contract_tasks ct ON co.contract_id = ct.contract_id
    JOIN tasks t ON ct.task_id = t.task_id
    JOIN departments d ON t.department_id = d.department_id
WHERE 
    c.client_id = :client_id
GROUP BY 
    c.client_id, c.organization_name, d.department_id, d.department_name;

-- 6. Знижки постійних клієнтів
SELECT 
    c.organization_name,
    c.client_status,
    co.contract_date,
    co.discount,
    COUNT(ct.task_id) as tasks_in_contract
FROM 
    clients c
    JOIN contracts co ON c.client_id = co.client_id
    LEFT JOIN contract_tasks ct ON co.contract_id = ct.contract_id
WHERE 
    c.client_status = 'permanent'
GROUP BY 
    c.client_id, c.organization_name, c.client_status, co.contract_date, co.discount;

-- 7. Трудомісткість завдань співробітника
SELECT 
    CONCAT(e.last_name, ' ', e.first_name) as employee_name,
    t.task_name,
    t.issue_date,
    t.work_hours,
    t.status
FROM 
    employees e
    JOIN tasks t ON e.employee_id = t.employee_id
WHERE 
    e.employee_id = :employee_id 
    AND t.issue_date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY 
    t.issue_date;

-- 8. Статистика виконання завдань для клієнтів
SELECT 
    c.organization_name,
    COUNT(t.task_id) as total_tasks,
    AVG(t.work_hours) as avg_work_hours,
    MIN(t.work_hours) as min_work_hours,
    MAX(t.work_hours) as max_work_hours
FROM 
    clients c
    JOIN contracts co ON c.client_id = co.client_id
    JOIN contract_tasks ct ON co.contract_id = ct.contract_id
    JOIN tasks t ON ct.task_id = t.task_id
WHERE 
    c.client_id IN (:client_ids)
GROUP BY 
    c.client_id, c.organization_name;

-- 9. Завантаженість відділів
SELECT 
    d.department_name,
    COUNT(DISTINCT t.employee_id) as employees_involved,
    COUNT(t.task_id) as total_tasks,
    SUM(t.work_hours) as total_work_hours,
    AVG(t.work_hours) as avg_task_hours
FROM 
    departments d
    LEFT JOIN tasks t ON d.department_id = t.department_id
GROUP BY 
    d.department_id, d.department_name;

-- 10. Виконання завдань у межах договору
SELECT 
    c.organization_name,
    co.contract_date,
    t.task_name,
    t.issue_date,
    t.work_hours,
    t.status,
    CONCAT(e.last_name, ' ', e.first_name) as employee_name,
    d.department_name
FROM 
    contracts co
    JOIN clients c ON co.client_id = c.client_id
    JOIN contract_tasks ct ON co.contract_id = ct.contract_id
    JOIN tasks t ON ct.task_id = t.task_id
    JOIN employees e ON t.employee_id = e.employee_id
    JOIN departments d ON t.department_id = d.department_id
WHERE 
    co.contract_id = :contract_id
ORDER BY 
    t.issue_date;
