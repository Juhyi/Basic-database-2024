-- SQL 연습문제 PART.3
-- 1. 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
select distinct name custid
from Customer c join Orders o
on c.custid = o.custid
where bookid in (select bookid
from Book b
where c.name not like '박지성' and
publisher in (
		select publisher
		from Orders o join Book b
		on o.bookid = b.bookid
        where o.custid = (
			select custid
            from Customer
            where name like '박지성'
        )
));

SELECT DISTINCT custid
 FROM Orders
 WHERE bookid IN(
SELECT bookid
  FROM Book
 WHERE publisher IN (SELECT b.publisher
                       FROM Customer c, Orders o, Book b
                      WHERE c.custid = o.custid 
                        AND o.bookid = b.bookid
                        AND c.[name] = '박지성'));

-- 2. 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
SELECT [name]
FROM customer c1
WHERE 2 >= (
	SELECT count(DISTINCT publisher)
	FROM orders JOIN book ON orders.bookid = book.bookid
				JOIN customer ON orders.custid = customer.custid
	WHERE [name] LIKE c1.name
	);

-- 3. 전체 고객에서 30% 이상이 구매한 도서
SELECT b.custid
      ,CONVERT(float, b.custCount) / b.totalCount AS 구매율
  FROM (SELECT  custid
              , COUNT(custid) AS custCount
              , (SELECT COUNT(custid) FROM Orders) AS totalCount
          FROM Orders
        GROUP BY custid) AS b
  WHERE CONVERT(float, b.custCount) / b.totalCount >= 0.3;

 SELECT b1.bookid
 FROM Book b1
 WHERE (
	SELECT count(b1.bookid)
    FROM book JOIN orders
    ON book.bookid = orders.bookid
    WHERE book.bookid = b1.bookid
 ) >= 0.3 * (SELECT count(*) FROM customer);

-- SQL 연습문제 PART.4
-- 1. 새로운 도서('스포츠 세계','대한미디어',10,000원)가 마당서점에 입고 되었다. 삽입이 안 될 때 필요한 데이터가 더 있는지 찾아보시오.
INSERT INTO Book
     VALUES (12, '스포츠 세계','대한미디어',10000);  -- bookid 필요

-- 2. '성심당'에서 출판한 도서를 삭제하시오
DELETE FROM Book
 WHERE publisher = '성심당';

-- 3. '이상미디어'에서 출판한 도서를 삭제하시오
DELETE FROM Book
 WHERE publisher = '이상미디어';
-- 참조 무결성 제약조건
-- Orders 테이블에서 이상미디어에서 출판한 책의 정보를 가지고 있기 때문에 삭제 불가능
-- RESTRICT(자식에서 키를 사용하고 있으면 부모 삭제 금지)
-- 삭제하려면 Orders테이블에서 bookid7, 8을 삭제 후 삭제 가능

-- 4. 출판사 '대한미디어'를 '대한출판사'로 이름을 바꾸시오
UPDATE Book
   SET publisher = '대한출판사'
 WHERE publisher = '대한미디어';

UPDATE Book
   SET publisher = '대한출판사'
 WHERE bookid IN (SELECT bookid
                     FROM Book
                   WHERE publisher = '대한미디어')