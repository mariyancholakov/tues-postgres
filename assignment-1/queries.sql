-- Question 1: Which books are out right now and who has them?
-- Returns one row per unreturned loan: book title, student name, class, date taken.
SELECT b.title,
       s.first_name || ' ' || s.last_name AS student,
       s.class,
       l.borrowed_on
FROM loans l
JOIN books b    ON b.id = l.book_id
JOIN students s ON s.id = l.student_id
WHERE l.returned_on IS NULL
ORDER BY l.borrowed_on;

-- Question 2: Who has kept a book for more than 14 days, and which book is it?
-- Returns the student, the book, the date taken and how many days it has been out,
-- only for books that are still not returned and were taken more than 14 days ago.
SELECT s.first_name || ' ' || s.last_name AS student,
       s.class,
       b.title,
       l.borrowed_on,
       CURRENT_DATE - l.borrowed_on AS days_out
FROM loans l
JOIN books b    ON b.id = l.book_id
JOIN students s ON s.id = l.student_id
WHERE l.returned_on IS NULL
  AND CURRENT_DATE - l.borrowed_on > 14
ORDER BY days_out DESC;
