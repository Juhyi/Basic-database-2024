-- ��� ������ �̸��� ������ �˻��Ͻÿ�
-- Ctrl + Shift + U --> �빮��, Ctrl + shitf + L --> �ҹ���
 SELECT bookname, price
   FROM Book;

-- ��� ������ ���ݿ� �̸��� �˻��Ͻÿ�
SELECT price, bookname
  FROM Book;

-- ��� ������ ������ȣ, �����̸�, ���ǻ� ������ �˻��Ͻÿ�.
SELECT *
  FROM Book;

-- �ǹ������� �Ӽ�, �÷����� �� ���°� �Ϲ���
SELECT bookid, bookname, publisher, price
  FROM Book;

-- ���� ���̺� �ִ� ���ǻ縦 �˻��Ͻÿ�. (�ߺ����� - DISTINCT)/(ALL - �⺻��)
SELECT DISTINCT publisher
  FROM Book;

-- ���ǰ˻�(���� ������ ���)
-- ������ 2���� �̸��� ���� �˻��Ͻÿ�.
SELECT *
  FROM Book
 WHERE price < 20000;

-- ������ 1���� �̻� 2���� ������ ������ �˻��Ͻÿ�.
SELECT *
  FROM Book
 WHERE price >=10000 AND price <=20000;

SELECT *
  FROM Book
 WHERE price BETWEEN 10000 AND 20000;

-- ���ǻ簡 �½������� ���ѹ̵���� ������ �˻��Ͻÿ�.
SELECT *
  FROM Book
 WHERE publisher IN ('�½�����','���ѹ̵��');

 -- ���ǻ簡 �½������� ���ѹ̵� �ƴ� ������ �˻��Ͻÿ�
 SELECT *
  FROM Book
 WHERE publisher NOT IN ('�½�����','���ѹ̵��');

 -- �౸�� ���縦 ������ ���ǻ縦 �˻��Ͻÿ�.
 SELECT bookname, publisher
   FROM Book
  WHERE bookname = '�౸�� ����';

-- ���� �̸� �߿� �౸�� ���Ե� ���ǻ縦 �˻��Ͻÿ�
 SELECT bookname, publisher
   FROM Book
  WHERE bookname LIKE '�౸%'; -- �౸��� ���ڷ� �����ϴ�

 SELECT bookname, publisher
   FROM Book
  WHERE bookname LIKE '%�౸'; -- �౸��� ���ڷ� ������

 SELECT bookname, publisher
   FROM Book
  WHERE bookname LIKE '%�౸%'; -- �౸��� ���ڰ� ����ִ�

-- �α��ڿ� ���� ������ �ܾ�� ���۵Ǵ� å�̸��� ���� å�̸��� ���ǻ縦 �˻��Ͻÿ�
 SELECT bookname, publisher
   FROM Book
  WHERE bookname LIKE '_��%'; -- _(�������ڵ� �ѱ��ڰ� ��) '��'�� �ι�° ������ 