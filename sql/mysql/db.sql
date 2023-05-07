drop database if exists `main_app`;
create database if not exists `main_app`;
use `main_app`;

create table if not exists `product` (
    `id` int not null auto_increment,
    `name` varchar(100) not null,
    `color` varchar(30) not null,
    `salePercent` int not null default 0,
    `price` int not null,
    `manufacturer` varchar(100) not null,
    `html` varchar(100),
    `image` varchar(255),
    primary key(`id`)
);

create table if not exists `category` (
    `id` int not null auto_increment,
    `title` varchar(100) not null,
    `content`  varchar(1000),
    primary key(`id`)
);

create table if not exists `product_category` (
    `productID` int not null,
    `categoryID` int not null,
    primary key (`productID`, `categoryID`),
    foreign key (`productID`) references `product`(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    foreign key (`categoryID`) references `category`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists `user` (
    `id` int not null auto_increment,
    `name` varchar(100) not null,
    `mobile` varchar(20) unique not null,
    `email` varchar(50) unique not null,
    `hashedPassword` varchar(200) not null,
    `registeredAt` datetime not null default CURRENT_TIMESTAMP,
    `lastLogin` datetime not null default CURRENT_TIMESTAMP,
    `passwordChangedAt` datetime not null default CURRENT_TIMESTAMP,
    `isAdmin` tinyint(1) not null default 0,
    `avatar` varchar(100) not null,
    primary key(`id`)
);

create table if not exists `order` (
    `id` int not null auto_increment,
    `userId` int not null,
    `sessionId` varchar(20) not null,
    `token` varchar(20) not null,
    `status` varchar(100) not null,
    `tax` float not null,
    `subTotal` float not null,
    `voucherId` int,
    `shippingId` int not null,
    `note` varchar(100),
    primary key (`id`, `sessionId`),
    foreign key (`userId`) references `user`(`id`)
);
create table if not exists `orderItem` (
    `id` int not null auto_increment,
    `productID` int not null,
    `orderID` int not null,
    `discount` float,
    `quantity` int not null,
    `price` float not null,
    primary key(`id`),
    foreign key (`productID`) references `product`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    foreign key (`orderID`) references `order`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

create table if not exists `voucher` (
    `id` int not null auto_increment,
    `code` varchar(10) not null,
    `discountPercent` float not null,
    `promo` varchar(50),
    `condition` varchar(50),
    primary key(`id`)
);

create table if not exists `voucher_user` (
    `voucherId` int not null,
    `userId` int not null,
    `startDate` datetime not null,
    `expiredDate` datetime,
    CONSTRAINT `check_voucher_date` check (`expiredDate` > `startDate`),
    primary key( `voucherId`, `userId`),
    foreign key(`voucherId`) references `voucher`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (`userId`) references `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

create table if not exists `shippingInfo` (
    `id` int not null auto_increment,
    `userId` int not null,
    `phone` varchar(12) not null,
    `address` varchar(40) not null,
    `city` varchar(20) not null,
    `country` varchar(20) not null,
    primary key(`id`, `userId`),
    foreign key (`userId`) references `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

create table if not exists `transaction` (
    `id` int not null auto_increment,
    `userId` int not null,
    `orderId` int not null,
    `code` varchar(10),
    `type` varchar(10) not null,
    `status` int not null,
    `createdAt` datetime not null default CURRENT_TIMESTAMP,
    `updatedAt` datetime not null default CURRENT_TIMESTAMP,
    primary key (`id`, `userId`, `orderId`),
    foreign key (`userId`) references `user`(`id`) ON DELETE NO ACTION,
    foreign key (`orderId`) references `order`(`id`) ON DELETE NO ACTION
);

create table if not exists `cart` (
    `id` int not null auto_increment,
    `userId` int not null,
    primary key(`id`, `userId`),
    foreign key (`userId`) references `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

create table if not exists `cart_product` (
    `productId` int not null,
    `cartId` int not null,
    `quantity` int not null,
    primary key(`productId`, `cartId`),
    foreign key (`productId`) references `product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (`cartId`) references `cart`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

create table if not exists `attributes` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    `group_name` varchar(50) NOT NULL,
    primary key(`id`)
);

create table if not exists `attribute_value` (
    `id` int not null auto_increment,
    `id_attribute` int(11) NOT NULL,
    `value` varchar(200) NOT NULL,
    `productId` int not null,
    primary key(`id`),
    foreign key (`productId`) references `product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (`id_attribute`) references `attributes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

create table if not exists `review` (
    `id` int NOT NULL AUTO_INCREMENT,
    `productId` int NOT NULL,
    `userId` int NOT NULL,
    `star` int NOT NULL,
    `date` datetime NOT NULL default CURRENT_TIMESTAMP,
    `content` varchar(2000) NOT NULL,
    primary key(`id`),
    foreign key (`productId`) references `product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (`userId`) references `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO `category` (`id`, `title`) VALUES ('1', 'Điện thoại');
INSERT INTO `category` (`id`, `title`) VALUES ('2', 'Laptop');
INSERT INTO `category` (`id`, `title`) VALUES ('3', 'Máy tính bảng');
INSERT INTO `category` (`id`, `title`) VALUES ('4', 'Đồng hồ');


INSERT INTO `product` (`id`, `name`, `color`, `salePercent`, `price`, `manufacturer`, `html`, `image`) VALUES
    (1, 'iPhone 13 128GB', 'Hồng', 20, 24990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/4/14_1_9_2_9.jpg'),
    (2, 'iPhone 13 128GB', 'Đen', 20, 24990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/2/12_3_8_2_8.jpg'),
    (3, 'iPhone 13 128GB', 'Xanh', 20, 24990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/n/xnnah_kas_3.png'),
    (4, 'iPhone 13 128GB', 'Trắng', 20, 24990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/r/tr_ng_5.jpg'),
    (5, 'iPhone 13 128GB', 'Đỏ', 20, 24990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/3/13_4_7_2_7.jpg'),
    (6, 'iPhone 13 128GB', 'Xanh dương', 20, 24990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/d/_/d_ng_3.jpg'),
    (7, 'iPhone 13 256GB', 'Hồng', 20, 27990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/4/14_1_9_2_9.jpg'),
    (8, 'iPhone 13 256GB', 'Đen', 20, 27990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/2/12_3_8_2_8.jpg'),
    (9, 'iPhone 13 256GB', 'Xanh', 20, 27990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/n/xnnah_kas_3.png'),
    (10, 'iPhone 13 256GB', 'Trắng', 20, 27990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/r/tr_ng_5.jpg'),
    (11, 'iPhone 13 256GB', 'Đỏ', 20, 27990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/3/13_4_7_2_7.jpg'),
    (12, 'iPhone 13 256GB', 'Xanh dương', 20, 27990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/d/_/d_ng_3.jpg'),
    (13, 'Apple MacBook Air M1 256GB 2020', 'Trắng', 30, 28990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x358,webp, q100/media/catalog/product/a/i/air_m2.png'),
    (14, 'Laptop HP Gaming Victus 15-FA0031DX 6503849', 'Đen', 20, 22990000, 'Hp', '', 'https://cdn2.cellphones.com.vn/358x358, webp,q100/media/catalog/product/l/a/laptop-hp-gaming-victus-15-fa0031dx-6503849-6.jpg'),
    (15, 'Laptop Dell Inspiron 3511 5829BLK', 'Đen', 10, 15990000, 'Dell', '', 'https://cdn2.cellphones.com.vn/358x358,webp,q100 /media/catalog/product/t/e/text_ng_n_3__1_71.png'),
    (16, 'Máy tính xách tay Asus Gaming Rog Strix G15 G513IH HN015W', 'Đen', 20, 23990000, 'Asus', '', 'https://cdn2.cellphones.com.vn/358x358, webp,q100/media/catalog/product/4/h/4h43.png'),
    (17, 'Laptop Lenovo Ideapad Gaming 3 15ARH7', 'Đen', 20, 25490000, 'Lenevo', '', 'https://cdn2.cellphones.com.vn/358x358,webp, q100/media/catalog/product/1/h/1h47.png'),
    (18, 'Laptop Lenovo Ideapad Gaming 3 15ARH7', 'Đen', 20, 25490000, 'Lenevo', '', 'https://cdn2.cellphones.com.vn/358x358,webp, q100/media/catalog/product/1/h/1h47.png'),
    (19, 'iPad 120 2021 WiFi 64GB', 'Silver', 20, 10990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x358,webp,q100 /media/catalog/product/i/p/ipad-10-2-2021-2_6_1.png'),
    (20, 'iPad Air 5 (2022) 64GB', 'Xanh dương', 10, 16990000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x358,webp ,q100/media/catalog/product/9/_/9_10_71_1_1.jpg'),
    (21, 'Samsung Galaxy Tab S8 WIFI', 'Xám', 30, 17990000, 'Samsung', '', 'https://cdn2.cellphones.com.vn/358x358,webp,q100 /media/catalog/product/t/a/tab_s8_2.jpg'),
    (22, 'Samsung Galaxy Tab S8 Ultra 5G', 'Xám', 20, 30990000, 'Samsung', '', 'https://cdn2.cellphones.com.vn/358x358,webp, q100/media/catalog/product/t/a/tab_s8_ultra.jpg'),
    (23, 'Xiaomi Pad 5 (6GB/256GB)', 'Xám', 10, 10490000, 'Xiaomi', '', 'https://cdn2.cellphones.com.vn/358x358, webp,q100/media/catalog/product/o/1/o1cn01ijop4f1slqk1fdzto_-2201438992231_1628774717_2.jpg'),
    (24, 'Redmi Pad 3GB 64GB', 'Đen', 0, 6290000, 'Xiaomi', '', 'https://cdn2.cellphones.com.vn/358x358,webp,q100/ media/catalog/product/1/w/1w2kuj.jpg'),
    (25, 'Đồng hồ thông minh Amazfit GTS 4 Mini', 'Đen', 0, 2590000, 'Amazfit', '', 'https://cdn2.cellphones.com.vn/358x358, webp,q100/media/catalog/product/g/t/gts-2.jpg'),
    (26, 'Đồng hồ thông minh Amazfit GTS 4 Mini', 'Trắng', 0, 2590000, 'Amazfit', '', 'https://cdn2.cellphones.com.vn/358x358, webp,q100/media/catalog/product/g/t/gts-2.jpg'),
    (27, 'Apple Watch SE 2022 40mm', 'Sliver', 15, 7490000, 'Apple', '', 'https://cdn2.cellphones.com.vn/358x358,webp,q100 /media/catalog/product/w/a/watch-se.jpg'),
    (28, 'Samsung Galaxy S23 Ultra 256GB', 'Đen', 20, 41990990, 'Samsung', '', 'https://cdn2.cellphones.com.vn/358x358,webp,q100 /media/catalog/product/s/2/s23-ultra-tim.png'),
    (29, 'Samsung Galaxy A34 5G 8GB 128GB', 'Đen', 10, 8490000, 'Samsung', '', 'https://cdn2.cellphones.com.vn/358x358,webp, q100/media/catalog/product/s/m/sm-a346_galaxy_a34_5g_awesome_silver_front.png'),
    (30, 'Xiaomi Redmi Note 11 128GB', 'Đen', 10, 4990000, 'Xiaomi', 'HFHRY43.html', 'https://cdn2.cellphones.com.vn/358x358, webp,q100/media/catalog/product/8/0/800x800-640x640-5.png');

INSERT INTO `product_category` (`productID`, `categoryID`) VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 1),
    (6, 1),
    (7, 1),
    (8, 1),
    (9, 1),
    (10, 1),
    (11, 1),
    (12, 1),
    (13, 2),
    (14, 2),
    (15, 2),
    (16, 2),
    (17, 2),
    (18, 2),
    (19, 3),
    (20, 3),
    (21, 3),
    (22, 3),
    (23, 3),
    (24, 3),
    (25, 4),
    (26, 4),
    (27, 4),
    (28, 1),
    (29, 1),
    (30, 1);


INSERT INTO `attributes` (`id`, `name`, `group_name`) VALUES
    (1, 'Dung lượng Ram', 'Ram & lưu trữ'),
    (2, 'Bộ nhớ trong', 'Ram & lưu trữ'),
    (3, 'Kích thước màn hình', 'Màn hình'),
    (4, 'Công nghệ màn hình', 'Màn hình'),
    (5, 'Độ phân giải màn hình', 'Màn hình'),
    (6, 'Tính năng màn hình', 'Màn hình'),
    (7, 'Tần số quét', 'Màn hình'),
    (8, 'Camera sau', 'Camera sau'),
    (9, 'Quay video', 'Camera sau'),
    (10, 'Tính năng camera', 'Camera sau'),
    (11, 'Camera trước', 'Camera trước'),
    (12, 'Quay video trước', 'Camera trước'),
    (13, 'Chipset', 'Vi xử lý & đồ họa '),
    (14, 'Loại CPU', 'Vi xử lý & đồ họa '),
    (15, 'GPU', 'Vi xử lý & đồ họa '),
    (16, 'Pin', 'Pin & công nghệ sạc'),
    (17, 'Công nghệ sạc', 'Pin & công nghệ sạc'),
    (18, 'Cổng sạc', 'Pin & công nghệ sạc'),
    (19, 'Thẻ SIM', 'Giao tiếp & kết nối'),
    (20, 'Hệ điều hành', 'Giao tiếp & kết nối'),
    (21, 'Công nghệ NFC', 'Giao tiếp & kết nối'),
    (22, 'Hỗ trợ mạng', 'Giao tiếp & kết nối'),
    (23, 'Wi-Fi', 'Giao tiếp & kết nối'),
    (24, 'Bluetooth', 'Giao tiếp & kết nối'),
    (25, 'GPS', 'Giao tiếp & kết nối'),
    (26, 'Kích thước', 'Thiết kế & Trọng lượng'),
    (27, 'Trọng lượng', 'Thiết kế & Trọng lượng'),
    (28, 'Chất liệu mặt lưng', 'Thiết kế & Trọng lượng'),
    (29, 'Tương thích', 'Thông số khác'),
    (30, 'Chỉ số kháng nước, bụi', 'Thông số khác'),
    (31, 'Tiện ích khác', 'Thông số khác'),
    (32, 'Kiểu màn hình', 'Thông số khác'),
    (33, 'Cảm biến vân tay', 'Tiện ích khác'),
    (34, 'Các loại cảm biến', 'Tiện ích khác'),
    (35, 'Tính năng đặc biệt', 'Tiện ích khác'),
    (36, 'Chất liệu mặt kính', 'Thiết kế & Trọng lượng'),
    (37, 'Hình ảnh', 'Hình ảnh'),
    (38, 'Loại card đồ họa', 'Vi xử lý & đồ họa'),
    (39, 'Ổ cứng', 'Ram & lưu trữ'),
    (40, 'Loại RAM', 'Ram & lưu trữ'),
    (41, 'Chất liệu', 'Thông số khác'),
    (42, 'Màn hình cảm ứng', 'Màn hình'),
    (43, 'Chất lượng tấm nền', 'Màn hình'),
    (44, 'Công nghệ âm thanh', 'Công nghệ âm thanh'),
    (45, 'Khe đọc thẻ nhớ', 'Giao tiếp & kết nối'),
    (47, 'Cổng giao tiếp', 'Thông số kỹ thuật'),
    (48, 'Jack tai nghe 3.5', 'Giao tiếp & kết nối'),
    (49, 'Chất liệu khung viền', 'Thiết kế & Trọng lượng'),
    (50, 'Chống nước', 'Thông số khác'),
    (51, 'Tiện ích sức khoẻ', 'Thông số khác'),
    (52, 'Thời lượng pin', 'Pin & công nghệ sạc'),
    (53, 'Tính năng thông minh', 'Tính năng nổi bật'),
    (54, 'Chất liệu viền', 'Chất liệu mặt & Dây'),
    (55, 'Chất liệu dây', 'Chất liệu mặt & Dây');

INSERT INTO `attribute_value` (`id`, `id_attribute`, `value`, `productId`) VALUES
    (1, 1, '6 GB', 1),
    (2, 2, '128 GB', 1),
    (3, 3, '6.9 inches', 1),
    (4, 8, 'Camera góc rộng: 12MP, f/1.6\nCamera góc siêu rộng: 12MP, ƒ/2.4', 1),
    (5, 5, '2532 x 1170 pixels', 1),
    (6, 6, 'Màn hình super Retina XDR, OLED, 460 ppi, HDR display, công nghệ True Tone Wide color (P3), Haptic Touch, Lớp phủ oleophobic chống bám vân tay', 1),
    (7, 7, '60Hz', 1),
    (13, 9, '4K 2160p@30fps\r\nFullHD 1080p@30fps\r\nFullHD 1080p@60fps\r\nHD 720p@30fps', 1),
    (14, 10, 'Chạm lấy nét\r\nHDR\r\nNhận diện khuôn mặt\r\nQuay chậm (Slow Motion)\r\nToàn cảnh (Panorama)\r\nTự động lấy nét (AF)\r\nXóa phông\r\nNhãn dán (AR Stickers)\r\nNhận diện khuôn mặt', 1),
    (15, 11, '12MP, f/2.2', 1),
    (16, 13, 'Apple A15', 1),
    (17, 16, '3.240mAh', 1),
    (18, 17, 'Sạc nhanh 20W, Sạc không dây, Sạc ngược không dây 15W, Sạc pin nhanh, Tiết kiệm pin', 1),
    (19, 18, 'Lightning', 1),
    (20, 20, 'iOS 15', 1),
    (21, 48, 'Không', 1),
    (22, 21, 'Có', 1),
    (23, 22, '5G', 1),
    (24, 23, 'Wi‑Fi 6 (802.11ax)', 1),
    (25, 24, 'v5.0', 1),
    (26, 15, 'GPS, GLONASS, Galileo, QZSS, and BeiDou', 1),
    (27, 26, '146,7 x 71,5 x 7,65mm', 1),
    (28, 27, '174g', 1),
    (29, 36, 'Kính', 1),
    (30, 49, 'Kim loại', 1),
    (31, 32, 'Tai thỏ', 1),
    (32, 35, 'Hỗ trợ 5G, Sạc không dây, Nhận diện khuôn mặt, Kháng nước, kháng bụi', 1),
    (33, 37, '1_main.png', 1),
    (34, 37, '1_43534534.png', 1);

-- INSERT INTO `user` (`name`, `mobile`, `email`, `hashedPassword`, `isAdmin`, `avatar`) VALUES ('name', 'admin', 'admin@admin.com', '$2y$10$EL973vCcI8rScwfy8qF4.eHW0ZQDv/ITBsgND.wBx8y.3eJqmfyvG', 1, 'ava');

INSERT INTO `user` VALUES
    (1,'Mr. Furman Osinski III','788-256-5364','bmccullough@example.org','12e5823aba90c366c5b9a1f31f196873a1894fd4','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',0,''),
    (2,'Edwin Sauer','02919605425','ernie25@example.com','4f46065f82e6c6d4ed4a84d90bf15c4312de5102','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',0,''),
    (3,'Mollie Ruecker','1-959-199-9780x65777','sylvan91@example.net','0b1d85e63d449229e9d47f05f28d28fef180b609','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',0,''),
    (4,'Dr. Cecil Bradtke','1-549-549-8451x6841','josiah92@example.com','242cc95244f46dda331468bdfa0878832dfcdee2','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',0,''),
    (5,'Everett Streich','611.269.4340x44844','margie.schiller@example.org','e66215ec5666cba978c4e5af08f4480eff29f3d0','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',0,''),
    (6,'Jerad White','+72(8)5710147485','roob.jaeden@example.net','b6af02a57d427628914f9a7e53c2ea690bc1db6e','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',0,''),
    (7,'Dr. Nicklaus Koss','1-117-318-6496x89063','hchristiansen@example.org','52d815835d3499c2d095a968b22fa3f52763b5ab','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',0,''),
    (8,'Misael Spinka','(438)000-3486','jake.rippin@example.com','a20de43b8a04d1702c94a213dd4f4dad57d8c640','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',0,''),
    (9,'Boyd Heaney','07645367153','mariana34@example.org','dd22b3f288f337789af2d6058dc75ca0d752a073','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',0,''),
    (10,'Dr. Eliezer Barrows','02143673376','hegmann.angeline@example.org','0b3bf810d3a2e46e6e9435524ca80b73c016c88a','2023-05-04 17:50:02','2023-05-04 17:50:02','2023-05-04 17:50:02',0,'');

INSERT INTO `order` VALUES
    (1,8,'bd987bb96709df6ee0f5','','Đã giao',0,40100000,NULL,0,'Aperiam quia omnis mollitia repellendus repudiandae tempore esse. Non sequi tempora eum tempora. Ull'),
    (2,3,'b1fd47bc3e97cb919a8a','','Đã thanh toán',0,20300000,NULL,0,'Mollitia a odio architecto ab et. Repellendus soluta a libero fugiat aperiam. Sit iusto quod sed com'),
    (3,8,'ea50706c465101a2ecc2','','Đã thanh toán',0,6900000,NULL,0,'Sed voluptatibus magnam ad quasi dolore cumque. Itaque quis deserunt itaque expedita facilis. Quisqu'),
    (4,3,'7a338445ee477527311d','','Chờ thanh toán',0,26100000,NULL,0,'Aut ut modi in aliquam. Voluptatem quia odio similique laboriosam ab amet aut facere. Dolores reicie'),
    (5,2,'691b74b099ccce5032ff','','Đã hủy',0,35400000,NULL,0,'Explicabo officia voluptas praesentium quibusdam. Aspernatur exercitationem voluptate aliquam soluta'),
    (6,3,'5e5d1173c5db96f10ca5','','Chờ lấy hàng',0,44100000,NULL,0,'Non totam repellendus officia. Possimus recusandae quibusdam ea qui qui velit. Eveniet asperiores do'),
    (7,10,'9a659e6a7005ec12dc3a','','Chờ lấy hàng',0,10900000,NULL,0,'Vero dolor qui quae molestiae qui ullam. Laudantium culpa reprehenderit voluptate fugiat qui modi do'),
    (8,5,'9996bace5d45712269a9','','Chờ lấy hàng',0,22600000,NULL,0,'Adipisci inventore blanditiis itaque eligendi. Odit perspiciatis aperiam expedita qui velit expedita'),
    (9,3,'e091f279d2b6a1724cbe','','Đã thanh toán',0,29900000,NULL,0,'Iste qui tempore neque voluptas ut voluptates. Adipisci quia tenetur earum necessitatibus aliquid pr'),
    (10,4,'f4f17a25b8de1ae4290b','','Chờ lấy hàng',0,39300000,NULL,0,'Aut natus et natus fugit quod voluptatum numquam sit. Eos iste quas nihil pariatur aut. Libero tempo'),
    (11,6,'d00dedab951f1fb9bbfb','','Chờ thanh toán',0,43800000,NULL,0,'Quis hic assumenda est voluptas alias. Porro voluptas incidunt assumenda. Ex molestias ipsa dolorem '),
    (12,10,'d7e7c834e4df6ffd2f8a','','Đang giao',0,26700000,NULL,0,'Et aut aspernatur id consequatur. Dicta rerum ut non illum eveniet velit inventore.'),
    (13,5,'96e95776bfbcaccc47aa','','Đã thanh toán',0,23900000,NULL,0,'Architecto iste consequatur et in qui voluptatum. Ratione voluptatem autem quia ea omnis sequi labor'),
    (14,6,'12c07a08cb8f29439aba','','Đã giao',0,29400000,NULL,0,'Aliquid neque est veniam labore. Aliquam necessitatibus voluptatem maiores excepturi sit dicta. Saep'),
    (15,9,'34cad6231eea3e20eae8','','Chờ lấy hàng',0,18800000,NULL,0,'Fugit ducimus autem ut consequatur nobis. Dignissimos excepturi ipsum hic possimus. Et libero perspi'),
    (16,4,'762ca432a1cff6c15da2','','Đang giao',0,15600000,NULL,0,'Rerum quas id sed perspiciatis. Eaque consequatur eum voluptas et delectus velit. Tempora delectus m'),
    (17,1,'93582d770b028f812356','','Chờ thanh toán',0,43100000,NULL,0,'Reprehenderit ratione perferendis at aut pariatur repellendus molestias. Aut in eum dolores optio qu'),
    (18,7,'c53975de402381aed631','','Chờ lấy hàng',0,18400000,NULL,0,'Debitis rerum distinctio velit harum deserunt. Voluptatum veniam omnis necessitatibus optio. Volupta'),
    (19,9,'9387349c48f5d02a92ae','','Đã hủy',0,28100000,NULL,0,'Mollitia voluptatibus tenetur facere non accusantium. Repellendus mollitia esse recusandae incidunt.'),
    (20,9,'3415057d26c90e6614e3','','Chờ lấy hàng',0,27700000,NULL,0,'Dolorem et reiciendis ratione natus amet. Magni sed in voluptate corrupti tenetur ducimus quibusdam '),
    (21,4,'acb77a0aa57c2b7a094b','','Đã thanh toán',0,38100000,NULL,0,'Eaque ipsum sint et qui laudantium quia. Quae aut magni consequatur quae aut. Voluptatum sint et del'),
    (22,6,'b2659ba0c1871709a7b7','','Đã giao',0,19400000,NULL,0,'In pariatur molestiae aut odit. Est iste molestiae minus natus dolorem id. Minus nostrum unde dolore'),
    (23,10,'b14dc6ac983ba37598eb','','Đã thanh toán',0,6700000,NULL,0,'Iusto temporibus nostrum ullam optio. Illo omnis distinctio laboriosam sint sed voluptatum. Est dolo'),
    (24,1,'ee89f4c3e3b5e233dc49','','Chờ lấy hàng',0,33600000,NULL,0,'Et voluptatem velit cumque. Nam id ad quis rerum itaque. Placeat molestiae ea laborum quidem.'),
    (25,4,'5b52a3b0cdd9112b81e0','','Đã thanh toán',0,36000000,NULL,0,'Qui rerum incidunt voluptatem esse. Ad veritatis cumque quos nihil nulla culpa dolorem modi. Ut vel '),
    (26,8,'df65336a034294296971','','Đã thanh toán',0,40400000,NULL,0,'Est consequatur omnis ipsam. Aut doloremque placeat sit ut dolorum. Voluptatem tempora explicabo et '),
    (27,9,'0ee722c1289faa03b095','','Đã hủy',0,10800000,NULL,0,'Dicta et nostrum ipsa delectus excepturi. Iusto dignissimos voluptates qui id minus. Officia fugiat '),
    (28,2,'1f58c13cdb1f7e353ff9','','Đang giao',0,33700000,NULL,0,'Similique iusto sint eum perspiciatis aut. Aut est assumenda reprehenderit quo quasi rerum. Et liber'),
    (29,1,'36df7510b4c48dee163f','','Đã hủy',0,22000000,NULL,0,'Aliquam et sunt accusantium exercitationem dignissimos omnis. Laudantium nam possimus voluptatibus q'),
    (30,1,'fa90c6a9bddd89d014cf','','Chờ thanh toán',0,21400000,NULL,0,'Doloribus quia dolorum eligendi velit quasi pariatur. Voluptas dolorem inventore nam eaque iure aut.');
