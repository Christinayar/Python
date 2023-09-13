##############################################################
1.Основы реляционной модели и SQL
##############################################################


1.1 Отношение (таблица) 

1. Сформулируйте SQL запрос для создания таблицы book, занесите  его в окно кода (расположено ниже) и отправьте на проверку

CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT
);

2. Занесите новую строку в таблицу book, (текстовые значения (тип VARCHAR) заключать либо в двойные, либо в одинарные кавычки)

INSERT INTO book (title, author, price, amount) 
            VALUES ('Мастер и Маргарита','Булгаков М.А.', 670.99, 3);

SELECT * FROM book;

3. Занесите три последние записи в таблицуbook,  первая запись уже добавлена на предыдущем шаге:

INSERT INTO book (title, author, price, amount)
VALUES
    ('Белая гвардия', 'Булгаков М.А.', 540.50 , 5),
    ('Идиот', 'Достоевский Ф.М.', 460, 10),
    ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2);

1.2 Выборка данных

1. Вывести информацию о всех книгах, хранящихся на складе

SELECT * FROM book;

2. Выбрать авторов, название книг и их цену из таблицы book.

SELECT author, title, price
FROM book;

3. Выбрать названия книг и авторов из таблицы book, для поля title задать имя(псевдоним) Название, для поля author –  Автор.

SELECT title as Название, author as  Автор
FROM book;

4. Для упаковки каждой книги требуется 1 лист бумаги, цена которого 1 рубль 65 копеек. 
Посчитать стоимость упаковки для каждой книги (сколько денег потребуется, чтобы упаковать все экземпляры книги).
В запросе вывести название книги, ее количество и стоимость упаковки, последний столбец назвать pack

SELECT title, amount,
    amount * 1.65 AS pack
FROM book;

5. В конце года цену всех книг на складе пересчитывают – снижают ее на 30%. 
Написать SQL запрос, который из таблицы book выбирает названия, авторов, количества и вычисляет новые цены книг.
Столбец с новой ценой назвать new_price, цену округлить до 2-х знаков после запятой.

SELECT title, author, amount,
 ROUND(price*0.7, 2) AS new_price
FROM book

6. При анализе продаж книг выяснилось, что наибольшей популярностью пользуются книги Михаила Булгакова, на втором месте книги Сергея Есенина.
 Исходя из этого решили поднять цену книг Булгакова на 10%, а цену книг Есенина - на 5%. 
 Написать запрос, куда включить автора, название книги и новую цену, последний столбец назвать new_price. 
 Значение округлить до двух знаков после запятой.

SELECT author, title,
ROUND(IF(author = 'Булгаков М.А.', price * 1.1, IF(author = 'Есенин С.А.', price * 1.05, price)), 2) 
AS new_price
FROM book;

SELECT author, title, 
ROUND(
    CASE author
    WHEN "Булгаков М.А." THEN price * 1.1
    WHEN "Есенин С.А." THEN price * 1.05
    ELSE price END, 2)
    AS new_price
FROM book

7. Вывести автора, название  и цены тех книг, количество которых меньше 10.

SELECT author, title, price
FROM book
WHERE amount < 10;

8. Вывести название, автора,  цену  и количество всех книг, цена которых меньше 500 или больше 600, 
а стоимость всех экземпляров этих книг больше или равна 5000.

SELECT title, author, price, amount
FROM book
WHERE (price < 500 OR price > 600) and (amount * price >= 5000);

9. Вывести название и авторов тех книг, цены которых принадлежат интервалу от 540.50 до 800 (включая границы),
а количество или 2, или 3, или 5, или 7.

SELECT title, author
FROM book
WHERE (price BETWEEN 540.50 AND 800) AND amount IN ('2', '3', '5', '7');

10. Вывести  автора и название  книг, количество которых принадлежит интервалу от 2 до 14 (включая границы). 
Информацию  отсортировать сначала по авторам (в обратном алфавитном порядке), а затем по названиям книг (по алфавиту).

SELECT author, title
FROM book
WHERE amount BETWEEN 2 AND 14
ORDER BY 1 DESC, 2;

11. Вывести название и автора тех книг, название которых состоит из двух и более слов, а инициалы автора содержат букву «С». 
Считать, что в названии слова отделяются друг от друга пробелами и не содержат знаков препинания, 
между фамилией автора и инициалами обязателен пробел, инициалы записываются без пробела в формате: буква, точка, буква, точка. 
Информацию отсортировать по названию книги в алфавитном порядке.

SELECT title, author
FROM book
WHERE author LIKE '%С.%' and title LIKE "_% _%";

1.3 Запросы, групповые операции

1. Отобрать различные (уникальные) элементы столбца amount таблицы book.

SELECT amount
FROM book
GROUP BY amount;

SELECT DISTINCT amount
FROM book;

2. Посчитать, количество различных книг и количество экземпляров книг каждого автора, хранящихся на складе. 
 Столбцы назвать Автор, Различных_книг и Количество_экземпляров соответственно.

SELECT author AS Автор, COUNT(title) AS Различных_книг, SUM(amount) AS Количество_экземпляров
FROM book
GROUP BY author;

3. Вывести фамилию автора, минимальную, максимальную и среднюю цену книг каждого автора . 
Вычисляемые столбцы назвать Минимальная_цена, Максимальная_цена и Средняя_цена соответственно.

SELECT author, MIN(price) AS Минимальная_цена, MAX(price) AS Максимальная_цена, AVG(price) AS Средняя_цена
FROM book
GROUP BY author;

4. Для каждого автора вычислить суммарную стоимость книг S (имя столбца Стоимость),
 а также вычислить налог на добавленную стоимость  для полученных сумм (имя столбца НДС ), 
 который включен в стоимость и составляет k = 18%,  а также стоимость книг  (Стоимость_без_НДС) без него. 
 Значения округлить до двух знаков после запятой. 

SELECT author, SUM(price * amount) AS Стоимость,
ROUND(SUM((price * amount) * 0.18 / 1.18), 2) AS НДС,
ROUND(SUM((price * amount) / 1.18), 2) AS Стоимость_без_НДС
FROM book
GROUP BY author;

5. Вывести  цену самой дешевой книги, цену самой дорогой и среднюю цену книг на складе.
 Названия столбцов Минимальная_цена, Максимальная_цена, Средняя_цена соответственно. Среднюю цену округлить до двух знаков после запятой.

SELECT MIN(price) AS Минимальная_цена, 
       MAX(price) AS Максимальная_цена,
       ROUND(AVG(price), 2) AS Средняя_цена
  FROM book;

6. Вычислить среднюю цену и суммарную стоимость тех книг, количество экземпляров которых принадлежит интервалу от 5 до 14, включительно.
 Столбцы назвать Средняя_цена и Стоимость, значения округлить до 2-х знаков после запятой.

SELECT
    ROUND(AVG(price), 2) AS Средняя_цена, 
    ROUND(SUM(price * amount), 2) AS Стоимость
FROM book
WHERE amount BETWEEN 5 AND 14;

7. Посчитать стоимость всех экземпляров каждого автора без учета книг «Идиот» и «Белая гвардия».
В результат включить только тех авторов, у которых суммарная стоимость книг более 5000 руб. Вычисляемый столбец назвать Стоимость. 
Результат отсортировать по убыванию стоимости.

SELECT author, SUM(price * amount) AS Стоимость
FROM book 
WHERE title NOT IN ('Идиот', 'Белая гвардия')
GROUP BY author 
HAVING SUM(amount) > 5000
ORDER BY 1 DESC;

1.4 Вложенные запросы

1. Вывести информацию (автора, название и цену) о  книгах, цены которых меньше или равны средней цене книг на складе. 
Информацию вывести в отсортированном по убыванию цены виде. Среднее вычислить как среднее по цене книги.

SELECT author, title, price
FROM book
WHERE price <= (SELECT AVG(price) FROM book)
ORDER BY(price) DESC; 

2. Вывести информацию (автора, название и цену) о тех книгах, цены которых превышают минимальную цену книги на складе не более чем на 150 рублей 
в отсортированном по возрастанию цены виде.

SELECT author, title, price
FROM book
WHERE ABS(price - (SELECT MIN(price) FROM book)) <= 150
ORDER BY(price);

3. Вывести информацию (автора, книгу и количество) о тех книгах, количество экземпляров которых в таблице book не дублируется.

SELECT author, title, amount
FROM book
WHERE amount IN (
    SELECT amount 
    FROM book
    GROUP BY (amount)
    HAVING COUNT(amount) = 1);


4. Вывести информацию о книгах(автор, название, цена), цена которых меньше самой большой из минимальных цен, вычисленных для каждого автора.

SELECT author, title, price
FROM book
WHERE price < ANY (
    SELECT MIN(price)
    FROM book
    GROUP BY author
    );

5. Посчитать сколько и каких экземпляров книг нужно заказать поставщикам, чтобы на складе стало одинаковое количество экземпляров каждой книги, 
равное значению самого большего количества экземпляров одной книги на складе.
Вывести название книги, ее автора,текущее количество экземпляров на складе и количество заказываемых экземпляров книг. 
Последнему столбцу присвоить имя Заказ.

SELECT title, author, amount, 
    (SELECT MAX(amount) FROM book) - amount AS Заказ
  FROM book
 WHERE amount <> 15;

1.5 Запросы корректировки данных

1. Создать таблицу поставка (supply), которая имеет ту же структуру, что и таблиц book.

CREATE TABLE supply(
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT
);

2. Занесите в таблицу supply четыре записи, чтобы получилась следующая таблица:

INSERT INTO supply (title, author, price, amount)
     VALUES 
        ('Лирика', 'Пастернак Б.Л.', 518.99, 2),
        ('Черный человек', 'Есенин С.А.', 570.20, 6),
        ('Белая гвардия', 'Булгаков М.А.', 540.50, 7),
        ('Идиот', 'Достоевский Ф.М.', 360.80, 3);

3. Добавить из таблицы supply в таблицу book, все книги, кроме книг, написанных Булгаковым М.А. и Достоевским Ф.М.

INSERT INTO book (title, author, price, amount)
     SELECT title, author, price, amount 
       FROM supply
      WHERE author NOT IN ('Булгаков М.А.', 'Достоевский Ф.М.');

4. Занести из таблицы supply в таблицу book только те книги, авторов которых нет в book.

INSERT INTO book (title, author, price, amount) 
SELECT title, author, price, amount
FROM supply
WHERE author NOT IN (
        SELECT author 
        FROM book
      );

SELECT * FROM book

5. Уменьшить на 10% цену тех книг в таблице book, количество которых принадлежит интервалу от 5 до 10 включительно.

UPDATE book
SET price = 0.9 * price
WHERE amount BETWEEN 5 AND 10;
SELECT * FROM book

6. В таблице book необходимо скорректировать значение для покупателя в столбце buy таким образом, 
чтобы оно не превышало допустимый остаток в столбце amount. А цену тех книг, которые покупатель не заказывал, снизить на 10%.

UPDATE book
SET buy = IF(buy > amount, amount, buy),
    price = IF(buy = 0, price * 0.9, price);
SELECT * FROM book

7. Для тех книг в таблице book , которые есть в таблице supply, не только увеличить их количество в таблице book 
(увеличить их количество на значение столбца amountтаблицы supply),
но и пересчитать их цену (для каждой книги найти сумму цен из таблиц book и supply и разделить на 2).

UPDATE book, supply
SET book.amount = book.amount + supply.amount,
    book.price = (book.price + supply.price) / 2
WHERE book.title = supply.title AND book.author = supply.author;

SELECT * FROM book;

8. Удалить из таблицы supply книги тех авторов, общее количество экземпляров книг которых в таблице book превышает 10.

DELETE FROM supply
WHERE author IN (
    SELECT author
    FROM book
    WHERE amount >= 10
    );

SELECT * FROM supply;

9. Создать таблицу заказ (ordering), куда включить авторов и названия тех книг, количество экземпляров которых в таблице book 
меньше среднего количества экземпляров книг в таблице book. В таблицу включить столбец amount,
в котором для всех книг указать одинаковое значение - среднее количество экземпляров книг в таблице book.

CREATE TABLE ordering AS
SELECT author, title,
    (
    SELECT ROUND(AVG(amount)) 
    FROM book
    ) AS amount
FROM book
WHERE amount < (SELECT ROUND(AVG(amount)) FROM book);

SELECT * FROM ordering;        


1.6 Таблица "Командировки", запросы на выборку

1. Вывести из таблицы trip информацию о командировках тех сотрудников, фамилия которых заканчивается на букву «а», 
в отсортированном по убыванию даты последнего дня командировки виде.
В результат включить столбцы name, city, per_diem, date_first, date_last.

SELECT name, city, per_diem, date_first, date_last
  FROM trip
 WHERE name LIKE '%а %'
 ORDER BY date_last DESC;

 2. Вывести в алфавитном порядке фамилии и инициалы тех сотрудников, которые были в командировке в Москве.

SELECT DISTINCT name
FROM trip
WHERE city = 'Москва'
ORDER BY name;

3. Для каждого города посчитать, сколько раз сотрудники в нем были. Информацию вывести в отсортированном в алфавитном порядке по названию городов. 
Вычисляемый столбец назвать Количество. 

SELECT city, COUNT(city) AS Количество
FROM trip
GROUP BY city
ORDER BY city;

4. Вывести два города, в которых чаще всего были в командировках сотрудники. Вычисляемый столбец назвать Количество.

SELECT city, COUNT(city) AS Количество
FROM trip
GROUP BY city
ORDER BY Количество DESC
LIMIT 2;

5. Вывести информацию о командировках во все города кроме Москвы и Санкт-Петербурга (фамилии и инициалы сотрудников, город,
длительность командировки в днях, при этом первый и последний день относится к периоду командировки). 
Последний столбец назвать Длительность. Информацию вывести в упорядоченном по убыванию длительности поездки, а потом по убыванию
названий городов (в обратном алфавитном порядке).

SELECT name, city, DATEDIFF(date_last, date_first)+1 AS Длительность
FROM trip
WHERE city <> 'Москва' AND city <> 'Санкт-Петербург'
ORDER BY 3 DESC, 2 DESC;

6. Вывести информацию о командировках сотрудника(ов), которые были самыми короткими по времени. В результат включить столбцы name,
city, date_first, date_last.

SELECT name, city, date_first, date_last
FROM trip
WHERE DATEDIFF(date_last, date_first) = (
     SELECT MIN(DATEDIFF(date_last, date_first))
     FROM trip
    );

7. Вывести информацию о командировках, начало и конец которых относятся к одному месяцу (год может быть любой). В результат включить столбцы name,
 city, date_first, date_last. Строки отсортировать сначала  в алфавитном порядке по названию города, а затем по фамилии сотрудника.

SELECT name, city, date_first, date_last
FROM trip
WHERE MONTH(date_first) = MONTH(date_last)
ORDER BY city, name;

8. Вывести название месяца и количество командировок для каждого месяца. Считаем, что командировка относится к некоторому месяцу,
 если она началась в этом месяце. Информацию вывести сначала в отсортированном по убыванию количества, а потом в алфавитном порядке по названию месяца виде. 
 Название столбцов – Месяц и Количество.

SELECT MONTHNAME(date_first) AS Месяц, COUNT(MONTHNAME(date_first)) AS Количество
FROM trip
GROUP BY Месяц
ORDER BY Количество DESC, Месяц;

9. Вывести сумму суточных (произведение количества дней командировки и размера суточных) для командировок, первый день которых пришелся на февраль 
или март 2020 года. Значение суточных для каждой командировки занесено в столбец per_diem. Вывести фамилию и инициалы сотрудника, город, первый день
командировки и сумму суточных. Последний столбец назвать Сумма. Информацию отсортировать сначала  в алфавитном порядке по фамилиям сотрудников,
а затем по убыванию суммы суточных.

SELECT name, city, date_first, 
    per_diem * (DATEDIFF(date_last, date_first) + 1) AS Сумма
FROM trip
WHERE MONTHNAME(date_first) IN ('February', 'March')
ORDER BY 1, 4 DESC;

10. Вывести фамилию с инициалами и общую сумму суточных, полученных за все командировки для тех сотрудников, которые были в командировках
больше чем 3 раза, в отсортированном по убыванию сумм суточных виде. Последний столбец назвать Сумма.

SELECT name, SUM(per_diem * (DATEDIFF(date_last, date_first) + 1)) AS Сумма
FROM trip
GROUP BY name
HAVING COUNT(name) > 3
ORDER BY 2 DESC;

1.7 Таблица "Нарушения ПДД", запросы корректировки

1. Создать таблицу fine следующей структуры:

CREATE TABLE fine (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR (30), 
    number_plate VARCHAR (6), 
    violation VARCHAR (60),
    sum_fine DECIMAL (8,2),
    date_violation DATE,
    date_payment DATE
);

2. В таблицу fine первые 5 строк уже занесены. Добавить в таблицу записи с ключевыми значениями 6, 7, 8.

INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', Null, '2020-02-14', Null),
    ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', Null, '2020-02-23', Null),
    ('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', Null, '2020-03-03', Null);
SELECT * FROM fine         

3. Занести в таблицу fine суммы штрафов, которые должен оплатить водитель, в соответствии с данными из таблицы traffic_violation. 
При этом суммы заносить только в пустые поля столбца  sum_fine.

UPDATE fine f, traffic_violation tv
SET f.sum_fine = tv.sum_fine
WHERE f.sum_fine IS Null AND f.violation = tv.violation;
SELECT * from fine f

4. Вывести фамилию, номер машины и нарушение только для тех водителей, которые на одной машине нарушили одно и то же правило два и более раз.
 При этом учитывать все нарушения, независимо от того оплачены они или нет. Информацию отсортировать в алфавитном порядке, сначала по фамилии водителя, 
 потом по номеру машины и, наконец, по нарушению.

SELECT name, number_plate, violation 
FROM fine 
GROUP BY name, number_plate, violation
HAVING COUNT(*) >= 2
ORDER BY name, number_plate, violation;

5. В таблице fine увеличить в два раза сумму неоплаченных штрафов для отобранных на предыдущем шаге записей. 

UPDATE fine, 
    (
     SELECT name, number_plate, violation
     FROM fine
     GROUP BY name, number_plate, violation
     HAVING COUNT(*) >= 2
    ) query_in
SET sum_fine = sum_fine * 2
WHERE
    date_payment IS Null AND
    fine.name = query_in.name AND
    fine.number_plate = query_in.number_plate AND
    fine.violation = query_in.violation;

SELECT * FROM fine

6. Необходимо в таблицу fine занести дату оплаты соответствующего штрафа из таблицы payment; уменьшить начисленный штраф в таблице fine в два раза
(только для тех штрафов, информация о которых занесена в таблицу payment), если оплата произведена не позднее 20 дней со дня нарушения.

UPDATE 
    fine f, payment p
SET
    f.date_payment = p.date_payment,
    f.sum_fine = IF(
                    DATEDIFF(p.date_payment, p.date_violation) <= 20, f.sum_fine/2, f.sum_fine
                    )

WHERE f.name = p.name
    AND p.number_plate = f.number_plate
    AND f.violation = p.violation
    AND f.date_payment IS NULL;

SELECT * FROM fine;

7. Создать новую таблицу back_payment, куда внести информацию о неоплаченных штрафах (Фамилию и инициалы водителя, номер машины, нарушение,
сумму штрафа и дату нарушения) из таблицы fine.

CREATE TABLE back_payment AS
SELECT name, number_plate, violation, sum_fine, date_violation 
FROM fine
WHERE date_payment is Null;

SELECT * FROM back_payment;

8. Удалить из таблицы fine информацию о нарушениях, совершенных раньше 1 февраля 2020 года. 

DELETE FROM fine
WHERE date_violation < '2020-02-01';
SELECT * FROM fine;



##############################################################
2. Запросы SQL к связанным таблицам
##############################################################


2.1 Связи между таблицами

1. Создать таблицу author следующей структуры:
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
    );

2. Заполнить таблицу author.
INSERT INTO author (name_author)
VALUES ('Булгаков М.А.'), ('Достоевский Ф.М.'), ('Есенин С.А.'), ('Пастернак Б.Л.');
SELECT * FROM author;

3. Перепишите запрос на создание таблицы book , чтобы ее структура соответствовала структуре, показанной на логической схеме
(таблица genre уже создана, порядок следования столбцов - как на логической схеме в таблице book, genre_id  - внешний ключ).
Для genre_id ограничение о недопустимости пустых значений не задавать. В качестве главной таблицы для описания поля  genre_id 
использовать таблицу genre следующей структуры:

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL,
    genre_id INT, 
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id)  REFERENCES author (author_id),
    FOREIGN KEY (genre_id)  REFERENCES genre (genre_id)
);

4. Создать таблицу book той же структуры, что и на предыдущем шаге. Будем считать, что при удалении автора из таблицы author, должны удаляться
все записи о книгах из таблицы book, написанные этим автором. А при удалении жанра из таблицы genre для соответствующей записи book установить
значение Null в столбце genre_id. 

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL,
    genre_id INT, 
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id)  REFERENCES author (author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id)  REFERENCES genre (genre_id) ON DELETE SET NULL
);

5. Добавьте три последние записи (с ключевыми значениями 6, 7, 8) в таблицу book, первые 5 записей уже добавлены:

INSERT INTO book (title, author_id, genre_id, price, amount) 
VALUES 
    ('Стихотворения и поэмы', 3, 2, 650.00, 15),
    ('Черный человек', 3, 2, 570.20, 6),
    ('Лирика', 4, 2, 518.99, 2);

2.2 Запросы на выборку, соединение таблиц

1. Вывести название, жанр и цену тех книг, количество которых больше 8, в отсортированном по убыванию цены виде.

SELECT title, name_genre, price
FROM
    book JOIN genre
    ON book.genre_id = genre.genre_id
    WHERE amount > 8
    ORDER BY price DESC;

2. Вывести все жанры, которые не представлены в книгах на складе.

SELECT name_genre 
FROM genre LEFT JOIN book
     ON genre.genre_id = book.genre_id
     WHERE title is NULL;

3. Есть список городов, хранящийся в таблице city. Необходимо в каждом городе провести выставку книг каждого автора в течение 2020 года. 
Дату проведения выставки выбрать случайным образом. Создать запрос, который выведет город, автора и дату проведения выставки. 
Последний столбец назвать Дата. Информацию вывести, отсортировав сначала в алфавитном порядке по названиям городов, а потом по убыванию дат
проведения выставок.

SELECT
    name_city,
    name_author,
    DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 365) DAY) AS Дата
FROM city, author
ORDER BY name_city, Дата DESC;

4.  Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, включающему слово «роман» в отсортированном по названиям книг виде.

SELECT name_genre, title, name_author
FROM
    genre
    INNER JOIN book ON genre.genre_id = book.genre_id
    INNER JOIN author ON author.author_id = book.author_id
WHERE name_genre = 'Роман'
ORDER BY title;

5. Посчитать количество экземпляров книг каждого автора из таблицы author. 
Вывести тех авторов, количество книг которых меньше 10, в отсортированном по возрастанию количества виде. 
Последний столбец назвать Количество.

SELECT name_author, SUM(amount) AS Количество
FROM
    author
    LEFT JOIN book ON author.author_id = book.author_id
GROUP BY name_author
HAVING SUM(amount) < 10 OR SUM(amount) IS NULL
ORDER BY Количество; 

6. Вывести в алфавитном порядке всех авторов, которые пишут только в одном жанре. Поскольку у нас в таблицах так занесены данные,
что у каждого автора книги только в одном жанре,  для этого запроса внесем изменения в таблицу book. Пусть у нас  книга Есенина «Черный человек» 
относится к жанру «Роман», а книга Булгакова «Белая гвардия» к «Приключениям» (эти изменения в таблицы уже внесены).

SELECT name_author 
FROM
    author
    INNER JOIN book ON author.author_id = book.author_id
GROUP BY name_author
HAVING COUNT(DISTINCT genre_id) = 1;


7. Вывести информацию о книгах (название книги, фамилию и инициалы автора, название жанра, цену и количество экземпляров книги), 
написанных в самых популярных жанрах, в отсортированном в алфавитном порядке по названию книг виде. 
Самым популярным считать жанр, общее количество экземпляров книг которого на складе максимально.

SELECT title, name_author, name_genre, price, amount
FROM
    author 
    INNER JOIN book ON author.author_id = book.author_id
    INNER JOIN genre ON  book.genre_id = genre.genre_id
GROUP BY title, name_author, name_genre, price, amount, genre.genre_id
HAVING genre.genre_id IN
    (
    SELECT query_in_1.genre_id
    FROM 
        (
        SELECT genre_id, SUM(amount) AS sum_amount
        FROM book
        GROUP BY genre_id 
        ) query_in_1
    INNER JOIN
    (
      SELECT genre_id, SUM(amount) AS sum_amount
      FROM book
      GROUP BY genre_id
      ORDER BY sum_amount DESC
      LIMIT 1
     ) query_in_2
     ON query_in_1.sum_amount= query_in_2.sum_amount
    )
ORDER BY title;

 
8. Если в таблицах supply  и book есть одинаковые книги, которые имеют равную цену, вывести их название и автора, а также посчитать
общее количество экземпляров книг в таблицах supply и book, столбцы назвать Название, Автор и Количество.

SELECT s.title Название, s.author Автор, s.amount + b.amount Количество
FROM
    supply s
    INNER JOIN book b USING(title, price);

2.3 Запросы корректировки, соединение таблиц

1. Для книг, которые уже есть на складе (в таблице book), но по другой цене, чем в поставке (supply),  необходимо в таблице book увеличить количество
на значение, указанное в поставке,  и пересчитать цену. А в таблице  supply обнулить количество этих книг. 

UPDATE book
     INNER JOIN author ON author.author_id = book.author_id
     INNER JOIN supply ON book.title = supply.title 
                          AND supply.author = author.name_author
                          
SET book.amount = book.amount + supply.amount,
    book.price = (book.price*book.amount + supply.price*supply.amount) / (book.amount + supply.amount),
    supply.amount = 0   
WHERE book.price <> supply.price;

SELECT * FROM book;
SELECT * FROM supply;


UPDATE book b
INNER JOIN author a ON a.author_id = b.author_id
INNER JOIN supply s ON b.title = s.title
                    AND a.name_author = s.author
                    AND b.price <> s.price
SET b.amount = b.amount + s.amount,
s.amount = 0,
b.price = (b.amount * b.price + s.amount * s.price) / (b.amount + s.amount);

2. Включить новых авторов в таблицу author с помощью запроса на добавление, а затем вывести все данные из таблицы author. 
Новыми считаются авторы, которые есть в таблице supply, но нет в таблице author.

INSERT INTO author (name_author)
SELECT supply.author
FROM 
    author 
    RIGHT JOIN supply ON author.name_author = supply.author
WHERE name_author IS Null;

SELECT * FROM author

3. Добавить новые книги из таблицы supply в таблицу book на основе сформированного выше запроса. Затем вывести для просмотра таблицу book.

INSERT INTO book(title, author_id, price, amount)
SELECT title, author_id, price, amount
FROM 
    author 
    INNER JOIN supply ON author.name_author = supply.author
WHERE amount <> 0;

SELECT * FROM book;

4. Занести для книги «Стихотворения и поэмы» Лермонтова жанр «Поэзия», а для книги «Остров сокровищ» Стивенсона - «Приключения». 
(Использовать два запроса).

UPDATE book
SET genre_id = 
      (
       SELECT genre_id 
       FROM genre 
       WHERE name_genre = 'Поэзия'
      )
WHERE title = 'Стихотворения и поэмы'; 

UPDATE book                
SET genre_id = 
      (
       SELECT genre_id 
       FROM genre 
       WHERE name_genre = 'Приключения'
      )
WHERE title = 'Остров сокровищ';       

SELECT * FROM book;

5. Удалить всех авторов и все их книги, общее количество книг которых меньше 20.

DELETE FROM author
WHERE author_id IN (
    SELECT author_id
    FROM book
    GROUP BY author_id
    HAVING SUM(amount) < 20
    );
    
SELECT * FROM author;
SELECT * FROM book;

6. Удалить все жанры, к которым относится меньше 4-х книг. В таблице book для этих жанров установить значение Null.

DELETE FROM genre
WHERE genre_id IN (
    SELECT genre_id
    FROM book
    GROUP BY genre_id
    HAVING COUNT(amount) < 4);

SELECT * FROM genre;
SELECT * FROM book;

7. Удалить всех авторов, которые пишут в жанре "Поэзия". Из таблицы book удалить все книги этих авторов. 
В запросе для отбора авторов использовать полное название жанра, а не его id.

DELETE FROM author
USING 
    author 
    INNER JOIN book ON author.author_id = book.author_id
    INNER JOIN genre ON genre.genre_id = book.genre_id
WHERE genre.name_genre = 'Поэзия';

SELECT * FROM author;
SELECT * FROM book;

2.4 База данных «Интернет-магазин книг», запросы на выборку

1. Вывести все заказы Баранова Павла (id заказа, какие книги, по какой цене и в каком количестве он заказал) в отсортированном по номеру заказа
и названиям книг виде.

SELECT buy.buy_id, title, price, buy_book.amount
FROM 
    client 
    INNER JOIN buy ON client.client_id = buy.client_id
    INNER JOIN buy_book ON buy_book.buy_id = buy.buy_id
    INNER JOIN book ON buy_book.book_id=book.book_id
WHERE name_client = 'Баранов Павел'
ORDER BY buy_id, title;

2. Посчитать, сколько раз была заказана каждая книга, для книги вывести ее автора (нужно посчитать, в каком количестве заказов фигурирует каждая книга). 
Вывести фамилию и инициалы автора, название книги, последний столбец назвать Количество. Результат отсортировать сначала  по фамилиям авторов, 
а потом по названиям книг.

SELECT name_author, title, COUNT(buy_book.book_id) AS Количество
FROM book
     INNER JOIN author USING (author_id)
     LEFT JOIN buy_book USING(book_id)
GROUP BY name_author, title
ORDER BY name_author, title;

3. Вывести города, в которых живут клиенты, оформлявшие заказы в интернет-магазине. Указать количество заказов в каждый город, этот столбец назвать 
Количество. Информацию вывести по убыванию количества заказов, а затем в алфавитном порядке по названию городов.

SELECT name_city, COUNT(name_city) AS Количество
FROM city
     INNER JOIN client USING (city_id)
     INNER JOIN buy USING (client_id)
GROUP BY name_city
ORDER BY name_city;

4. Вывести номера всех оплаченных заказов и даты, когда они были оплачены.

SELECT buy_id, date_step_end
FROM buy_step
WHERE step_id = 1 AND date_step_end is not Null;

5. Вывести информацию о каждом заказе: его номер, кто его сформировал (фамилия пользователя) и его стоимость
(сумма произведений количества заказанных книг и их цены), в отсортированном по номеру заказа виде. Последний столбец назвать Стоимость.

SELECT buy_id, name_client, SUM(buy_book.amount * book.price) AS Стоимость
FROM client
    INNER JOIN buy USING(client_id)
    INNER JOIN buy_book USING(buy_id)
    INNER JOIN book USING(book_id)
GROUP BY buy_id, name_client
ORDER BY buy_id;

6. Вывести номера заказов (buy_id) и названия этапов,  на которых они в данный момент находятся. Если заказ доставлен –  информацию о нем не выводить. 
Информацию отсортировать по возрастанию buy_id.

SELECT buy_id, name_step
FROM step
    INNER JOIN buy_step USING (step_id)
WHERE date_step_beg is not Null AND date_step_end is Null
ORDER BY buy_id;

7. В таблице city для каждого города указано количество дней, за которые заказ может быть доставлен в этот город
(рассматривается только этап Транспортировка). Для тех заказов, которые прошли этап транспортировки, вывести количество дней за которое заказ 
реально доставлен в город. А также, если заказ доставлен с опозданием, указать количество дней задержки, в противном случае вывести 0. В результат
включить номер заказа (buy_id), а также вычисляемые столбцы Количество_дней и Опоздание. Информацию вывести в отсортированном по номеру заказа виде.

SELECT buy_id, 
       DATEDIFF(date_step_end, date_step_beg) AS Количество_дней,
       IF(DATEDIFF(date_step_end, date_step_beg) > days_delivery, DATEDIFF(date_step_end, date_step_beg) - days_delivery, 0) AS Опоздание
FROM city 
    INNER JOIN client USING(city_id)
    INNER JOIN buy USING(client_id)
    INNER JOIN buy_step USING(buy_id)
    INNER JOIN step USING(step_id)
WHERE step_id = 3  AND date_step_end is not Null


SELECT
    buy_id,
    DATEDIFF(date_step_end, date_step_beg) AS Количество_дней,
    GREATEST(DATEDIFF(date_step_end, date_step_beg) - days_delivery, 0) AS Опоздание
FROM
    buy
    INNER JOIN buy_step USING(buy_id)
    INNER JOIN step     USING(step_id)
    INNER JOIN client   USING(client_id)
    INNER JOIN city     USING(city_id)
WHERE
    name_step = 'Транспортировка' AND date_step_end IS NOT NULL
ORDER BY buy_id;

8. Выбрать всех клиентов, которые заказывали книги Достоевского, информацию вывести в отсортированном по алфавиту виде.

SELECT name_client
FROM author 
    INNER JOIN book USING(author_id)
    INNER JOIN buy_book USING(book_id)
    INNER JOIN buy USING(buy_id)
    INNER JOIN client USING(client_id)
WHERE name_author="Достоевский Ф.М."

9. Вывести жанр (или жанры), в котором было заказано больше всего экземпляров книг, указать это количество. 
Последний столбец назвать Количество.

SELECT name_genre, SUM(buy_book.amount) AS Количество
FROM genre 
    INNER JOIN book USING (genre_id) 
    INNER JOIN buy_book USING (book_id)
GROUP BY name_genre
HAVING SUM(buy_book.amount) =  
    (
    SELECT MAX(sum_amount) AS max_sum_amount 
    FROM
        (
        SELECT SUM(buy_book.amount) AS sum_amount 
        FROM book 
        INNER JOIN buy_book USING (book_id)
        GROUP BY genre_id
        )query_in 
    );

10. Сравнить ежемесячную выручку от продажи книг за текущий и предыдущий годы. Для этого вывести год, месяц, сумму выручки в отсортированном
сначала по возрастанию месяцев, затем по возрастанию лет виде. Название столбцов: Год, Месяц, Сумма.

SELECT YEAR(date_payment) AS Год, MONTHNAME(date_payment) AS Месяц, SUM(price * amount) AS Сумма
FROM
    buy_archive
GROUP BY YEAR(date_payment), MONTHNAME(date_payment)
UNION ALL
SELECT YEAR(date_step_end), MONTHNAME(date_step_end), SUM(buy_book.amount * price) AS Сумма
FROM 
    book 
    INNER JOIN buy_book USING(book_id)
    INNER JOIN buy USING(buy_id) 
    INNER JOIN buy_step USING(buy_id)
    INNER JOIN step USING(step_id)  
WHERE date_step_end IS NOT Null and name_step = "Оплата"
GROUP BY YEAR(date_step_end), MONTHNAME(date_step_end)
ORDER BY 2, 1;

11. Для каждой отдельной книги необходимо вывести информацию о количестве проданных экземпляров и их стоимости за текущий и предыдущий год. 
Вычисляемые столбцы назвать Количество и Сумма. Информацию отсортировать по убыванию стоимости.

SELECT title, SUM(Количество) AS Количество, SUM(Сумма) AS Сумма
FROM
    (
SELECT title, SUM(buy_book.amount) AS Количество, SUM(buy_book.amount * price) AS Сумма
FROM book 
    INNER JOIN buy_book USING(book_id)
    INNER JOIN buy USING(buy_id) 
    INNER JOIN buy_step USING(buy_id)
    INNER JOIN step USING(step_id)  
WHERE date_step_end IS NOT Null and name_step = "Оплата"
GROUP BY title
UNION ALL
SELECT title, SUM(buy_archive.amount) AS Количество, SUM(buy_archive.price * buy_archive.amount) AS Сумма
FROM buy_archive
    INNER JOIN book USING(book_id)
GROUP BY title
    )query_in
    
GROUP BY title
ORDER BY 3 DESC;

2.5 База данных «Интернет-магазин книг», запросы корректировки

1.  Включить нового человека в таблицу с клиентами. Его имя Попов Илья, его email popov@test, проживает он в Москве.

INSERT INTO client (name_client, city_id, email)
SELECT 'Попов Илья', city_id, 'popov@test'
FROM city
WHERE name_city = 'Москва';

SELECT * FROM client

2. Создать новый заказ для Попова Ильи. Его комментарий для заказа: «Связаться со мной по вопросу доставки».

INSERT INTO buy (buy_description, client_id)
SELECT 'Связаться со мной по вопросу доставки', client_id
FROM client
WHERE name_client = 'Попов Илья';

SELECT * FROM buy

3. В таблицу buy_book добавить заказ с номером 5. Этот заказ должен содержать книгу Пастернака «Лирика» в количестве двух экземпляров
 и книгу Булгакова «Белая гвардия» в одном экземпляре.

INSERT INTO buy_book (buy_id, book_id, amount)
SELECT '5', (SELECT book_id FROM book WHERE title ='Лирика' AND author_id = 
             (SELECT author_id 
             FROM author 
             WHERE name_author LIKE 'Пас%')), '2';

INSERT INTO buy_book(buy_id, book_id, amount)
SELECT '5', (SELECT book_id
             FROM book
             WHERE title = 'Белая гвардия' AND author_id = 
             (SELECT author_id 
              FROM author 
              WHERE name_author LIKE 'Бул%')), '1';

SELECT * FROM buy_book;

3. Количество тех книг на складе, которые были включены в заказ с номером 5, уменьшить на то количество, которое в заказе с номером 5  указано.

UPDATE book
INNER JOIN buy_book USING(book_id)
SET book.amount = book.amount - buy_book.amount
WHERE buy_id = 5;

SELECT * FROM book;

4. Создать счет (таблицу buy_pay) на оплату заказа с номером 5, в который включить название книг, их автора, цену, количество заказанных книг 
и стоимость. Последний столбец назвать Стоимость. Информацию в таблицу занести в отсортированном по названиям книг виде.

CREATE TABLE buy_pay AS
SELECT title, name_author, price, buy_book.amount, buy_book.amount * price AS Стоимость
FROM author 
    INNER JOIN book USING(author_id)
    INNER JOIN buy_book USING(book_id)
WHERE buy_id = 5
ORDER BY title;

SELECT * FROM buy_pay;

5. Создать общий счет (таблицу buy_pay) на оплату заказа с номером 5. Куда включить номер заказа, количество книг в заказе
(название столбца Количество) и его общую стоимость (название столбца Итого). Для решения используйте ОДИН запрос.

CREATE TABLE buy_pay AS
SELECT
    buy_id,
    SUM(buy_book.amount) AS Количество,
    SUM(buy_book.amount * price) AS Итого
FROM book 
    INNER JOIN buy_book USING(book_id)
WHERE buy_id = 5;

SELECT * FROM buy_pay


6. В таблицу buy_step для заказа с номером 5 включить все этапы из таблицы step, которые должен пройти этот заказ.
В столбцы date_step_beg и date_step_end всех записей занести Null.

INSERT INTO buy_step (buy_id, step_id, date_step_beg, date_step_end)
SELECT buy_id, step_id, NULL, NULL
FROM buy, step
WHERE buy.buy_id = 5
GROUP BY buy_id, step_id;

SELECT * FROM buy_step;

7. В таблицу buy_step занести дату 12.04.2020 выставления счета на оплату заказа с номером 5.

UPDATE buy_step 
SET date_step_beg = '2020-04-12'
WHERE buy_id = 5 AND step_id = 1;

UPDATE buy_step
SET date_step_beg = '2020-04-12'
WHERE buy_id = 5 AND step_id = (SELECT step_id FROM step WHERE name_step = 'Оплата');


8. Завершить этап «Оплата» для заказа с номером 5, вставив в столбец date_step_end дату 13.04.2020, и начать следующий этап («Упаковка»),
задав в столбце date_step_beg для этого этапа ту же дату.

Реализовать два запроса для завершения этапа и начала следующего. Они должны быть записаны в общем виде, чтобы его можно было применять
для любых этапов, изменив только текущий этап. Для примера пусть это будет этап «Оплата».

UPDATE buy_step
INNER JOIN step USING(step_id)
SET date_step_end = '2020-04-13'
WHERE buy_id = 5 AND name_step = 'Оплата';

UPDATE buy_step
INNER JOIN step USING(step_id)
SET date_step_beg = '2020-04-13'
WHERE buy_id = 5 AND step_id = 2;

SELECT * FROM buy_step
WHERE buy_id = 5;


##############################################################
3. Базы данных и SQL запросы
##############################################################

3.1 База данных «Тестирование», запросы на выборку

1. Вывести студентов, которые сдавали дисциплину «Основы баз данных», указать дату попытки и результат. Информацию вывести по убыванию результатов
тестирования.

SELECT name_student, date_attempt, result
FROM
    subject
    INNER JOIN attempt USING(subject_id)
    INNER JOIN student USING(student_id)
WHERE name_subject = 'Основы баз данных'
ORDER BY result DESC;

2. Вывести, сколько попыток сделали студенты по каждой дисциплине, а также средний результат попыток, который округлить до 2 знаков после запятой. 
Под результатом попытки понимается процент правильных ответов на вопросы теста, который занесен в столбец result. 
В результат включить название дисциплины, а также вычисляемые столбцы Количество и Среднее. Информацию вывести по убыванию средних результатов.

SELECT
    name_subject,
    COUNT(attempt_id) AS Количество,
    ROUND(AVG(result), 2) AS Среднее
FROM
    subject
    LEFT JOIN attempt USING(subject_id)
GROUP BY name_subject
ORDER BY 3 DESC;

3. Вывести студентов (различных студентов), имеющих максимальные результаты попыток. Информацию отсортировать в алфавитном порядке по фамилии студента.

SELECT name_student, result
FROM 
    student
    INNER JOIN attempt USING (student_id)
WHERE result = (SELECT MAX(result) FROM attempt)
ORDER BY name_student;

4. Если студент совершал несколько попыток по одной и той же дисциплине, то вывести разницу в днях между первой и последней попыткой. 
В результат включить фамилию и имя студента, название дисциплины и вычисляемый столбец Интервал. Информацию вывести по возрастанию разницы.
Студентов, сделавших одну попытку по дисциплине, не учитывать. 

SELECT
    name_student,
    name_subject,
    DATEDIFF(MAX(date_attempt), MIN(date_attempt)) AS Интервал
FROM
    student
    INNER JOIN attempt USING(student_id)
    INNER JOIN subject USING(subject_id) 
GROUP BY name_student, name_subject
HAVING COUNT(attempt_id) > 1
ORDER BY Интервал;

5. Студенты могут тестироваться по одной или нескольким дисциплинам (не обязательно по всем). Вывести дисциплину и количество уникальных студентов
(столбец назвать Количество), которые по ней проходили тестирование . Информацию отсортировать сначала по убыванию количества, а потом по названию
дисциплины. В результат включить и дисциплины, тестирование по которым студенты еще не проходили, в этом случае указать количество студентов 0.

SELECT
    name_subject,
    COUNT(DISTINCT student_id) AS Количество
FROM 
    attempt
    RIGHT JOIN subject USING(subject_id)
GROUP BY name_subject
ORDER BY 2 DESC, 1;

6. Случайным образом отберите 3 вопроса по дисциплине «Основы баз данных». В результат включите столбцы question_id и name_question.

SELECT question_id, name_question
FROM
    question
    INNER JOIN subject USING(subject_id)
WHERE name_subject = 'Основы баз данных'
ORDER BY RAND()
LIMIT 3;

7. Вывести вопросы, которые были включены в тест для Семенова Ивана по дисциплине «Основы SQL» 2020-05-17 (значение attempt_id для этой попытки равно 7).
Указать, какой ответ дал студент и правильный он или нет (вывести Верно или Неверно). В результат включить вопрос, ответ и вычисляемый столбец  Результат.

SELECT
    name_question,
    name_answer,
    IF(is_correct, 'Верно','Неверно') AS Результат
FROM
    answer
    INNER JOIN testing USING(answer_id)
    INNER JOIN question ON question.question_id = testing.question_id
WHERE attempt_id = 7;

8. Посчитать результаты тестирования. Результат попытки вычислить как количество правильных ответов, деленное на 3 (количество вопросов в каждой попытке)
и умноженное на 100. Результат округлить до двух знаков после запятой. Вывести фамилию студента, название предмета, дату и результат.
Последний столбец назвать Результат. Информацию отсортировать сначала по фамилии студента, потом по убыванию даты попытки.

SELECT
    name_student,
    name_subject,
    date_attempt,
    ROUND((SUM(is_correct) / 3) * 100, 2) AS Результат
FROM
    student
    INNER JOIN attempt USING(student_id)
    INNER JOIN testing USING(attempt_id)
    INNER JOIN answer USING(answer_id)
    INNER JOIN subject ON subject.subject_id = attempt.subject_id
GROUP BY name_student, name_subject, date_attempt
ORDER BY 1, 3 DESC;

9. Для каждого вопроса вывести процент успешных решений, то есть отношение количества верных ответов к общему количеству ответов, значение округлить
до 2-х знаков после запятой. Также вывести название предмета, к которому относится вопрос, и общее количество ответов на этот вопрос. 
В результат включить название дисциплины, вопросы по ней (столбец назвать Вопрос), а также два вычисляемых столбца Всего_ответов и Успешность.
Информацию отсортировать сначала по названию дисциплины, потом по убыванию успешности, а потом по тексту вопроса в алфавитном порядке.

Поскольку тексты вопросов могут быть длинными, обрезать их 30 символов и добавить многоточие "...".

SELECT
    name_subject,
    CONCAT(LEFT(name_question, 30), '...') AS Вопрос,
    COUNT(is_correct) AS Всего_ответов,
    ROUND(((SUM(is_correct) / COUNT(attempt_id)) * 100), 2) AS Успешность
FROM subject
    INNER JOIN question  USING(subject_id)
    INNER JOIN testing  USING(question_id)
    INNER JOIN answer  USING(answer_id)
GROUP BY name_subject, name_question
ORDER BY 1, 4 DESC, 2;

3.2 База данных «Тестирование», запросы корректировки

1. В таблицу attempt включить новую попытку для студента Баранова Павла по дисциплине «Основы баз данных». Установить текущую дату в качестве даты
выполнения попытки.

INSERT INTO attempt (student_id, subject_id, date_attempt, result)
SELECT student_id, subject_id, NOW(), Null
FROM
    subject
    INNER JOIN attempt USING(subject_id)    
    INNER JOIN student USING(student_id)
WHERE name_student = 'Баранов Павел' AND name_subject = 'Основы баз данных';

SELECT * FROM attempt;

2. Случайным образом выбрать три вопроса (запрос) по дисциплине, тестирование по которой собирается проходить студент, занесенный в таблицу attempt 
последним, и добавить их в таблицу testing. id последней попытки получить как максимальное значение id из таблицы attempt.

INSERT INTO testing (attempt_id, question_id, answer_id)
SELECT attempt_id, question_id, Null
    FROM question
    INNER JOIN attempt USING(subject_id)
WHERE attempt_id = (SELECT MAX(attempt_id) FROM attempt)
ORDER BY RAND()
LIMIT 3;

SELECT * FROM testing;

3. Студент прошел тестирование (то есть все его ответы занесены в таблицу testing), далее необходимо вычислить результат(запрос) и занести его в таблицу
attempt для соответствующей попытки. Результат попытки вычислить как количество правильных ответов, деленное на 3 (количество вопросов в каждой попытке)
и умноженное на 100. Результат округлить до целого.

Будем считать, что мы знаем id попытки,  для которой вычисляется результат, в нашем случае это 8. 

UPDATE attempt 
SET result = (
    SELECT (SUM(is_correct) / 3) * 100 AS result
    FROM answer INNER JOIN testing USING(answer_id)
    WHERE attempt_id = 8
)
WHERE attempt_id = 8;

SELECT * FROM attempt;


UPDATE attempt a
SET result = (
    SELECT round(SUM(is_correct) / 3 * 100)
    FROM testing JOIN answer USING (answer_id)
    WHERE attempt_id = a.attempt_id
)
WHERE a.attempt_id = 8;

SELECT * FROM attempt;

4. Удалить из таблицы attempt все попытки, выполненные раньше 1 мая 2020 года. Также удалить и все соответствующие этим попыткам вопросы
из таблицы testing.

DELETE FROM attempt
WHERE date_attempt < '2020-05-01';

SELECT * FROM attempt;
SELECT * FROM testing;

3.3 База данных «Абитуриент», запросы на выборку

1. Вывести абитуриентов, которые хотят поступать на образовательную программу «Мехатроника и робототехника» в отсортированном по фамилиям виде.

SELECT name_enrollee
FROM
    enrollee
    INNER JOIN program_enrollee USING(enrollee_id)
    INNER JOIN program USING(program_id)
WHERE name_program = 'Мехатроника и робототехника'
ORDER BY name_enrollee;


2. Вывести образовательные программы, на которые для поступления необходим предмет «Информатика». Программы отсортировать в обратном алфавитном порядке.

SELECT name_program
FROM
    program
    INNER JOIN program_subject USING(program_id)
    INNER JOIN subject USING(subject_id)
WHERE name_subject = 'Информатика';

3. Выведите количество абитуриентов, сдавших ЕГЭ по каждому предмету, максимальное, минимальное и среднее значение баллов по предмету ЕГЭ. 
Вычисляемые столбцы назвать Количество, Максимум, Минимум, Среднее. Информацию отсортировать по названию предмета в алфавитном порядке, 
среднее значение округлить до одного знака после запятой.

SELECT
    name_subject,
    COUNT(enrollee_id) AS Количество,
    ROUND(MAX(result), 1) AS Максимум,
    ROUND(MIN(result), 1) AS Минимум,
    ROUND(AVG(result), 1) AS Среднее
FROM subject
    INNER JOIN enrollee_subject USING(subject_id)
GROUP BY name_subject
ORDER BY name_subject;

4. Вывести образовательные программы, для которых минимальный балл ЕГЭ по каждому предмету больше или равен 40 баллам. Программы вывести
в отсортированном по алфавиту виде.

SELECT name_program
FROM
    program
    INNER JOIN program_subject USING(program_id)
GROUP BY name_program
HAVING MIN(min_result) >= 40
ORDER BY name_program;

5. Вывести образовательные программы, которые имеют самый большой план набора, вместе с этой величиной. 

SELECT name_program, plan
FROM program
WHERE plan = (SELECT MAX(plan) FROM program)
GROUP BY name_program, plan;

6. Посчитать, сколько дополнительных баллов получит каждый абитуриент. Столбец с дополнительными баллами назвать Бонус. Информацию вывести
в отсортированном по фамилиям виде.

SELECT name_enrollee, IF(SUM(bonus) IS Null, 0, SUM(bonus)) AS Бонус
FROM
    enrollee
    LEFT JOIN enrollee_achievement USING(enrollee_id)
    LEFT JOIN achievement USING(achievement_id)
GROUP BY name_enrollee
ORDER BY name_enrollee;

7. Выведите сколько человек подало заявление на каждую образовательную программу и конкурс на нее 
(число поданных заявлений деленное на количество мест по плану), округленный до 2-х знаков после запятой. В запросе вывести название факультета,
к которому относится образовательная программа, название образовательной программы, план набора абитуриентов на образовательную программу (plan),
количество поданных заявлений (Количество) и Конкурс. Информацию отсортировать в порядке убывания конкурса.

SELECT
    name_department,
    name_program, plan,
    COUNT(enrollee_id) AS Количество,
    ROUND((COUNT(enrollee_id) / plan), 2) AS Конкурс
FROM
    department
    INNER JOIN program USING(department_id)
    INNER JOIN program_enrollee USING(program_id)
GROUP BY name_department, name_program, plan
ORDER BY 5 DESC;

8. Вывести образовательные программы, на которые для поступления необходимы предмет «Информатика» и «Математика» в отсортированном по
названию программ виде.

SELECT name_program 
FROM
    program
    INNER JOIN program_subject USING(program_id)
    INNER JOIN subject USING(subject_id)
WHERE name_subject IN ('информатика', 'математика')
GROUP BY name_program
HAVING COUNT(name_subject) = 2
ORDER BY name_program;

9. Посчитать количество баллов каждого абитуриента на каждую образовательную программу, на которую он подал заявление, по результатам ЕГЭ. 
В результат включить название образовательной программы, фамилию и имя абитуриента, а также столбец с суммой баллов, который назвать itog. 
Информацию вывести в отсортированном сначала по образовательной программе, а потом по убыванию суммы баллов виде.

SELECT
    name_program,
    name_enrollee,
    SUM(result) AS itog
FROM
    enrollee
    INNER JOIN program_enrollee USING(enrollee_id)
    INNER JOIN program USING(program_id)
    INNER JOIN program_subject USING(program_id)
    INNER JOIN subject USING(subject_id)
    INNER JOIN enrollee_subject ON subject.subject_id = enrollee_subject.subject_id 
    AND enrollee_subject.enrollee_id = enrollee.enrollee_id
GROUP BY name_program, name_enrollee
ORDER BY name_program, itog DESC;


SELECT 
    name_program,
    name_enrollee,
    SUM(result) AS itog
FROM
    enrollee
    INNER JOIN program_enrollee USING(enrollee_id)
    INNER JOIN program USING(program_id)
    INNER JOIN program_subject USING(program_id)
    INNER JOIN subject USING(subject_id)
    INNER JOIN enrollee_subject USING(subject_id, enrollee_id)
GROUP BY 1, 2
ORDER BY 1, 3 DESC

10. Вывести название образовательной программы и фамилию тех абитуриентов, которые подавали документы на эту образовательную программу,
но не могут быть зачислены на нее. Эти абитуриенты имеют результат по одному или нескольким предметам ЕГЭ, необходимым для поступления 
на эту образовательную программу, меньше минимального балла. Информацию вывести в отсортированном сначала по программам, а потом по фамилиям
абитуриентов виде.


SELECT name_program, name_enrollee
FROM
    enrollee
    INNER JOIN program_enrollee USING(enrollee_id)
    INNER JOIN program USING(program_id)
    INNER JOIN program_subject USING(program_id)
    INNER JOIN enrollee_subject ON program_subject.subject_id = enrollee_subject.subject_id 
    AND enrollee_subject.enrollee_id = enrollee.enrollee_id
WHERE result < min_result
GROUP BY name_program, name_enrollee
ORDER BY 1, 2;


SELECT DISTINCT name_program, name_enrollee
FROM program JOIN program_subject USING(program_id)
            JOIN subject USING(subject_id)
            JOIN enrollee_subject USING(subject_id)
            JOIN enrollee USING(enrollee_id)
            JOIN program_enrollee USING(enrollee_id, program_id)
WHERE min_result > result
ORDER BY name_program, name_enrollee 


3.4 База данных «Абитуриент», запросы корректировки

1. Создать вспомогательную таблицу applicant,  куда включить id образовательной программы, id абитуриента, сумму баллов абитуриентов (столбец itog)
в отсортированном сначала по id образовательной программы, а потом по убыванию суммы баллов виде (использовать запрос из предыдущего урока).

CREATE TABLE applicant AS
SELECT program_id, enrollee_id, SUM(result) itog
FROM
    program_enrollee
    INNER JOIN program_subject USING(program_id)
    INNER JOIN enrollee_subject USING (subject_id, enrollee_id)
GROUP BY  2, 1
ORDER BY 1, 3 DESC;

SELECT * FROM applicant;

2. Из таблицы applicant, созданной на предыдущем шаге, удалить записи, если абитуриент на выбранную образовательную программу не набрал
минимального балла хотя бы по одному предмету (использовать запрос из предыдущего урока).

DELETE FROM applicant
WHERE (program_id, enrollee_id) IN 
(
    SELECT DISTINCT program.program_id, enrollee.enrollee_id
    FROM
        enrollee
        INNER JOIN program_enrollee USING(enrollee_id)
        INNER JOIN program USING(program_id)
        INNER JOIN program_subject USING(program_id)
        INNER JOIN enrollee_subject ON program_subject.subject_id = enrollee_subject.subject_id 
        AND enrollee_subject.enrollee_id = enrollee.enrollee_id
    WHERE result < min_result
);

SELECT * FROM applicant;


DELETE applicant
FROM
    applicant
    INNER JOIN program_subject USING(program_id)
    INNER JOIN enrollee_subject USING(enrollee_id, subject_id)
WHERE result < min_ball;

SELECT * FROM applicant;

3. Повысить итоговые баллы абитуриентов в таблице applicant на значения дополнительных баллов (использовать запрос из предыдущего урока).

UPDATE 
    applicant 

        INNER JOIN
    (
        SELECT enrollee_id, IF(SUM(bonus) IS Null, 0, SUM(bonus)) AS bonus
        FROM enrollee_achievement INNER JOIN achievement USING(achievement_id)
        GROUP BY enrollee_id 
    ) query_1

        USING (enrollee_id)

SET itog = itog + bonus;

SELECT * FROM applicant;

4. Поскольку при добавлении дополнительных баллов, абитуриенты по каждой образовательной программе могут следовать не в порядке убывания суммарных баллов,
необходимо создать новую таблицу applicant_order на основе таблицы applicant. При создании таблицы данные нужно отсортировать сначала по id 
образовательной программы, потом по убыванию итогового балла. А таблицу applicant, которая была создана как вспомогательная, необходимо удалить.

CREATE TABLE applicant_order AS
SELECT program_id, enrollee_id, itog 
FROM applicant
ORDER BY 1, 3 DESC;
DROP TABLE applicant;

SELECT * FROM applicant_order;

5. Включить в таблицу applicant_order новый столбец str_id целого типа , расположить его перед первым.

ALTER TABLE applicant_order ADD str_id int FIRST;
SELECT * FROM applicant_order;

6. Занести в столбец str_id таблицы applicant_order нумерацию абитуриентов, которая начинается с 1 для каждой образовательной программы.

SET @num_pr := 0;
SET @row_num := 1;
UPDATE applicant_order
SET str_id = IF(program_id = @num_pr, @row_num := @row_num + 1, @row_num := 1 AND @num_pr := program_id);

SELECT * FROM applicant_order;

7. Создать таблицу student,  в которую включить абитуриентов, которые могут быть рекомендованы к зачислению в соответствии с планом набора.
Информацию отсортировать сначала в алфавитном порядке по названию программ, а потом по убыванию итогового балла.

CREATE TABLE student AS
SELECT name_program, name_enrollee, SUM(itog) 
FROM 
    enrollee
    INNER JOIN applicant_order USING(enrollee_id)
    INNER JOIN program USING(program_id)
WHERE str_id <= plan
GROUP BY name_program, name_enrollee
ORDER BY 1, 3 DESC;

SELECT * FROM student;

3.5 База данных "Учебная аналитика по курсу"

1. Отобрать все шаги, в которых рассматриваются вложенные запросы (то есть в названии шага упоминаются вложенные запросы). 
Указать к какому уроку и модулю они относятся. Для этого вывести 3 поля:
- в поле Модуль указать номер модуля и его название через пробел;
- в поле Урок указать номер модуля, порядковый номер урока (lesson_position) через точку и название урока через пробел;
- в поле Шаг указать номер модуля, порядковый номер урока (lesson_position) через точку, порядковый номер шага (step_position) через точку и название шага через пробел.
Длину полей Модуль и Урок ограничить 19 символами, при этом слишком длинные надписи обозначить многоточием в конце
(16 символов - это номер модуля или урока, пробел и  название Урока или Модуля к ним присоединить "..."). 
Информацию отсортировать по возрастанию номеров модулей, порядковых номеров уроков и порядковых номеров шагов.


SELECT CONCAT(module_id, ' ', LEFT(module_name, 14),'...') AS Модуль,
        CONCAT(module_id,'.', lesson_position,' ', LEFT(lesson_name, 12),'...') AS Урок, 
        CONCAT(module_id, '.', lesson_position, '.', step_position, ' ', step_name) AS Шаг     
FROM
    module
    INNER JOIN lesson USING(module_id)
    INNER JOIN step USING(lesson_id)
WHERE step_name LIKE '%влож%'
ORDER BY 1, 2, 3;

2. Заполнить таблицу step_keyword следующим образом: если ключевое слово есть в названии шага, то включить в step_keyword строку с id шага
и id ключевого слова. 

INSERT INTO step_keyword (step_id, keyword_id)
SELECT step_id, keyword_id
FROM keyword CROSS JOIN step 
WHERE step_name REGEXP CONCAT('\\b', keyword_name, '\\b');

SELECT * FROM step_keyword;

3. Реализовать поиск по ключевым словам. Вывести шаги, с которыми связаны ключевые слова MAX и AVG одновременно. 
Для шагов указать id модуля, позицию урока в модуле, позицию шага в уроке через точку, после позиции шага перед заголовком - пробел. 
Позицию шага в уроке вывести в виде двух цифр (если позиция шага меньше 10, то перед цифрой поставить 0). Столбец назвать Шаг. 
Информацию отсортировать по первому столбцу в алфавитном порядке.

SELECT
    CONCAT(module_id, '.', lesson_position, IF(step_position < 10, ".0","."), step_position,' ', step_name) as Шаг 
FROM
    module
    INNER JOIN lesson USING(module_id)
    INNER JOIN step USING(lesson_id)
    INNER JOIN step_keyword USING(step_id)
    INNER JOIN keyword USING(keyword_id)

WHERE keyword_name IN ('MAX', 'AVG')
GROUP BY step_id
HAVING COUNT(keyword_id) = 2
ORDER BY 1;

4. Посчитать, сколько студентов относится к каждой группе. Столбцы назвать Группа, Интервал, Количество. Указать границы интервала.

SELECT Группа, Интервал, Количество
FROM
    (
    SELECT 
        CASE
            WHEN rate <= 10 THEN "I"
            WHEN rate <= 15 THEN "II"
            WHEN rate <= 27 THEN "III"
            ELSE "IV"
        END AS Группа,        
        CASE
            WHEN rate <= 10 THEN 'от 0 до 10'
            WHEN rate <= 15 THEN 'от 11 до 15'
            WHEN rate <= 27 THEN 'от 16 до 27'
            ELSE 'больше 27'
    END AS Интервал,
    COUNT(rate) AS Количество
    
    FROM
        (
        SELECT student_id, COUNT(*) AS rate
        FROM 
            (
            SELECT student_id
            FROM
                step_student
            WHERE result = 'correct'
            GROUP BY student_id, step_id
            ) query_in               
       GROUP BY student_id
       ) query_in_1
       GROUP BY 1,2
       ORDER BY 1
       ) query_in_2;

5. Исправить запрос примера так: для шагов, которые  не имеют неверных ответов,  указать 100 как процент успешных попыток, 
если же шаг не имеет верных ответов, указать 0. Информацию отсортировать сначала по возрастанию успешности, а затем по названию шага
в алфавитном порядке.

WITH get_count_correct (st_n_c, count_correct) 
  AS (
    SELECT step_name, count(*)
    FROM 
        step 
        INNER JOIN step_student USING (step_id)
    WHERE result = "correct"
    GROUP BY step_name
   ),
  get_count_wrong (st_n_w, count_wrong) 
  AS (
    SELECT step_name, count(*)
    FROM 
        step 
        INNER JOIN step_student USING (step_id)
    WHERE result = "wrong"
    GROUP BY step_name
   )  
SELECT st_n_c AS Шаг,
    ROUND(IFNULL((count_correct / (count_correct + count_wrong) * 100), 100)) AS Успешность
FROM  
    get_count_correct 
    LEFT JOIN get_count_wrong ON st_n_c = st_n_w
UNION
SELECT st_n_w AS Шаг,
    ROUND(IFNULL((count_correct / (count_correct + count_wrong) * 100), 0)) AS Успешность
FROM  
    get_count_correct 
    RIGHT JOIN get_count_wrong ON st_n_c = st_n_w
ORDER BY 2, 1;

6. Вычислить прогресс пользователей по курсу. Прогресс вычисляется как отношение верно пройденных шагов к общему количеству шагов в процентах,
округленное до целого. В нашей базе данные о решениях занесены не для всех шагов, поэтому общее количество шагов определить как количество различных
шагов в таблице step_student.
Тем пользователям, которые прошли все шаги (прогресс = 100%) выдать "Сертификат с отличием". 
Тем, у кого прогресс больше или равен 80% - "Сертификат". Для остальных записей в столбце Результат задать пустую строку ("").
Информацию отсортировать по убыванию прогресса, затем по имени пользователя в алфавитном порядке.

WITH get_count_correct (student_id, count_correct)
    AS (
        SELECT student_id, COUNT(DISTINCT step_id)
        FROM step_student
        WHERE result = "correct"
        GROUP BY student_id
    ),
    get_count_all (step_all) AS (
        SELECT COUNT(DISTINCT step_id)
        FROM step_student
    )

SELECT
    student_name AS `Студент`, 
    ROUND((COALESCE(count_correct, 0) / step_all) * 100) AS `Прогресс`,
    CASE 
        WHEN ROUND((COALESCE(count_correct, 0) / step_all) * 100) = 100 THEN 'Сертификат с отличием' 
        WHEN ROUND((COALESCE(count_correct, 0) / step_all) * 100) >= 80 THEN 'Сертификат'
        ELSE ''
    END AS `Результат`
FROM get_count_correct RIGHT JOIN student USING(student_id), get_count_all
ORDER BY `Прогресс` DESC, `Студент`
;

7. Для студента с именем student_61 вывести все его попытки: название шага, результат и дату отправки попытки (submission_time).
Информацию отсортировать по дате отправки попытки и указать, сколько минут прошло между отправкой соседних попыток. 
Название шага ограничить 20 символами и добавить "...". Столбцы назвать Студент, Шаг, Результат, Дата_отправки, Разница.

SELECT
    student_name AS Студент,
    CONCAT(LEFT(step_name, 20), '...') AS Шаг,
    result AS Результат,
    FROM_UNIXTIME(submission_time) AS Дата_отправки,
            SEC_TO_TIME(IFNULL(submission_time - LAG(submission_time)
            OVER (ORDER BY submission_time), 0)) AS Разница
FROM step
    INNER JOIN step_student USING(step_id)
    INNER JOIN student USING(student_id)
WHERE student_id = 61;

8. Посчитать среднее время, за которое пользователи проходят урок по следующему алгоритму:

- для каждого пользователя вычислить время прохождения шага как сумму времени, потраченного на каждую попытку
(время попытки - это разница между временем отправки задания и временем начала попытки), при этом попытки,
которые длились больше 4 часов не учитывать, так как пользователь мог просто оставить задание открытым в браузере, а вернуться к нему
на следующий день;
- для каждого студента посчитать общее время, которое он затратил на каждый урок;
- вычислить среднее время выполнения урока в часах, результат округлить до 2-х знаков после запятой;
- вывести информацию по возрастанию времени, пронумеровав строки, для каждого урока указать номер модуля и его позицию в нем.
Столбцы результата назвать Номер, Урок, Среднее_время.

WITH 
students_steps (student_id, step_id, subm_seconds)
    AS (
        SELECT
            student_id,
            step_id,
            SUM(submission_time - attempt_time) AS subm_seconds   
        FROM step_student
        WHERE ((submission_time - attempt_time) <= 4*3600)
        GROUP BY student_id, step_id
    ),
lesson_student_time (lesson_id, student_id, lesson_seconds)
    AS (
        SELECT lesson_id, student_id, SUM(subm_seconds) AS lesson_seconds
        FROM
            step 
            INNER JOIN students_steps USING(step_id)
        GROUP BY lesson_id, student_id
        ORDER BY lesson_id
     ),
lesson_avg_time (lesson_id, avg_time_hours) 
    AS (
        SELECT lesson_id, ROUND(AVG(lesson_seconds) / 3600, 2) AS avg_time_hours
        FROM lesson_student_time
        GROUP BY lesson_id
    )
SELECT
    ROW_NUMBER() OVER (ORDER BY avg_time_hours) AS `Номер`, 
    CONCAT(module_id, '.', lesson_position, ' ', lesson_name) AS `Урок`,
    avg_time_hours AS `Среднее_время`
FROM lesson_avg_time INNER JOIN lesson USING(lesson_id)
ORDER BY avg_time_hours;

9. Вычислить рейтинг каждого студента относительно студента, прошедшего наибольшее количество шагов в модуле (вычисляется как отношение
количества пройденных студентом шагов к максимальному количеству пройденных шагов, умноженное на 100). Вывести номер модуля, имя студента,
количество пройденных им шагов и относительный рейтинг. Относительный рейтинг округлить до одного знака после запятой.
Столбцы назвать Модуль, Студент, Пройдено_шагов и Относительный_рейтинг  соответственно. Информацию отсортировать сначала по возрастанию номера
модуля, потом по убыванию относительного рейтинга и, наконец, по имени студента в алфавитном порядке.

WITH
get_rate_lesson(module_id, student, rate) 
    AS (
           SELECT module_id, student_name, count(DISTINCT step_id)
           FROM student INNER JOIN step_student USING(student_id)
                        INNER JOIN step USING (step_id)
                        INNER JOIN lesson USING (lesson_id)
           WHERE result = "correct"
           GROUP BY module_id, student_name
        )
    
SELECT
    module_id AS `Модуль`,
    student AS `Студент`,
    rate AS `Пройдено_шагов`,
    ROUND((rate / MAX(rate) OVER (PARTITION BY module_id)) * 100, 1)  AS `Относительный_рейтинг`
FROM get_rate_lesson
ORDER BY 1, 4 DESC, 2

10. Проанализировать, в каком порядке и с каким интервалом пользователь отправлял последнее верно выполненное задание каждого урока. 
В базе занесены попытки студентов  для трех уроков курса, поэтому анализ проводить только для этих уроков.

Для студентов прошедших как минимум по одному шагу в каждом уроке, найти последний пройденный шаг каждого урока - крайний шаг, и указать:

- имя студента;
- номер урока, состоящий из номера модуля и через точку позиции каждого урока в модуле;
- время отправки  - время подачи решения на проверку;
- разницу во времени отправки между текущим и предыдущим крайним шагом в днях, при этом для первого шага поставить прочерк ("-"), 
а количество дней округлить до целого в большую сторону.

Столбцы назвать  Студент, Урок,  Макс_время_отправки и Интервал  соответственно. Отсортировать результаты по имени студента в алфавитном порядке,
а потом по возрастанию времени отправки.

WITH 
students_steps (step_id, student_id, submission_time)
    AS (
    SELECT
        step_id,
        student_id,
        submission_time
    FROM step_student
    WHERE result = 'correct'
    ),

students_lessons (lesson_id, student_id, max_submission_time)
    AS (
        SELECT 
            CONCAT(module_id, '.', lesson_position), 
            student_id,
            MAX(submission_time)
        FROM students_steps
        INNER JOIN step USING (step_id)
        INNER JOIN lesson USING(lesson_id)
        GROUP BY lesson_id, student_id
        ),
        
get_student_three_lesson (student_id)
    AS (
        SELECT student_id
        FROM students_lessons
        GROUP BY student_id
        HAVING COUNT(lesson_id) = 3
        )
        
SELECT
    student_name AS `Студент`,
    lesson_id AS `Урок`,
    FROM_UNIXTIME(max_submission_time) AS `Макс_время_отправки`,
    IFNULL(CEIL((max_submission_time - LAG(max_submission_time)
    OVER (PARTITION BY student_name ORDER BY max_submission_time)) / 86400), '-') AS `Интервал`
    
FROM students_lessons 
INNER JOIN get_student_three_lesson USING(student_id)
INNER JOIN student USING(student_id)
ORDER BY student_name, max_submission_time;

11. Для студента с именем student_59 вывести следующую информацию по всем его попыткам:

- информация о шаге: номер модуля, символ '.', позиция урока в модуле, символ '.', позиция шага в модуле;
- порядковый номер попытки для каждого шага - определяется по возрастанию времени отправки попытки;
- результат попытки;
- время попытки (преобразованное к формату времени) - определяется как разность между временем отправки попытки и времени ее начала,
в случае если попытка длилась более 1 часа, то время попытки заменить на среднее время всех попыток пользователя по всем шагам без учета тех,
которые длились больше 1 часа;
- относительное время попытки  - определяется как отношение времени попытки (с учетом замены времени попытки) к суммарному времени всех попыток 
шага, округленное до двух знаков после запятой.
Столбцы назвать  Студент,  Шаг, Номер_попытки, Результат, Время_попытки и Относительное_время.
Информацию отсортировать сначала по возрастанию id шага, а затем по возрастанию номера попытки (определяется по времени отправки попытки).

Важно. Все вычисления производить в секундах, округлять и переводить во временной формат только для вывода результата.

WITH
all_students_attempts (step, student, module_num, attempt_num, result, time_attempt)
    AS (
        SELECT
            step_id,
            student_name,
            CONCAT(module_id, '.', lesson_position,'.', step_position),
            DENSE_RANK() OVER(PARTITION BY step_id ORDER BY attempt_time),
            result,
            submission_time - attempt_time
        FROM
            student
            INNER JOIN step_student USING(student_id)
            INNER JOIN step USING(step_id)
            INNER JOIN lesson USING(lesson_id)
        WHERE student_name = 'student_59'
        ORDER BY step_id, DENSE_RANK() OVER(PARTITION BY step_id ORDER BY attempt_time)
        ),
        
avg_time(step, student, module_num, attempt_num, result, medium_time)
    AS (
        SELECT step, student, module_num, attempt_num, result, 
                IF(time_attempt >= 3600,
                   ROUND((SELECT AVG(time_attempt) FROM all_students_attempts WHERE time_attempt <= 3600)),
                   time_attempt)
        FROM all_students_attempts
        )

SELECT
    student AS `Студент`,
    module_num AS `Шаг`,
    attempt_num AS `Номер_попытки`,
    result AS `Результат`, 
    SEC_TO_TIME(medium_time) AS `Время_попытки`, 
    ROUND((medium_time / SUM(medium_time) OVER(PARTITION BY step) * 100), 2) AS `Относительное_время`
FROM avg_time;

12. Online курс обучающиеся могут проходить по различным траекториям, проследить за которыми можно по способу решения ими заданий шагов курса. 
Большинство обучающихся за несколько попыток  получают правильный ответ и переходят к следующему шагу. Но есть такие, что остаются на шаге,
выполняя несколько верных попыток, или переходят к следующему, оставив нерешенные шаги.
Выделив эти "необычные" действия обучающихся, можно проследить их траекторию работы с курсом и проанализировать задания, 
для которых эти действия выполнялись, а затем их как-то изменить. 

Для этой цели необходимо выделить группы обучающихся по способу прохождения шагов:

I группа - это те пользователи, которые после верной попытки решения шага делают неверную (скорее всего для того, чтобы поэкспериментировать
    или проверить, как работают примеры);
II группа - это те пользователи, которые делают больше одной верной попытки для одного шага (возможно, улучшают свое решение или пробуют
    другой вариант);
III группа - это те пользователи, которые не смогли решить задание какого-то шага (у них все попытки по этому шагу - неверные).

Вывести группу (I, II, III), имя пользователя, количество шагов, которые пользователь выполнил по соответствующему способу.
Столбцы назвать Группа, Студент, Количество_шагов. Отсортировать информацию по возрастанию номеров групп, потом по убыванию
количества шагов и, наконец, по имени студента в алфавитном порядке.

UPDATE step_student
SET result = IF(result = 'correct', 1, 0);

WITH
prev_step_right (student, step, result, prev_step)
    AS (
        SELECT
            student_name,
            step_id,
            result,
            LAG(result) OVER(PARTITION BY student_id, step_id ORDER BY submission_time) AS prev_step
        FROM step_student
        INNER JOIN student USING(student_id)
        ),

all_correct_attempts (student, step, count_result)
    AS (
        SELECT student_name, step_id, COUNT(result)
        FROM step_student
        INNER JOIN student USING(student_id)
        WHERE result = 1
        GROUP BY student_id, step_id
        HAVING COUNT(result) > 1
        ),
                        
all_wrong_attempts (student, step, wrong_attempts, count_result)
    AS (
        SELECT student_name,
                step_id,
                SUM(CASE WHEN result = 0 THEN 1 ELSE 0 END) AS wrong_attempt, 
                COUNT(result)
        FROM step_student
        INNER JOIN student USING(student_id)
        GROUP BY student_id, step_id
        HAVING SUM(CASE WHEN result = 0 THEN 1 ELSE 0 END) = COUNT(result)
        ),
        
        
group_1 (`Группа`, `Студент`, `Количество_шагов`)
    AS (
        SELECT
            'I' AS `Группа`,
            student AS `Студент`,
            COUNT(step) AS `Количество_шагов`
        FROM prev_step_right
        WHERE prev_step = 1 AND result = 0
        GROUP BY student
        ),
        
group_2 (group2, student, count_steps)
    AS (
        SELECT
            'II' AS `Группа`,
            student AS `Студент`,
            COUNT(step) AS `Количество_шагов`
        FROM all_correct_attempts
        GROUP BY student
        ),

group_3 (group3, student, count_steps)
    AS (
        SELECT
            'III' AS `Группа`,
             student AS `Студент`,
             COUNT(step) AS `Количество_шагов`
        FROM all_wrong_attempts
        GROUP BY student
        )

SELECT * FROM group_1
UNION 
SELECT * FROM group_2
UNION  
SELECT * FROM group_3
ORDER BY 1, 3 DESC, 2;


##############################################################
4. SQL запросы пользователей
##############################################################

1. Провести аналитику по трем ценовым категориям (до 600 руб, от 600 руб до 700 руб, свыше 700 руб) и вывести среднюю цену  книги,
 общую стоимость остатков книг  в этой ценовой позиции и количество позиций. Среднюю цену и стоимость округлить до двух знаков после запятой.
 Информацию отсортировать по возрастанию нижней границы ценовой категории.

SELECT
    beg_range,
    end_range,
    ROUND(AVG(price), 2) AS `Средняя_цена`,
    ROUND(SUM(amount * price), 2) AS `Стоимость`,
    COUNT(amount) AS `Количество`
FROM book, stat
WHERE price >=beg_range and price <=end_range
GROUP BY beg_range, end_range
ORDER BY beg_range

2. Вывести всю информацию из таблицы book, упорядоченную по возрастанию длины названия книги.

SELECT * FROM book
ORDER BY length(title);

3. Удалить из таблиц book и supplyкниги, цены которых заканчиваются на 99 копеек. Например, книга с ценой 670.99 должна быть удалена.

DELETE FROM book
WHERE price LIKE '%.99';

DELETE FROM supply
WHERE price LIKE '%.99';

4. Снизить цены книг, цена которых больше 600 рублей, на 20%. Вывести информацию о книгах, скидку (столбец sale_20) и цену книги 
со скидкой (price_sale).  Результаты округлить до двух знаков после запятой. Для тех книг, на которые скидка не действует, в последних двух
столбцах вывести символ  "-".  Отсортировать информацию сначала по фамилии автора, а потом по названию книги.

SELECT
    author,
    title,
    price,
    amount,
    IF(price > 600, ROUND(price * 0.2, 2), '-') AS sale_20,
    IF(price > 600, ROUND((price - price * 0.2), 2),'-') AS price_sale
FROM book
ORDER BY author, title;

5. Вывести авторов и суммарную стоимость их книг, если хотя бы одна их книга имеет цену выше средней по складу. Средняя цена рассчитывается как
 простое среднее, с помощью avg(). Информацию отсортировать по убыванию суммарной стоимости.

SELECT
    author,
    SUM(price * amount) AS `Стоимость`
FROM book
WHERE price * amount > (SELECT AVG(price) FROM book)
GROUP BY author
ORDER BY Стоимость DESC;

6. Вывести автора, название, количество, цену (Розничная_цена). Для тех книг количество которых больше или равно 10, отобразить оптовую скидку 15% 
Скидка), округлить до двух знаков после запятой и вывести оптовую цену с учетом скидки -15% (Оптовая_цена). Все атрибуты перевести на русский язык.
Отсортировать по автору и названию книги.

SELECT
    author AS `Автор`,
    title AS `Название_книги`,
    amount AS `Количество`,
    price AS `Розничная_цена`,
    IF(amount >= 10, 15, 0) AS `Скидка`,
    IF(amount >= 10, ROUND((price * 0.85), 2), price) AS `Оптовая_цена`
FROM book
ORDER BY 1, 2;

7. Вывести авторов, у которых есть книги со стоимостью более 500 и количеством более 1 шт на складе. Учитывать книги только тех авторов,
у которых не менее 2-х произведений на складе. Вывести автора, количество различных произведений автора, минимальную цену и количество книг
на складе. Информацию отсортировать по фамилии автора в алфавитном порядке.

SELECT
    author,
    COUNT(amount) AS `Количество_произведений`,
    MIN(price) AS `Минимальная_цена`,
    SUM(amount) AS `Число_книг`
FROM book
GROUP BY author
HAVING COUNT(amount) > 1
ORDER BY 1;

8. Магазин счёл, что классика уже не пользуется популярностью, поэтому необходимо в выборке:
- Сменить всех авторов на "Донцова Дарья".
- К названию каждой книги в начале дописать "Евлампия Романова и " ( пробел в конце).
- Цену поднять на 42% (округлить её до двух знаков после запятой).
- Отсортировать по убыванию цены.

SELECT
    CONCAT('Донцова Дарья') AS author,
    CONCAT('Евлампия Романова и ', title) AS title,
    ROUND((price * 0.42 + price),2) AS price
FROM book
ORDER BY price DESC;

9. Вывести жанр(ы), в котором было заказано меньше всего экземпляров книг, указать это количество. Учитывать только жанры, в которых была
заказана хотя бы одна книга.
При реализации в основном запросе не используйте LIMIT, поскольку жанров с минимальным количеством заказанных книг может быть несколько.

SELECT name_genre, SUM(buy_book.amount) AS Количество
FROM genre
    INNER JOIN book USING(genre_id)
    INNER JOIN buy_book USING(book_id)
GROUP BY name_genre
HAVING SUM(buy_book.amount) =  
    (
    SELECT MIN(sum_amount) AS min_sum_amount 
    FROM
        (
        SELECT SUM(buy_book.amount) AS sum_amount 
        FROM book 
        INNER JOIN buy_book USING(book_id)
        GROUP BY genre_id
        )query_in 
    );

10. Создать новую таблицу store, в которую занести данные из таблиц book и supply, при условии, что количество книг будет больше среднего
количества книг по двум таблицам; если книга есть в обеих таблицах, то стоимость выбрать большую из двух. Отсортировать данные из таблицы
их по имени автора в алфавитном порядке и по убыванию цены. Вывести данные из полученной таблицы.

CREATE table store AS
SELECT title, author, MAX(price) AS price, SUM(amount) AS amount
    FROM (
        SELECT * FROM book
        UNION 
        SELECT * FROM supply)query_in
GROUP BY title, author
HAVING SUM(amount) > (SELECT AVG(amount) FROM 
                                  (SELECT amount FROM book
                                  UNION 
                                  SELECT amount FROM supply)query_1)
ORDER BY 2, price DESC;                                  
SELECT * FROM store;

11. Объявить столбец "категории цены" (price_category): <500 - "низкая", 500 - 700 - "средняя", более 700 - "высокая"
Вывести автора, название, категорию, стоимость (цена * количество), исключив из авторов Есенина, из названий "Белую гвардию".
Отсортировать по убыванию стоимости и названию (по возрастанию)

SELECT
    author,
    title,
     CASE 
        WHEN price < 500 THEN 'низкая'
        WHEN price BETWEEN 500 AND 700 THEN 'средняя'    
        ELSE 'высокая'
     END AS price_category,
    (price * amount) AS cost
FROM book
WHERE author NOT LIKE 'Есенин%' and title <> 'Белая гвардия'
ORDER BY 4 DESC;

12. Для нечетного количества книг посчитать разницу максимальной стоимости (цена * количество) и стоимостью всех экземпляров конкретной книги. 
Отсортировать по этой разнице по убыванию. Вывести название, автора, количество, разницу с максимальной стоимостью.

SELECT
    title,
    author,
    amount,
    (SELECT MAX(price * amount) FROM book) - price * amount AS `Разница_с_макс_стоимостью`
FROM book
WHERE amount % 2 = 1
ORDER BY 4 DESC

13. Магазин решил быстрее распродать остатки книг, цена которых выше 600, а также прописать условия доставки. Создать запрос на выборку, в котором:

Столбцы назовите Наименование, Цена и  Стоимость доставки.
Отберите все книги, цена которых выше 600.
Если остаток по отдельной книге меньше или равен 5, то стоимость доставки будет 500 рублей, если больше 5, то доставка будет бесплатной (вместо стоимости доставки вставить Бесплатно).
Отсортируйте значения по убыванию цены книг.

SELECT
    title AS `Наименование`,
    price AS `Цена`,
    IF(amount <= 5, 500, 'Бесплатно') AS `Стоимость_доставки`
FROM book
WHERE price > 600
ORDER BY 2 DESC;

14. На распродаже размер скидки устанавливается в зависимости от количества экземпляров книги в магазине и от цены книги: для книг в остатке
не менее 5 шт скидка 50%, тогда как для книг в остатке менее 5 шт скидка устанавливается в зависимости от цены (на книги не дешевле 700 руб
скидка 20%, на остальные 10%). Два последних столбца назвать Скидка и Цена_со_скидкой. Последний столбец округлить до двух знаков после запятой.

SELECT
    author, title, amount, price,
       IF(amount >= 5, '50%', IF(amount < 5 AND price > 700, '20%', '10%')) AS `Скидка`,
       IF(amount >= 5, ROUND((price * 0.5), 2),
       IF(amount < 5 AND price > 700,
         ROUND((price * 0.8), 2), ROUND((price * 0.9), 2))) AS `Цена_со_скидкой`
FROM book;

15. Определить стоимость доставки:
- для книг c ценой 500 и менее, установить в размере 99.99
- при количестве книг на складе менее 5, а ценой выше 500, установить в размере 149.99
- для остальных случаев доставка должна быть бесплатной
Определить новую стоимость для книг:
- для книг, совокупной стоимостью более 5000, добавить 20% к стоимости за экземпляр
- для остальных случаев снизить стоимость одного экземпляра на 20%
Настроить фильтр при выборке:
- только позиции творчества авторов: Булгаков и Есенин, при количестве экземпляров на складе: от 3 до 14 включительно.
Сортировку выполнить:
- по имени автора в порядке возрастания
- затем по названию в порядке убывания
- по стоимости доставки (от меньшей к большей)
В таблице должны быть отображены данные:
- автора
- название
- количество
- цену, как real_price
- новую цену, как new_price (округлить до двух знаков после запятой)
- стоимость доставки, как delivery_price 


SELECT
    author,
    title, 
    amount,
    price AS real_price,
    CASE
        WHEN price * amount > 5000 THEN ROUND(price * 1.2, 2)
        ELSE ROUND(price * 0.8, 2)
    END AS new_price,
    CASE
        WHEN price <= 500 THEN 99.99
        WHEN amount < 5 THEN 149.99
        ELSE 0
    END AS delivery_price
FROM book
WHERE author IN ('Булгаков М.А.', 'Есенин С.А.') AND amount BETWEEN 3 AND 14
ORDER BY author, title DESC, delivery_price;

16.Вывести авторов и названия книг и их цену в двух столбцах - рубли и копейки.  Информацию отсортировать по убыванию копеек. 

SELECT
    author, 
    title,
    CAST(TRUNCATE(price, 0) AS SIGNED) AS `Рубли`,
    CAST((price * 100 )% 100 AS SIGNED) AS `Копейки`

FROM book
ORDER BY `Копейки` DESC;

17. В связи с повышенным спросом на классическую литературу школьниками в формате "А есть то же самое, но покороче, чтобы читать поменьше?" была выпущена серия "Графоман и. Краткое содержание".
В выборке:
- к имени автора добавить "Графоман и ";
- к названию книги дописать ". Краткое содержание.";
- цену на новый опус установить 40% от цены оригинала, но не более 250. (Если 40% больше 250, то цена должна быть 250);
- в зависимости от остатка на складе вывести "Спрос": до 3 (включительно) - высокий, до 10 (включительно) - средний, иначе низкий;
- добавить колонку "Наличие" в зависимости от количества: 1-2 шт - очень мало, 3-14 - в наличии, 15 и больше - много;
- отсортировать по цене по возрастанию, затем по Спросу от высокого к низкому, а затем по названию книги в алфавитном порядке.

SELECT
    CONCAT('Графоман и ', author) AS `Автор`,
    CONCAT(title, '. Краткое содержание.') AS `Название`,
    IF(price * 0.4 < 250, price * 0.4, 250) AS `Цена`,
    CASE
        WHEN amount <= 3 THEN 'высокий'
        WHEN amount <= 10 THEN 'средний'
        ELSE 'низкий'
    END AS `Спрос`,
    CASE
        WHEN amount BETWEEN 1 AND 2 THEN 'очень мало'
        WHEN amount BETWEEN 3 AND 14 THEN 'в наличии'
        ELSE 'много'
    END AS `Наличие`
FROM book
ORDER BY 3, amount, 2;


18. Для клиентов у которых сумма заказов выше средней по суммам заказов клиентов (общей стоимости всех заказов клиентов), вывести имя, общую сумму
всех заказов, количество заказов, количество заказанных книг. Этим клиентам мы предложим специальную программу лояльности! Информацию отсортировать
по имени клиентов (в алфавитном порядке).

WITH sum_price_client(sum_price)
    AS (
        SELECT SUM(price * buy_book.amount)
        FROM book
            INNER JOIN buy_book USING(book_id) 
            INNER JOIN buy USING(buy_id)
        GROUP BY client_id
        )        
SELECT 
    name_client,
    SUM(price * buy_book.amount) AS `Общая_сумма_заказов`,
    COUNT(DISTINCT buy_book.buy_id) AS `Заказов_всего`,
    SUM(buy_book.amount) AS `Книг_всего`
FROM client
    INNER JOIN buy USING(client_id)
    INNER JOIN buy_book USING(buy_id)
    INNER JOIN book USING(book_id)
GROUP BY name_client
HAVING SUM(price * buy_book.amount) > (SELECT AVG(sum_price) FROM sum_price_client)
ORDER BY name_client;

19. Составить рейтинг книг в зависимости от того, какая книга принесет больше всего выручки (в процентах), при условии продажи всех книг. 
Рейтинг отсортировать по убыванию выручки. Выручка в процентах вычисляется как стоимость всех экземпляров книги деленное на суммарную стоимость
всех экземпляров книг на складе и умноженное на 100, полученный результат округлить до двух знаков после запятой.
Судя по результату, магазин хорошо вложился в Стихи Есенина

SELECT
    author,
    title,
    price,
    amount,
    ROUND((price * amount) / (SELECT SUM(price * amount) FROM book) * 100, 2) AS income_percent
FROM book
ORDER BY income_percent DESC;

20. Для каждого автора из таблицы author вывести количество книг, написанных им в каждом жанре.
Вывести: ФИО автора, жанр, количество.
Отсортировать: по фамилии, затем - по убыванию количества написанных книг, а затем в алфавитном порядке по названию жанра.
Важно! Реализовать задание одним запросом на выборку.

SELECT
    name_author,
    name_genre,
    COUNT(title) AS `Количество`
FROM author
CROSS JOIN genre
LEFT JOIN book USING(author_id, genre_id)
GROUP BY  name_genre, name_author
ORDER BY name_author, `Количество` DESC, name_genre

21. Акция "Купи книгу от 500 руб. и получи подарок".
Вывести автора, название книги и цену. Выбрать книги с ценой 500 рублей и выше, отсортировать информацию в алфавитном порядке по автору
и названию книги. Добавить столбец Подарок,  в котором вывести, какой подарок получает покупатель: если куплена книга от 500 рублей до 600 рублей
(включительно), то подарок - ручка, от 600 до 700 (включительно) - детская раскраска, выше 700 - гороскоп.

SELECT
    author AS `Автор`,
    title AS `Название_книги`,
    price AS `Цена`,
    CASE
        WHEN price BETWEEN 500 AND 600 THEN 'ручка'
        WHEN price BETWEEN 600 AND 700 THEN 'детская раскраска'
        ELSE 'гороскоп'
    END AS `Подарок`
FROM book
WHERE price >= 500
ORDER BY 1, 2;

22. При анализе остатков книг на складе было решено дополнительно заказать книги авторов, у которых суммарное число экземпляров книг меньше 10.
В таблице должны быть отображены авторы, наименьшее и наибольшее количество их книг.

SELECT
    author AS `Автор`,
    MIN(amount) AS `Наименьшее_кол_во`,
    MAX(amount) AS `Наибольшее_кол_во`
FROM book
GROUP BY author
HAVING SUM(amount) < 10;

23. В последний заказ (таблица buy_book) клиента Баранов Павел добавить по одному экземпляру всех книг Достоевского, которые есть в таблице book.

INSERT INTO buy_book(buy_id, book_id, amount)
WITH last_order AS (
    SELECT MAX(buy_id) AS last_buy_id
    FROM client INNER JOIN buy USING(client_id)
    WHERE name_client = "Баранов Павел"
), add_book AS (
    SELECT book_id, 1 AS amount
    FROM book INNER JOIN author USING(author_id)
    WHERE name_author = "Достоевский Ф.М."
) SELECT *
  FROM last_order CROSS JOIN add_book;

24. Найти вопрос, с самой большой успешностью выполнения - "самый легкий" и вопрос, с самой маленькой успешностью выполнения - "самый сложный". 
(Подробно про успешность на этом шаге). Вывести предмет, эти два вопроса и указание - самый сложный или самый легкий это вопрос. 
Сначала вывести самый легкий запроса, потом самый сложный.

WITH
    success_percent(name_subject, name_question, complexity)
    AS (
        SELECT name_subject, 
        name_question,
        ROUND(((SUM(is_correct) / COUNT(attempt_id)) * 100), 2)
        FROM subject
            INNER JOIN question  USING(subject_id)
            INNER JOIN testing  USING(question_id)
            INNER JOIN answer  USING(answer_id)
        GROUP BY name_subject, name_question
        )

SELECT
    name_subject, 
    name_question,
    IF(complexity IN (SELECT MAX(complexity) FROM success_percent), 'самый легкий', 'самый сложный') AS 'Сложность'
FROM success_percent                   
WHERE complexity IN ((SELECT MAX(complexity) FROM success_percent),
                     (SELECT MIN(complexity) FROM success_percent)) 
ORDER BY 3;

25. Для повышения успеваемости, предоставить возможность студентам снова пройти тестирование.
Для студентов, у которых количество попыток меньше 3 и максимальный балл < 70, в таблицу attempt добавить новые попытки по соответствующим 
предметам с текущей датой.


INSERT INTO attempt (student_id, subject_id, date_attempt, result)
    SELECT student_id, subject_id, NOW(), null
    FROM attempt
    WHERE student_id IN (SELECT student_id
                         FROM attempt
                         GROUP BY student_id
                         HAVING COUNT(attempt_id) < 3
                         AND student_id NOT IN (SELECT DISTINCT student_id
                                                  FROM attempt
                                                  WHERE result > 70))
    ORDER BY 2, 1;
SELECT * FROM attempt;


INSERT INTO attempt(student_id, subject_id, date_attempt, result)
WITH bad_s (student_id, subject_id)
AS ( 
    SELECT student_id, subject_id
    FROM attempt
    GROUP BY student_id, subject_id
    HAVING COUNT(attempt_id) < 3 AND MAX(result) < 70
    ORDER BY student_id, subject_id
) SELECT *, CURRENT_DATE(), NULL
  FROM bad_s;


CREATE VIEW bad_s AS (
    SELECT student_id, subject_id
    FROM attempt
    GROUP BY student_id, subject_id
    HAVING COUNT(attempt_id) < 3 AND MAX(result) < 70
    ORDER BY student_id, subject_id
);

INSERT INTO attempt (student_id, subject_id, date_attempt)
SELECT *, NOW() FROM bad_s;



