-- CREATE INDEX, RUN IT FIRST
CREATE INDEX IF NOT EXISTS idx_price_product ON product (price);
CREATE INDEX IF NOT EXISTS idx_product_id_price ON product (id, price);
CREATE INDEX IF NOT EXISTS idx_product_id ON product (id);
CREATE INDEX IF NOT EXISTS idx_userId_orders ON orders (userId);
CREATE INDEX IF NOT EXISTS idx_product_category_categoryID ON product_category (categoryID);
CREATE INDEX IF NOT EXISTS idx_product_category_productID ON product_category (productID);
CREATE INDEX IF NOT EXISTS idx_orderItem_productID ON orderItem (productID);
CREATE INDEX IF NOT EXISTS idx_category_id ON category (id);

-- DROP INDEX, DON'T RUN IT
-- Drop index from the `product` table
DROP INDEX IF EXISTS idx_price_product ON product;
DROP INDEX IF EXISTS idx_product_id_price ON product;
DROP INDEX IF EXISTS idx_product_id ON product;

-- Drop index from the `orders` table
DROP INDEX IF EXISTS idx_userId_orders ON orders;

-- Drop indexes from the `product_category` table
DROP INDEX IF EXISTS idx_product_category_categoryID ON product_category;
DROP INDEX IF EXISTS idx_product_category_productID ON product_category;

-- Drop index from the `orderItem` table
DROP INDEX IF EXISTS idx_orderItem_productID ON orderItem;

-- Drop index from the `category` table
DROP INDEX IF EXISTS idx_category_id ON category;



-- TEST QUERY
-- select something from product
-- non optimized
SELECT id, name, color, price FROM product
IGNORE INDEX (idx_price_product, PRIMARY, idx_product_id_price, idx_product_id)
WHERE price BETWEEN 5000000 AND 8000000

-- optimized
SELECT id, name, color, price
FROM product
WHERE price
BETWEEN 5000000 AND 8000000
ORDER BY price ASC

-- Sum of subTotal of each user
-- non optimized
SELECT u.id, u.name, SUM(o.subTotal) AS total_subTotal
FROM orders o
IGNORE INDEX (idx_userId_orders, PRIMARY)
JOIN user u IGNORE INDEX (PRIMARY)
ON o.userId = u.id
GROUP BY u.id, u.name;

-- optimized (using hash join)
SELECT u.id, u.name, t.total_subTotal
FROM user u
JOIN (
    SELECT o.userId, SUM(o.subTotal) AS total_subTotal
    FROM orders o
    GROUP BY o.userId
    HAVING COUNT(*) > 0
) t ON t.userId = u.id;

-- select category and total price of each category
-- not using index
SELECT c.title, SUM(p.price) AS total_price
FROM category c IGNORE INDEX (idx_category_id, PRIMARY)
JOIN (product_category pc IGNORE INDEX (idx_product_category_categoryID, idx_product_category_productID, PRIMARY))  ON c.id = pc.categoryID
JOIN (product p IGNORE INDEX (idx_price_product, PRIMARY, idx_product_id_price, idx_product_id)) ON pc.productID = p.id
JOIN (orderItem oi IGNORE INDEX (idx_orderItem_productID, PRIMARY)) ON oi.productID = p.id
GROUP BY c.title;

-- using index
SELECT c.title, SUM(p.price) AS total_price
FROM category c
JOIN product_category pc ON c.id = pc.categoryID
JOIN product p ON pc.productID = p.id
JOIN orderItem oi ON oi.productID = p.id
GROUP BY c.title;

-- select category and total product by each category
-- not using index
SELECT c.title, COUNT(p.id) AS total_products
FROM category c IGNORE INDEX (idx_category_id, PRIMARY)
LEFT JOIN (product_category pc IGNORE INDEX (idx_product_category_categoryID, idx_product_category_productID, PRIMARY)) ON c.id = pc.categoryID
LEFT JOIN (product p IGNORE INDEX (idx_price_product, PRIMARY, idx_product_id_price, idx_product_id)) ON pc.productID = p.id
GROUP BY c.title;

--using index
SELECT c.title, COUNT(p.id) AS total_products
FROM category c
LEFT JOIN product_category pc ON c.id = pc.categoryID
LEFT JOIN product p ON pc.productID = p.id
GROUP BY c.title;



