--create index, chạy cái này trước
CREATE INDEX idx_product_id ON `product`(id);
CREATE INDEX idx_product_category ON `product_category`(productID, categoryID);
CREATE INDEX idx_manufacturer ON `product`(manufacturer);
CREATE INDEX idx_product_name ON `product`(name);
CREATE INDEX idx_price ON `product`(price);


--create procedure, chịu khó chạy từng cái
CREATE PROCEDURE `GetAllProducts`()
BEGIN
    SELECT * FROM product;
END;

CREATE PROCEDURE `GetProductById`(IN productId INT)
BEGIN
    SELECT * FROM `product` USE INDEX(idx_product_id)
    WHERE product.id = productId
    LIMIT 1;
END;

CREATE PROCEDURE `GetProductsByCategory`(IN categoryId INT)
BEGIN
    SELECT p.* FROM `product` p 
    JOIN `product_category` pc ON p.id = pc.productID 
    WHERE pc.categoryID = categoryId
    ORDER BY p.id DESC;
END;

CREATE PROCEDURE `GetProductsByManufacturer`(IN manufacturerName VARCHAR(100))
BEGIN
    SELECT * FROM `product` USE INDEX (idx_manufacturer)
    WHERE manufacturer = manufacturerName;
END;

CREATE PROCEDURE `GetProductsByName`(IN productName VARCHAR(100))
BEGIN
    SELECT * FROM `product` USE INDEX (idx_product_name)
    WHERE name = productName;
END;

CREATE PROCEDURE `GetProductsByPriceRange`(IN minPrice INT, IN maxPrice INT)
BEGIN
    SELECT * FROM `product`
    WHERE price BETWEEN minPrice AND maxPrice;
END;

CREATE PROCEDURE `GetProductsByCategoryAndPrice`(IN categoryId INT, IN minPrice INT, IN maxPrice INT)
BEGIN
    SELECT p.* FROM product p 
    JOIN product_category pc ON p.id = pc.productID 
    WHERE pc.categoryID = categoryId AND p.price BETWEEN minPrice AND maxPrice
    ORDER BY p.id DESC;
END;

CREATE PROCEDURE `GetAllCustomers`()
BEGIN
    SELECT * FROM `user`
    WHERE user.isAdmin = 0;
END;

CREATE PROCEDURE `GetAllOrders`()
BEGIN
    SELECT * FROM `order`;
END;

CREATE PROCEDURE `GetOrderByUser`(IN UserId INT)
BEGIN
    SELECT * FROM `order`
    WHERE userId = UserId;
END;

CREATE PROCEDURE `SumOrderTotalByUser`(IN UserId INT)
BEGIN
    SELECT SUM(subTotal) FROM `order`
    WHERE userId = UserId;
END;



