# Assignment 1 – The Class Bookshelf

## Decisions I made and why

I use three tables: `books`, `students` and `loans`. A loan is its own table because the relationship between students and books is many-to-many over time (one student borrows many books, one book is borrowed by many students one after another), and each loan has its own data – the dates. Every table has a `SERIAL` `id` as PRIMARY KEY, so Postgres numbers the rows itself, and `loans.book_id` / `loans.student_id` are FOREIGN KEYs, so a loan cannot point to a book or student that does not exist.

I do not store a "returned" flag or an "available" column on books: a book is out exactly when it has a loan with `returned_on IS NULL`, so storing it separately could only get out of sync. For the same reason I do not store "days kept" – it is calculated from `borrowed_on` and today's date. Since there is only one copy of each book, a partial unique index allows at most one open loan per book, and a CHECK makes sure a book cannot be returned before it was borrowed. The author is a plain text column instead of a separate table, because the task never asks anything about authors.
