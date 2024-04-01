-- Customer를 기준으로 Orders 테이블과 외부조인하기
SELECT c.custid
      ,c.[name]
      ,c.[address]
      ,c.phone
      ,o.bookid
      ,o.custid
      ,o.orderdate
      ,o.orderid
      ,o.saleprice
  FROM Customer AS c LEFT OUTER JOIN Orders AS o
    ON c.custid =  o.custid