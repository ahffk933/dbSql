SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod_gu;

SELECT *
FROM prod;
SELECT *
FROM lprod;

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod, buyer
WHERE buyer.buyer_id = prod.prod_buyer;

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE prod.prod_id = cart.cart_prod
AND member.mem_id = cart.cart_member;

--4
SELECT *
FROM customer;

SELECT *
FROM cycle;

SELECT customer.cid, cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
AND (customer.cnm = 'brown' OR customer.cnm = 'sally');


--5
SELECT *
FROM product;

SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM customer, cycle, product
WHERE (customer.cnm = 'brown' OR customer.cnm = 'sally')
AND customer.cid = cycle.cid AND cycle.pid = product.pid;

--6
SELECT customer.cid, cnm, product.pid, pnm, SUM(cnt)sum_cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND cycle.pid = product.pid
GROUP BY customer.cid, cnm, product.pid, pnm
ORDER BY cid, pid;

SELECT a.cid, customer.cnm, a.pid, product.pnm, a.cnt
FROM
    (SELECT cid, pid, SUM(cnt) cnt
    FROM cycle  
    GROUP BY ((cid, pid a) , customer, product)
WHERE a.cid = customer.cid
AND a.pid = product.pid;

--7
SELECT product.pid, pnm, SUM(cnt)sum_cnt
FROM cycle, product
WHERE product.pid = cycle.pid
GROUP BY product.pid, pnm;