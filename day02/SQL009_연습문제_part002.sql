-- 연습문제 part.2
-- 마당서점 도서의 총 갯수
SELECT COUNT(*) AS [도서 총 권수]
  FROM Book;

-- 마당서점에 도서를 출고하는 출판사의 총 갯수
SELECT  COUNT(DISTINCT publisher) AS [출판사 수]
  FROM Book;

-- 모든 고객의 이름, 주소
SELECT [name], [address]
  FROM Customer;

-- 2023.07.04 ~ 07.07 사이에 주문 받은 도서의 주문번호
SELECT orderid
 FROM Orders
 WHERE orderdate BETWEEN '2023/07/04' AND '2023/07/07';

 -- 2023.07.04 ~ 07.07 사이에 주문 받은 도서를 제외한 도서의 주문번호
 SELECT orderid
   FROM Orders
  WHERE NOT orderdate BETWEEN '2023/07/04' AND '2023/07/07';

 -- 성이 '김'씨인 고객의 이름과 주소
 SELECT [name], [address]
   FROM Customer
  WHERE [name] LIKE '김%'; 

 -- 성이 '김'씨이고 이름이 '아'인 고객의 이름과 주소
 SELECT [name], address
   FROM Customer
  WHERE [name] LIKE '김%아';
 


