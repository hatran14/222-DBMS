-- Create a keyspace
DROP KEYSPACE IF EXISTS store;
CREATE KEYSPACE IF NOT EXISTS store WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };
Use store;


CREATE TABLE IF NOT EXISTS product (
    id int PRIMARY KEY,
    name text,
    color text,
    salePercent int,
    price int,
    manufacturer text,
    html text,
    image text
);

CREATE TABLE IF NOT EXISTS category (
    id int PRIMARY KEY,
    title text,
    content text
);

CREATE TABLE IF NOT EXISTS product_category (
    productID int,
    categoryID int,
    PRIMARY KEY (productID, categoryID)
);

CREATE TABLE IF NOT EXISTS user (
    id int PRIMARY KEY,
    name text,
    mobile text,
    email text,
    hashedPassword text,
    registeredAt timestamp,
    lastLogin timestamp,
    passwordChangedAt timestamp,
    isAdmin boolean,
    avatar text
);

CREATE TABLE IF NOT EXISTS orders (
    id int PRIMARY KEY,
    userId int,
    sessionId text,
    tokens text,
    status text,
    tax float,
    subTotal float,
    voucherId int,
    shippingId int,
    note text
);

CREATE TABLE IF NOT EXISTS orderItem (
    id int PRIMARY KEY,
    productID int,
    orderID int,
    discount float,
    quantity int,
    price float
);

CREATE TABLE IF NOT EXISTS voucher (
    id int PRIMARY KEY,
    code text,
    discountPercent float,
    promo text,
    condition text
);

CREATE TABLE IF NOT EXISTS voucher_user (
    voucherId int,
    userId int,
    startDate timestamp,
    expiredDate timestamp,
    PRIMARY KEY (voucherId, userId)
);

CREATE TABLE IF NOT EXISTS shippingInfo (
    id int,
    userId int,
    phone text,
    address text,
    city text,
    country text,
    PRIMARY KEY (id, userId)
);

CREATE TABLE IF NOT EXISTS transaction (
    id int PRIMARY KEY,
    userId int,
    orderId int,
    code text,
    type text,
    status int,
    createdAt timestamp,
    updatedAt timestamp
);

CREATE TABLE IF NOT EXISTS cart (
    id INT,
    user_id INT,
    PRIMARY KEY(id, user_id)
);

CREATE TABLE IF NOT EXISTS cart_product (
    product_id INT,
    cart_id INT,
    quantity INT,
    PRIMARY KEY(product_id, cart_id)
);

CREATE TABLE IF NOT EXISTS attributes (
  id int PRIMARY KEY,
  name text,
  group_name text
);

CREATE TABLE IF NOT EXISTS attribute_value (
  id int PRIMARY KEY,
  id_attribute int,
  value text,
  product_id int
);

CREATE TABLE IF NOT EXISTS review (
  id int PRIMARY KEY,
  product_id int,
  user_id int,
  star int,
  date timestamp,
  content text
);

INSERT INTO category (id, title) VALUES (1, 'Điện thoại');
INSERT INTO category (id, title) VALUES (2, 'Laptop');
INSERT INTO category (id, title) VALUES (3, 'Máy tính bảng');
INSERT INTO category (id, title) VALUES (4, 'Đồng hồ');
    

BEGIN BATCH
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(1, 'iPhone 13 128GB', 'Hồng', 20, 24990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/4/14_1_9_2_9.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(2, 'iPhone 13 128GB', 'Đen', 20, 24990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/2/12_3_8_2_8.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(3, 'iPhone 13 128GB', 'Xanh', 20, 24990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/n/xnnah_kas_3.png');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(4, 'iPhone 13 128GB', 'Trắng', 20, 24990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/r/tr_ng_5.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(5, 'iPhone 13 128GB', 'Đỏ', 20, 24990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/3/13_4_7_2_7.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(6, 'iPhone 13 128GB', 'Xanh dương', 20, 24990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/d/_/d_ng_3.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(7, 'iPhone 13 256GB', 'Hồng', 20, 27990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/4/14_1_9_2_9.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(8, 'iPhone 13 256GB', 'Đen', 20, 27990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/2/12_3_8_2_8.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(9, 'iPhone 13 256GB', 'Xanh', 20, 27990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/n/xnnah_kas_3.png');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(10, 'iPhone 13 256GB', 'Trắng', 20, 27990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/r/tr_ng_5.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(11, 'iPhone 13 256GB', 'Đỏ', 20, 27990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/3/13_4_7_2_7.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(12, 'iPhone 13 256GB', 'Xanh dương', 20, 27990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/d/_/d_ng_3.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(13, 'Apple MacBook Air M1 256GB 2020', 'Trắng', 30, 28990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x358,webp, q100/media/catalog/product/a/i/air_m2.png');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(14, 'Laptop HP Gaming Victus 15-FA0031DX 6503849', 'Đen', 20, 22990000, 'Hp', '', 'https://cdn2.cellphones.com.vn/358x358, webp,q100/media/catalog/product/l/a/laptop-hp-gaming-victus-15-fa0031dx-6503849-6.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(15, 'Laptop Dell Inspiron 3511 5829BLK', 'Đen', 10, 15990000, 'Dell', '', 'https://cdn2.cellphones.com.vn/358x358,webp,q100 /media/catalog/product/t/e/text_ng_n_3__1_71.png');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(16, 'Máy tính xách tay Asus Gaming Rog Strix G15 G513IH HN015W', 'Đen', 20, 23990000, 'Asus', '', 'https://cdn2.cellphones.com.vn/358x358, webp,q100/media/catalog/product/4/h/4h43.png');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(17, 'Laptop Lenovo Ideapad Gaming 3 15ARH7', 'Đen', 20, 25490000, 'Lenevo', '', 'https://cdn2.cellphones.com.vn/358x358,webp, q100/media/catalog/product/1/h/1h47.png');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(18, 'Laptop Lenovo Ideapad Gaming 3 15ARH7', 'Đen', 20, 25490000, 'Lenevo', '', 'https://cdn2.cellphones.com.vn/358x358,webp, q100/media/catalog/product/1/h/1h47.png');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(19, 'iPad 120 2021 WiFi 64GB', 'Silver', 20, 10990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x358,webp,q100 /media/catalog/product/i/p/ipad-10-2-2021-2_6_1.png');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(20, 'iPad Air 5 (2022) 64GB', 'Xanh dương', 10, 16990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x358,webp ,q100/media/catalog/product/9/_/9_10_71_1_1.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(21, 'Samsung Galaxy Tab S8 WIFI', 'Xám', 30, 17990000, 'Samsung', '', 'https://cdn2.cellphones.com.vn/358x358,webp,q100 /media/catalog/product/t/a/tab_s8_2.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(22, 'Samsung Galaxy Tab S8 Ultra 5G', 'Xám', 20, 30990000, 'Samsung', '', 'https://cdn2.cellphones.com.vn/358x358,webp, q100/media/catalog/product/t/a/tab_s8_ultra.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(23, 'Xiaomi Pad 5 (6GB/256GB)', 'Xám', 10, 10490000, 'Xiaomi', '', 'https://cdn2.cellphones.com.vn/358x358, webp,q100/media/catalog/product/o/1/o1cn01ijop4f1slqk1fdzto_-2201438992231_1628774717_2.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(24, 'Redmi Pad 3GB 64GB', 'Đen', 0, 6290000, 'Xiaomi', '', 'https://cdn2.cellphones.com.vn/358x358,webp,q100/ media/catalog/product/1/w/1w2kuj.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(25, 'Đồng hồ thông minh Amazfit GTS 4 Mini', 'Đen', 0, 2590000, 'Amazfit', '', 'https://cdn2.cellphones.com.vn/358x358, webp,q100/media/catalog/product/g/t/gts-2.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(26, 'Đồng hồ thông minh Amazfit GTS 4 Mini', 'Trắng', 0, 2590000, 'Amazfit', '', 'https://cdn2.cellphones.com.vn/358x358, webp,q100/media/catalog/product/g/t/gts-2.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(27, 'Apple Watch SE 2022 40mm', 'Sliver', 15, 7490000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x358,webp,q100 /media/catalog/product/w/a/watch-se.jpg');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(28, 'Samsung Galaxy S23 Ultra 256GB', 'Đen', 20, 41990990, 'Samsung', '', 'https://cdn2.cellphones.com.vn/358x358,webp,q100 /media/catalog/product/s/2/s23-ultra-tim.png');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(29, 'Samsung Galaxy A34 5G 8GB 128GB', 'Đen', 10, 8490000, 'Samsung', '', 'https://cdn2.cellphones.com.vn/358x358,webp, q100/media/catalog/product/s/m/sm-a346_galaxy_a34_5g_awesome_silver_front.png');
    INSERT INTO product (id, name, color, salePercent, price, manufacturer, html, image) VALUES(30, 'Xiaomi Redmi Note 11 128GB', 'Đen', 10, 4990000, 'Xiaomi', 'HFHRY43.html', 'https://cdn2.cellphones.com.vn/358x358, webp,q100/media/catalog/product/8/0/800x800-640x640-5.png');
APPLY BATCH;

BEGIN BATCH
    INSERT INTO product_category (productID, categoryID) VALUES (1, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (2, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (3, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (4, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (5, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (6, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (7, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (8, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (9, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (10, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (11, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (12, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (13, 2);
    INSERT INTO product_category (productID, categoryID) VALUES (14, 2);
    INSERT INTO product_category (productID, categoryID) VALUES (15, 2);
    INSERT INTO product_category (productID, categoryID) VALUES (16, 2);
    INSERT INTO product_category (productID, categoryID) VALUES (17, 2);
    INSERT INTO product_category (productID, categoryID) VALUES (18, 2);
    INSERT INTO product_category (productID, categoryID) VALUES (19, 3);
    INSERT INTO product_category (productID, categoryID) VALUES (20, 3);
    INSERT INTO product_category (productID, categoryID) VALUES (21, 3);
    INSERT INTO product_category (productID, categoryID) VALUES (22, 3);
    INSERT INTO product_category (productID, categoryID) VALUES (23, 3);
    INSERT INTO product_category (productID, categoryID) VALUES (24, 3);
    INSERT INTO product_category (productID, categoryID) VALUES (25, 4);
    INSERT INTO product_category (productID, categoryID) VALUES (26, 4);
    INSERT INTO product_category (productID, categoryID) VALUES (27, 4);
    INSERT INTO product_category (productID, categoryID) VALUES (28, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (29, 1);
    INSERT INTO product_category (productID, categoryID) VALUES (30, 1);
APPLY BATCH;

BEGIN BATCH
    INSERT INTO attributes (id, name, group_name) VALUES (1, 'Dung lượng Ram', 'Ram & lưu trữ');
    INSERT INTO attributes (id, name, group_name) VALUES (2, 'Bộ nhớ trong', 'Ram & lưu trữ');
    INSERT INTO attributes (id, name, group_name) VALUES (3, 'Kích thước màn hình', 'Màn hình');
    INSERT INTO attributes (id, name, group_name) VALUES (4, 'Công nghệ màn hình', 'Màn hình');
    INSERT INTO attributes (id, name, group_name) VALUES (5, 'Độ phân giải màn hình', 'Màn hình');
    INSERT INTO attributes (id, name, group_name) VALUES (6, 'Tính năng màn hình', 'Màn hình');
    INSERT INTO attributes (id, name, group_name) VALUES (7, 'Tần số quét', 'Màn hình');
    INSERT INTO attributes (id, name, group_name) VALUES (8, 'Camera sau', 'Camera sau');
    INSERT INTO attributes (id, name, group_name) VALUES (9, 'Quay video', 'Camera sau');
    INSERT INTO attributes (id, name, group_name) VALUES (10, 'Tính năng camera', 'Camera sau');
    INSERT INTO attributes (id, name, group_name) VALUES (11, 'Camera trước', 'Camera trước');
    INSERT INTO attributes (id, name, group_name) VALUES (12, 'Quay video trước', 'Camera trước');
    INSERT INTO attributes (id, name, group_name) VALUES (13, 'Chipset', 'Vi xử lý & đồ họa ');
    INSERT INTO attributes (id, name, group_name) VALUES (14, 'Loại CPU', 'Vi xử lý & đồ họa ');
    INSERT INTO attributes (id, name, group_name) VALUES (15, 'GPU', 'Vi xử lý & đồ họa ');
    INSERT INTO attributes (id, name, group_name) VALUES (16, 'Pin', 'Pin & công nghệ sạc');
    INSERT INTO attributes (id, name, group_name) VALUES (17, 'Công nghệ sạc', 'Pin & công nghệ sạc');
    INSERT INTO attributes (id, name, group_name) VALUES (18, 'Cổng sạc', 'Pin & công nghệ sạc');
    INSERT INTO attributes (id, name, group_name) VALUES (19, 'Thẻ SIM', 'Giao tiếp & kết nối');
    INSERT INTO attributes (id, name, group_name) VALUES (20, 'Hệ điều hành', 'Giao tiếp & kết nối');
    INSERT INTO attributes (id, name, group_name) VALUES (21, 'Công nghệ NFC', 'Giao tiếp & kết nối');
    INSERT INTO attributes (id, name, group_name) VALUES (22, 'Hỗ trợ mạng', 'Giao tiếp & kết nối');
    INSERT INTO attributes (id, name, group_name) VALUES (23, 'Wi-Fi', 'Giao tiếp & kết nối');
    INSERT INTO attributes (id, name, group_name) VALUES (24, 'Bluetooth', 'Giao tiếp & kết nối');
    INSERT INTO attributes (id, name, group_name) VALUES (25, 'GPS', 'Giao tiếp & kết nối');
    INSERT INTO attributes (id, name, group_name) VALUES (26, 'Kích thước', 'Thiết kế & Trọng lượng');
    INSERT INTO attributes (id, name, group_name) VALUES (27, 'Trọng lượng', 'Thiết kế & Trọng lượng');
    INSERT INTO attributes (id, name, group_name) VALUES (28, 'Chất liệu mặt lưng', 'Thiết kế & Trọng lượng');
    INSERT INTO attributes (id, name, group_name) VALUES (29, 'Tương thích', 'Thông số khác');
    INSERT INTO attributes (id, name, group_name) VALUES (30, 'Chỉ số kháng nước, bụi', 'Thông số khác');
    INSERT INTO attributes (id, name, group_name) VALUES (31, 'Tiện ích khác', 'Thông số khác');
    INSERT INTO attributes (id, name, group_name) VALUES (32, 'Kiểu màn hình', 'Thông số khác');
    INSERT INTO attributes (id, name, group_name) VALUES (33, 'Cảm biến vân tay', 'Tiện ích khác');
    INSERT INTO attributes (id, name, group_name) VALUES (34, 'Các loại cảm biến', 'Tiện ích khác');
    INSERT INTO attributes (id, name, group_name) VALUES (35, 'Tính năng đặc biệt', 'Tiện ích khác');
    INSERT INTO attributes (id, name, group_name) VALUES (36, 'Chất liệu mặt kính', 'Thiết kế & Trọng lượng');
    INSERT INTO attributes (id, name, group_name) VALUES (37, 'Hình ảnh', 'Hình ảnh');
    INSERT INTO attributes (id, name, group_name) VALUES (38, 'Loại card đồ họa', 'Vi xử lý & đồ họa');
    INSERT INTO attributes (id, name, group_name) VALUES (39, 'Ổ cứng', 'Ram & lưu trữ');
    INSERT INTO attributes (id, name, group_name) VALUES (40, 'Loại RAM', 'Ram & lưu trữ');
    INSERT INTO attributes (id, name, group_name) VALUES (41, 'Chất liệu', 'Thông số khác');
    INSERT INTO attributes (id, name, group_name) VALUES (42, 'Màn hình cảm ứng', 'Màn hình');
    INSERT INTO attributes (id, name, group_name) VALUES (43, 'Chất lượng tấm nền', 'Màn hình');
    INSERT INTO attributes (id, name, group_name) VALUES (44, 'Công nghệ âm thanh', 'Công nghệ âm thanh');
    INSERT INTO attributes (id, name, group_name) VALUES (45, 'Khe đọc thẻ nhớ', 'Giao tiếp & kết nối');
    INSERT INTO attributes (id, name, group_name) VALUES (47, 'Cổng giao tiếp', 'Thông số kỹ thuật');
    INSERT INTO attributes (id, name, group_name) VALUES (48, 'Jack tai nghe 3.5', 'Giao tiếp & kết nối');
    INSERT INTO attributes (id, name, group_name) VALUES (49, 'Chất liệu khung viền', 'Thiết kế & Trọng lượng');
    INSERT INTO attributes (id, name, group_name) VALUES (50, 'Chống nước', 'Thông số khác');
    INSERT INTO attributes (id, name, group_name) VALUES (51, 'Tiện ích sức khoẻ', 'Thông số khác');
    INSERT INTO attributes (id, name, group_name) VALUES (52, 'Thời lượng pin', 'Pin & công nghệ sạc');
    INSERT INTO attributes (id, name, group_name) VALUES (53, 'Tính năng thông minh', 'Tính năng nổi bật');
    INSERT INTO attributes (id, name, group_name) VALUES (54, 'Chất liệu viền', 'Chất liệu mặt & Dây');
    INSERT INTO attributes (id, name, group_name) VALUES (55, 'Chất liệu dây', 'Chất liệu mặt & Dây');
APPLY BATCH;

BEGIN BATCH
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (1, 1, '6 GB', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (2, 2, '128 GB', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (3, 3, '6.9 inches', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (4, 8, 'Camera góc rộng: 12MP, f/1.6\nCamera góc siêu rộng: 12MP, ƒ/2.4', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (5, 5, '2532 x 1170 pixels', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (6, 6, 'Màn hình super Retina XDR, OLED, 460 ppi, HDR display, công nghệ True Tone Wide color (P3); Haptic Touch, Lớp phủ oleophobic chống bám vân tay', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (7, 7, '60Hz', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (13, 9, '4K 2160p@30fps\r\nFullHD 1080p@30fps\r\nFullHD 1080p@60fps\r\nHD 720p@30fps', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (14, 10, 'Chạm lấy nét\r\nHDR\r\nNhận diện khuôn mặt\r\nQuay chậm (Slow Motion)\r\nToàn cảnh (Panorama)\r\nTự động lấy nét (AF)\r\nXóa phông\r\nNhãn dán (AR Stickers)\r\nNhận diện khuôn mặt', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (15, 11, '12MP, f/2.2', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (16, 13, 'Apple A15', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (17, 16, '3.240mAh', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (18, 17, 'Sạc nhanh 20W, Sạc không dây, Sạc ngược không dây 15W, Sạc pin nhanh, Tiết kiệm pin', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (19, 18, 'Lightning', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (20, 20, 'iOS 15', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (21, 48, 'Không', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (22, 21, 'Có', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (23, 22, '5G', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (24, 23, 'Wi‑Fi 6 (802.11ax)', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (25, 24, 'v5.0', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (26, 15, 'GPS, GLONASS, Galileo, QZSS, and BeiDou', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (27, 26, '146,7 x 71,5 x 7,65mm', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (28, 27, '174g', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (29, 36, 'Kính', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (30, 49, 'Kim loại', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (31, 32, 'Tai thỏ', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (32, 35, 'Hỗ trợ 5G, Sạc không dây, Nhận diện khuôn mặt, Kháng nước, kháng bụi', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (33, 37, '1_main.png', 1);
    INSERT INTO attribute_value (id, id_attribute, value, product_id) VALUES (34, 37, '1_43534534.png', 1);
APPLY BATCH;

BEGIN BATCH
    INSERT INTO user (id, name, mobile, email, hashedPassword, registeredAt, lastLogin, passwordChangedAt, isAdmin, avatar) VALUES (1,'Mr. Furman Osinski III','788-256-5364','bmccullough@example.org','12e5823aba90c366c5b9a1f31f196873a1894fd4','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',false,'');
    INSERT INTO user (id, name, mobile, email, hashedPassword, registeredAt, lastLogin, passwordChangedAt, isAdmin, avatar) VALUES (2,'Edwin Sauer','02919605425','ernie25@example.com','4f46065f82e6c6d4ed4a84d90bf15c4312de5102','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',false,'');
    INSERT INTO user (id, name, mobile, email, hashedPassword, registeredAt, lastLogin, passwordChangedAt, isAdmin, avatar) VALUES (3,'Mollie Ruecker','1-959-199-9780x65777','sylvan91@example.net','0b1d85e63d449229e9d47f05f28d28fef180b609','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',false,'');
    INSERT INTO user (id, name, mobile, email, hashedPassword, registeredAt, lastLogin, passwordChangedAt, isAdmin, avatar) VALUES (4,'Dr. Cecil Bradtke','1-549-549-8451x6841','josiah92@example.com','242cc95244f46dda331468bdfa0878832dfcdee2','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',false,'');
    INSERT INTO user (id, name, mobile, email, hashedPassword, registeredAt, lastLogin, passwordChangedAt, isAdmin, avatar) VALUES (5,'Everett Streich','611.269.4340x44844','margie.schiller@example.org','e66215ec5666cba978c4e5af08f4480eff29f3d0','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',false,'');
    INSERT INTO user (id, name, mobile, email, hashedPassword, registeredAt, lastLogin, passwordChangedAt, isAdmin, avatar) VALUES (6,'Jerad White','+72(8)5710147485','roob.jaeden@example.net','b6af02a57d427628914f9a7e53c2ea690bc1db6e','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',false,'');
    INSERT INTO user (id, name, mobile, email, hashedPassword, registeredAt, lastLogin, passwordChangedAt, isAdmin, avatar) VALUES (7,'Dr. Nicklaus Koss','1-117-318-6496x89063','hchristiansen@example.org','52d815835d3499c2d095a968b22fa3f52763b5ab','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',false,'');
    INSERT INTO user (id, name, mobile, email, hashedPassword, registeredAt, lastLogin, passwordChangedAt, isAdmin, avatar) VALUES (8,'Misael Spinka','(438)000-3486','jake.rippin@example.com','a20de43b8a04d1702c94a213dd4f4dad57d8c640','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',false,'');
    INSERT INTO user (id, name, mobile, email, hashedPassword, registeredAt, lastLogin, passwordChangedAt, isAdmin, avatar) VALUES (9,'Boyd Heaney','07645367153','mariana34@example.org','dd22b3f288f337789af2d6058dc75ca0d752a073','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',false,'');
    INSERT INTO user (id, name, mobile, email, hashedPassword, registeredAt, lastLogin, passwordChangedAt, isAdmin, avatar) VALUES (10,'Dr. Eliezer Barrows','02143673376','hegmann.angeline@example.org','0b3bf810d3a2e46e6e9435524ca80b73c016c88a','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',false,'');
APPLY BATCH;

BEGIN BATCH
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (1,8,'bd987bb96709df6ee0f5','','Đã giao',0,40100000,NULL,0,'Aperiam quia omnis mollitia repellendus repudiandae tempore esse. Non sequi tempora eum tempora. Ull');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (2,3,'b1fd47bc3e97cb919a8a','','Đã thanh toán',0,20300000,NULL,0,'Mollitia a odio architecto ab et. Repellendus soluta a libero fugiat aperiam. Sit iusto quod sed com');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (3,8,'ea50706c465101a2ecc2','','Đã thanh toán',0,6900000,NULL,0,'Sed voluptatibus magnam ad quasi dolore cumque. Itaque quis deserunt itaque expedita facilis. Quisqu');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (4,3,'7a338445ee477527311d','','Chờ thanh toán',0,26100000,NULL,0,'Aut ut modi in aliquam. Voluptatem quia odio similique laboriosam ab amet aut facere. Dolores reicie');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (5,2,'691b74b099ccce5032ff','','Đã hủy',0,35400000,NULL,0,'Explicabo officia voluptas praesentium quibusdam. Aspernatur exercitationem voluptate aliquam soluta');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (6,3,'5e5d1173c5db96f10ca5','','Chờ lấy hàng',0,44100000,NULL,0,'Non totam repellendus officia. Possimus recusandae quibusdam ea qui qui velit. Eveniet asperiores do');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (7,10,'9a659e6a7005ec12dc3a','','Chờ lấy hàng',0,10900000,NULL,0,'Vero dolor qui quae molestiae qui ullam. Laudantium culpa reprehenderit voluptate fugiat qui modi do');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (8,5,'9996bace5d45712269a9','','Chờ lấy hàng',0,22600000,NULL,0,'Adipisci inventore blanditiis itaque eligendi. Odit perspiciatis aperiam expedita qui velit expedita');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (9,3,'e091f279d2b6a1724cbe','','Đã thanh toán',0,29900000,NULL,0,'Iste qui tempore neque voluptas ut voluptates. Adipisci quia tenetur earum necessitatibus aliquid pr');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (10,4,'f4f17a25b8de1ae4290b','','Chờ lấy hàng',0,39300000,NULL,0,'Aut natus et natus fugit quod voluptatum numquam sit. Eos iste quas nihil pariatur aut. Libero tempo');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (11,6,'d00dedab951f1fb9bbfb','','Chờ thanh toán',0,43800000,NULL,0,'Quis hic assumenda est voluptas alias. Porro voluptas incidunt assumenda. Ex molestias ipsa dolorem ');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (12,10,'d7e7c834e4df6ffd2f8a','','Đang giao',0,26700000,NULL,0,'Et aut aspernatur id consequatur. Dicta rerum ut non illum eveniet velit inventore.');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (13,5,'96e95776bfbcaccc47aa','','Đã thanh toán',0,23900000,NULL,0,'Architecto iste consequatur et in qui voluptatum. Ratione voluptatem autem quia ea omnis sequi labor');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (14,6,'12c07a08cb8f29439aba','','Đã giao',0,29400000,NULL,0,'Aliquid neque est veniam labore. Aliquam necessitatibus voluptatem maiores excepturi sit dicta. Saep');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (15,9,'34cad6231eea3e20eae8','','Chờ lấy hàng',0,18800000,NULL,0,'Fugit ducimus autem ut consequatur nobis. Dignissimos excepturi ipsum hic possimus. Et libero perspi');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (16,4,'762ca432a1cff6c15da2','','Đang giao',0,15600000,NULL,0,'Rerum quas id sed perspiciatis. Eaque consequatur eum voluptas et delectus velit. Tempora delectus m');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (17,1,'93582d770b028f812356','','Chờ thanh toán',0,43100000,NULL,0,'Reprehenderit ratione perferendis at aut pariatur repellendus molestias. Aut in eum dolores optio qu');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (18,7,'c53975de402381aed631','','Chờ lấy hàng',0,18400000,NULL,0,'Debitis rerum distinctio velit harum deserunt. Voluptatum veniam omnis necessitatibus optio. Volupta');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (19,9,'9387349c48f5d02a92ae','','Đã hủy',0,28100000,NULL,0,'Mollitia voluptatibus tenetur facere non accusantium. Repellendus mollitia esse recusandae incidunt.');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (20,9,'3415057d26c90e6614e3','','Chờ lấy hàng',0,27700000,NULL,0,'Dolorem et reiciendis ratione natus amet. Magni sed in voluptate corrupti tenetur ducimus quibusdam ');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (21,4,'acb77a0aa57c2b7a094b','','Đã thanh toán',0,38100000,NULL,0,'Eaque ipsum sint et qui laudantium quia. Quae aut magni consequatur quae aut. Voluptatum sint et del');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (22,6,'b2659ba0c1871709a7b7','','Đã giao',0,19400000,NULL,0,'In pariatur molestiae aut odit. Est iste molestiae minus natus dolorem id. Minus nostrum unde dolore');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (23,10,'b14dc6ac983ba37598eb','','Đã thanh toán',0,6700000,NULL,0,'Iusto temporibus nostrum ullam optio. Illo omnis distinctio laboriosam sint sed voluptatum. Est dolo');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (24,1,'ee89f4c3e3b5e233dc49','','Chờ lấy hàng',0,33600000,NULL,0,'Et voluptatem velit cumque. Nam id ad quis rerum itaque. Placeat molestiae ea laborum quidem.');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (25,4,'5b52a3b0cdd9112b81e0','','Đã thanh toán',0,36000000,NULL,0,'Qui rerum incidunt voluptatem esse. Ad veritatis cumque quos nihil nulla culpa dolorem modi. Ut vel ');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (26,8,'df65336a034294296971','','Đã thanh toán',0,40400000,NULL,0,'Est consequatur omnis ipsam. Aut doloremque placeat sit ut dolorum. Voluptatem tempora explicabo et ');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (27,9,'0ee722c1289faa03b095','','Đã hủy',0,10800000,NULL,0,'Dicta et nostrum ipsa delectus excepturi. Iusto dignissimos voluptates qui id minus. Officia fugiat ');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (28,2,'1f58c13cdb1f7e353ff9','','Đang giao',0,33700000,NULL,0,'Similique iusto sint eum perspiciatis aut. Aut est assumenda reprehenderit quo quasi rerum. Et liber');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (29,1,'36df7510b4c48dee163f','','Đã hủy',0,22000000,NULL,0,'Aliquam et sunt accusantium exercitationem dignissimos omnis. Laudantium nam possimus voluptatibus q');
    INSERT INTO orders (id, userId, sessionId, tokens, status, tax, subTotal, voucherId, shippingId, note) VALUES (30,1,'fa90c6a9bddd89d014cf','','Chờ thanh toán',0,21400000,NULL,0,'Doloribus quia dolorum eligendi velit quasi pariatur. Voluptas dolorem inventore nam eaque iure aut.');
APPLY BATCH;

-- CREATE INDEX product_id_idx ON product (id);
CREATE INDEX product_category_categoryID_idx ON product_category (categoryID);
-- CREATE INDEX idx_product_category ON product_category(productID, categoryID);
CREATE INDEX idx_manufacturer ON product(manufacturer);
CREATE INDEX idx_product_name ON product(name);
CREATE INDEX idx_price ON product(price);