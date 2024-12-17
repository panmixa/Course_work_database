USE it_company_management;

-- Додавання відділів
INSERT INTO departments (department_name) VALUES 
('Розробка веб-додатків'),
('Мобільна розробка'),
('Тестування'),
('DevOps'),
('Дизайн');

-- Додавання співробітників
INSERT INTO employees (last_name, first_name, middle_name, phone, email, department_id) VALUES
('Петренко', 'Іван', 'Олександрович', '+380501234567', 'petrenko@company.com', 1),
('Коваленко', 'Марія', 'Андріївна', '+380672345678', 'kovalenko@company.com', 1),
('Сидоренко', 'Олег', 'Петрович', '+380633456789', 'sydorenko@company.com', 2),
('Мельник', 'Анна', 'Василівна', '+380994567890', 'melnyk@company.com', 3),
('Бондаренко', 'Сергій', 'Миколайович', '+380675678901', 'bondarenko@company.com', 4),
('Шевченко', 'Олена', 'Ігорівна', '+380936789012', 'shevchenko@company.com', 5),
('Ткаченко', 'Дмитро', 'Олексійович', '+380677890123', 'tkachenko@company.com', 1),
('Лисенко', 'Наталія', 'Володимирівна', '+380938901234', 'lysenko@company.com', 2);

-- Додавання навичок співробітників
INSERT INTO employee_skills (employee_id, programming_languages, database_knowledge, operating_systems) VALUES
(1, 'Java, Python, JavaScript', 'MySQL, PostgreSQL', 'Windows, Linux'),
(2, 'PHP, JavaScript, HTML, CSS', 'MySQL, MongoDB', 'Windows, MacOS'),
(3, 'Swift, Kotlin', 'SQLite, Realm', 'MacOS, Windows'),
(4, 'Python, JavaScript', 'MySQL, PostgreSQL', 'Linux, Windows'),
(5, 'Python, Bash', 'MongoDB, Redis', 'Linux, Unix'),
(6, 'HTML, CSS, JavaScript', 'MySQL', 'Windows, MacOS'),
(7, 'Java, Kotlin, JavaScript', 'Oracle, PostgreSQL', 'Windows, Linux'),
(8, 'Swift, Objective-C', 'SQLite, CoreData', 'MacOS');

-- Додавання клієнтів
INSERT INTO clients (organization_name, address, phone, email, contact_person_lastname, contact_person_firstname, contact_person_middlename, client_status) VALUES
('ТОВ "Інновація"', 'м. Київ, вул. Хрещатик, 1', '+380441234567', 'info@innovation.com', 'Іваненко', 'Петро', 'Михайлович', 'regular'),
('ПАТ "ТехноПлюс"', 'м. Львів, вул. Франка, 15', '+380322345678', 'office@technoplus.com', 'Федоренко', 'Ірина', 'Степанівна', 'permanent'),
('ТОВ "СмартСистемс"', 'м. Харків, пр. Науки, 5', '+380573456789', 'contact@smartsystems.com', 'Григоренко', 'Олексій', 'Вікторович', 'permanent'),
('ФОП Василенко', 'м. Одеса, вул. Дерибасівська, 10', '+380484567890', 'vasylenko@gmail.com', 'Василенко', 'Андрій', 'Петрович', 'regular');

-- Додавання завдань
INSERT INTO tasks (task_name, issue_date, department_id, employee_id, work_hours, status) VALUES
('Розробка веб-сайту', '2024-01-15', 1, 1, 80, 'completed'),
('Створення мобільного додатку', '2024-01-20', 2, 3, 120, 'in_progress'),
('Тестування веб-платформи', '2024-02-01', 3, 4, 40, 'completed'),
('Налаштування серверів', '2024-02-10', 4, 5, 30, 'completed'),
('Дизайн інтерфейсу', '2024-02-15', 5, 6, 50, 'in_progress'),
('Оптимізація бази даних', '2024-02-20', 1, 2, 25, 'pending'),
('Розробка API', '2024-03-01', 1, 7, 60, 'in_progress'),
('Інтеграція платіжної системи', '2024-03-05', 2, 8, 45, 'pending');

-- Додавання договорів
INSERT INTO contracts (client_id, contract_date, discount) VALUES
(1, '2024-01-10', NULL),
(2, '2024-01-15', 10.00),
(3, '2024-02-01', 15.00),
(4, '2024-02-10', NULL);

-- Зв'язування завдань з договорами
INSERT INTO contract_tasks (contract_id, task_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 5),
(3, 4),
(3, 6),
(3, 7),
(4, 8);
