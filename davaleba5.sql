-- task 1
DROP DATABASE IF EXISTS library;
CREATE DATABASE library;
USE library;


-- task 2
CREATE TABLE authors (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    country    VARCHAR(50)  NOT NULL,
    birth_year INT          NOT NULL,
    CONSTRAINT chk_authors_birth_year CHECK (birth_year > 1000)
);



-- Task 3
CREATE TABLE books (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    title          VARCHAR(150)  NOT NULL,
    author_id      INT           NOT NULL,
    genre          VARCHAR(30)   NOT NULL,
    pages          INT           NOT NULL,
    published_year INT,
    price          DECIMAL(6,2)  NOT NULL DEFAULT 0,
    copies         INT           NOT NULL DEFAULT 1,
    CONSTRAINT fk_books_author     FOREIGN KEY (author_id) REFERENCES authors (id),
    CONSTRAINT chk_books_pages     CHECK (pages > 0),
    CONSTRAINT chk_books_year      CHECK (published_year > 1000),
    CONSTRAINT chk_books_price     CHECK (price >= 0),
    CONSTRAINT chk_books_copies    CHECK (copies >= 0)
);
-- task 4
CREATE TABLE members (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50)  NOT NULL,
    last_name  VARCHAR(50)  NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    city       VARCHAR(50)  NOT NULL,
    birth_date DATE,
    joined_on  DATE         NOT NULL,
    CONSTRAINT chk_members_email  CHECK (email LIKE '%@%'),
    CONSTRAINT chk_members_joined CHECK (joined_on > birth_date)
);

-- Task 5
CREATE TABLE loans (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    book_id     INT  NOT NULL,
    member_id   INT  NOT NULL,
    loan_date   DATE NOT NULL,
    return_date DATE,
    CONSTRAINT fk_loans_book   FOREIGN KEY (book_id)   REFERENCES books (id),
    CONSTRAINT fk_loans_member FOREIGN KEY (member_id) REFERENCES members (id),
    CONSTRAINT chk_loans_return CHECK (return_date IS NULL OR return_date >= loan_date)
);




-- Task 6
ALTER TABLE members ADD COLUMN phone VARCHAR(20);


-- Task 7
INSERT INTO authors (name, country, birth_year) VALUES
('Ilia Chavchavadze', 'Georgia',        1837),
('Nodar Dumbadze',    'Georgia',        1928),
('Vazha-Pshavela',    'Georgia',        1861),
('J.R.R. Tolkien',    'United Kingdom', 1892),
('George Orwell',     'United Kingdom', 1903),
('Agatha Christie',   'United Kingdom', 1890),
('Jules Verne',       'France',         1828),
('Mark Twain',        'USA',            1835);

-- task 8
INSERT INTO members (first_name, last_name, email, city, birth_date, joined_on, phone) VALUES
('Nika',    'Beridze',      'nika.b@gmail.com',    'Tbilisi', '2009-03-14', '2025-09-01', '555 12 34 56'),
('Ana',     'Kapanadze',    'ana.k@mail.ge',       'Batumi',  '2010-07-22', '2025-09-15', NULL),
('Giorgi',  'Lomidze',      'giorgi.l@gmail.com',  'Kutaisi', '2008-11-05', '2025-10-02', '599 34 56 78'),
('Mariam',  'Gelashvili',   'mariam.g@gmail.com',  'Tbilisi', '2007-05-30', '2026-01-20', '551 45 67 89'),
('Luka',    'Tsiklauri',    'luka.t@gmail.com',    'Rustavi', '2009-09-12', '2026-02-11', NULL),
('Nino',    'Abashidze',    'nino.a@yahoo.com',    'Tbilisi', '2010-01-25', '2026-03-03', '593 67 89 01'),
('Dato',    'Maisuradze',   'dato.m@gmail.com',    'Batumi',  '2008-12-01', '2026-04-18', '571 11 22 33'),
('Salome',  'Javakhishvili','salome.j@gmail.com',  'Zugdidi', '2011-04-18', '2026-09-09', NULL);

-- Task 9
INSERT INTO books (title, author_id, genre, pages, published_year, price, copies) VALUES
('The Hobbit',                            4, 'Fantasy',   310, 1937, 24.90, 4),
('The Fellowship of the Ring',            4, 'Fantasy',   423, 1954, 32.50, 3),
('The Two Towers',                        4, 'Fantasy',   352, 1954, 32.50, 3),
('1984',                                  5, 'Dystopia',  328, 1949, 19.90, 5),
('Animal Farm',                           5, 'Dystopia',  112, 1945, 12.50, 6),
('Murder on the Orient Express',          6, 'Detective', 256, 1934, 15.00, 3),
('And Then There Were None',              6, 'Detective', 272, 1939, 15.00, 2),
('Around the World in Eighty Days',       7, 'Adventure', 240, 1872, 14.20, 3),
('Twenty Thousand Leagues Under the Sea', 7, 'Adventure', 498, 1870, 18.90, 2),
('The Adventures of Tom Sawyer',          8, 'Adventure', 274, 1876, 13.40, 4),
('Kacia-Adamiani?',                       1, 'Classic',   160, 1863, 10.00, 3),
('Otarants Kvrivi',                       1, 'Classic',   140, 1888,  9.50, 2),
('Me, Grandma, Iliko and Illarion',       2, 'Novel',     220, 1960, 11.00, 3),
('The Law of Eternity',                   2, 'Novel',     304, 1975, 14.00, 3),
('Aluda Ketelauri',                       3, 'Poetry',     64, 1888,  8.00, 2),
('Host and Guest',                        3, 'Poetry',     72, 1893,  8.50, 1);

INSERT INTO loans (book_id, member_id, loan_date, return_date) VALUES
( 1, 1, '2026-01-10', '2026-01-24'),
( 4, 2, '2026-01-12', '2026-01-30'),
(13, 3, '2026-01-15', '2026-02-01'),
( 2, 1, '2026-02-02', '2026-02-20'),
( 6, 4, '2026-02-03', '2026-02-19'),
( 1, 6, '2026-02-10', '2026-02-25'),
(10, 3, '2026-03-01', '2026-03-15'),
( 4, 8, '2026-03-04', '2026-03-20'),
(13, 4, '2026-03-10', '2026-03-25'),
( 5, 7, '2026-04-20', '2026-05-02'),
( 1, 2, '2026-05-05', '2026-05-19'),
( 3, 1, '2026-05-12', '2026-06-01'),
(11, 6, '2026-06-03', '2026-06-17'),
( 7, 4, '2026-07-05', '2026-07-22'),
(13, 1, '2026-09-14', '2026-09-30'),
( 9, 3, '2026-10-01', NULL),
( 1, 4, '2026-10-12', NULL),
( 5, 7, '2026-10-15', NULL),
(14, 6, '2026-10-20', NULL),
( 4, 1, '2026-10-25', NULL);

SELECT COUNT(*) FROM books;
SELECT COUNT(*) FROM loans;

-- Task 10
INSERT INTO books (title, author_id, genre, pages, published_year, price)
VALUES ('Lord of the Rings Companion', 4, 'Fantasy', 200, 1999, 20.00);
SELECT * FROM books WHERE title = 'Lord of the Rings Companion';

-- Task 11

-- task 12
UPDATE members SET city = 'Kutaisi' WHERE first_name = 'Dato' AND last_name = 'Maisuradze';

-- task 13
UPDATE books SET price = price * 1.10 WHERE genre = 'Fantasy';

-- Task 14
UPDATE loans SET return_date = '2026-11-05' WHERE id = 16;

-- Task 15
DELETE FROM books WHERE id = 17;

-- task 16
SELECT title, pages FROM books;

-- Task 17
SELECT * FROM books WHERE genre = 'Fantasy';


-- task 18
SELECT title, pages FROM books WHERE pages > 400 ORDER BY pages DESC;

-- Task 19
SELECT first_name, city FROM members WHERE city IN ('Tbilisi', 'Kutaisi');

-- Task 20
SELECT title, published_year FROM books WHERE published_year BETWEEN 1900 AND 1999;


-- task 21
SELECT * FROM authors WHERE name LIKE 'J%';
SELECT * FROM books WHERE title LIKE '%the%';



-- Task 22
SELECT * FROM members WHERE phone IS NULL;

-- Task 23
SELECT * FROM loans WHERE return_date IS NULL;

-- task 24
SELECT title, price FROM books ORDER BY price LIMIT 3;


-- Task 25
SELECT DISTINCT genre FROM books ORDER BY genre;


-- task 26
SELECT title, price, copies, price * copies AS stock_value
FROM books ORDER BY stock_value DESC;

-- Task 27
SELECT CONCAT(first_name, ' ', last_name) AS full_name, joined_on
FROM members WHERE YEAR(joined_on) = 2026;

-- Task 28
SELECT COUNT(DISTINCT title) AS different_books, SUM(copies) AS total_copies,
       ROUND(AVG(price), 2) AS avg_price
FROM books;


-- task 29
SELECT MIN(price) AS cheapest, MAX(price) AS most_expensive,
       MIN(published_year) AS oldest_year
FROM books;

-- Task 30
SELECT genre, COUNT(*) AS book_count FROM books
GROUP BY genre ORDER BY book_count DESC;

-- Task 31
SELECT genre, ROUND(AVG(pages)) AS avg_pages FROM books
GROUP BY genre HAVING AVG(pages) > 250;



-- Task 32
SELECT city, COUNT(*) AS member_count FROM members
GROUP BY city HAVING COUNT(*) >= 2;

-- task 33
SELECT member_id, COUNT(*) AS loan_count FROM loans
GROUP BY member_id ORDER BY loan_count DESC;


-- Task 34
SELECT book_id, COUNT(*) AS times_borrowed FROM loans
GROUP BY book_id ORDER BY times_borrowed DESC LIMIT 3;

-- task 35
SELECT MONTH(loan_date) AS month, COUNT(*) AS loan_count FROM loans
WHERE YEAR(loan_date) = 2026 AND return_date IS NOT NULL
GROUP BY MONTH(loan_date) ORDER BY month;

-- Task 36
SELECT title, price FROM books WHERE price > (SELECT AVG(price) FROM books);

-- task 37
SELECT title FROM books
WHERE author_id = (SELECT id FROM authors WHERE name = 'George Orwell');

-- Task 38
SELECT first_name, last_name FROM members
WHERE id NOT IN (SELECT member_id FROM loans);

-- Task 39
SELECT title FROM books
WHERE id IN (SELECT book_id FROM loans WHERE return_date IS NULL);


-- Task 40
SELECT name FROM authors
WHERE id IN (
    SELECT author_id FROM books
    WHERE id IN (
        SELECT book_id FROM loans
        WHERE member_id IN (SELECT id FROM members WHERE city = 'Tbilisi')
    )
);



-- Bonus 1
SELECT title FROM books
WHERE id = (SELECT book_id FROM loans GROUP BY book_id ORDER BY COUNT(*) DESC LIMIT 1);

-- Bonus 2
SELECT genre, title, pages FROM books b
WHERE pages = (SELECT MAX(pages) FROM books WHERE genre = b.genre);
