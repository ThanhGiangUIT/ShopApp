CREATE DATABASE shopapp;
USE shopapp;

--Bảng người dùng
CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,--id tu tang len
    fullname VARCHAR(100) DEFAULT '', --ten cua nguoi su dung co the de trong
    phone_number VARCHAR(20) NOT NULL,--yeu cau phai co so dien thoai, KHONG DUOC de trong
    address VARCHAR(200) DEFAULT '',  --dia chi cua nguoi su dung co the de trong
    password VARCHAR(100) NOT NULL DEFAULT '',   --mat khau cua nguoi su dung KHONG DUOC de trong (mat khau o day la mat khau da ma hoa)
    created_at DATETIME, --theo doi thoi gian user duoc tao ra
    updated_at DATETIME, --theo doi thoi gian user duoc chinh sua
    is_active TINYINT(1) DEFAULT 1,
    date_of_birth DATE,
    facebook_account_id INT DEFAULT 0,
    google_account_id INT DEFAULT 0
);

ALTER TABLE users ADD COLUMN role_id INT;

--Bảng roles
CREATE TABLE roles(
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);
ALTER TABLE users ADD FOREIGN KEY (role_id) REFERENCES roles(id);

--Bảng tokens
CREATE TABLE tokens(
    id INT PRIMARY KEY AUTO_INCREMENT,
    token VARCHAR(255) NOT NULL,
    token_type VARCHAR(50) NOT NULL,
    expiration_date DATETIME,
    revoked TINYINT(1) NOT NULL,
    expired TINYINT(1) NOT NULL COMMENT 'Đã hết hạn trả về 0, chưa thì là 1',
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

--Bảng MạngXH
CREATE TABLE social_account(
    id INT PRIMARY KEY AUTO_INCREMENT,
    provider VARCHAR(20) NOT NULL COMMENT 'Tên của Mạng Xã Hội',
    provider_id VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL COMMENT 'Email của tài khoản',
    name VARCHAR(100) NOT NULL COMMENT 'Tên người dùng'
    user_id INT ;
    FOREIGN KEY (user_id) REFERENCES users(id)
);

--Bảng danh mục sản phẩm
CREATE TABLE categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'TÊN DANH MỤC SẢN PHẨM',
);

--Bảng sản phẩm
CREATE TABLE products(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(350) COMMENT 'TÊN SẢN PHẨM',
    price FLOAT NOT NULL CHECK (price >= 0),
    thumbnail VARCHAR(300) DEFAULT '',
    description LONGTEXT DEFAULT '',
    created_at DATETIME, 
    updated_at DATETIME,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id) 
);

CREATE TABLE product_images(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT fk_product_images_products_id
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE 
);

--Bảng đặt hàng
CREATE TABLE orders(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    fullname VARCHAR(100) DEFAULT '',
    email VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(200) NOT NULL,
    note VARCHAR(100) DEFAULT '',  
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    total_money FLOAT CHECK(total_money >= 0)
);

ALTER TABLE orders ADD COLUMN shipping_method VARCHAR(100);
ALTER TABLE orders ADD COLUMN shipping_address VARCHAR(200);
ALTER TABLE orders ADD COLUMN shipping_date DATE;
ALTER TABLE orders ADD COLUMN tracking_number VARCHAR(100);
ALTER TABLE orders ADD COLUMN payment_method VARCHAR(100);
--Xóa đơn hàng (xóa mềm)
ALTER TABLE orders ADD COLUMN active TINYINT(1);
--Trạng thái đơn hàng chỉ được nhận một số giá trị cụ thể
ALTER TABLE orders
MODIFY COLUMN status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') COMMENT 'TRẠNG THÁI ĐƠN HÀNG';

--Bảng chi tiết đơn hàng
CREATE TABLE order_details(
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    FOREIGN KEY order_id REFERENCES orders(id),
    product_id INT,
    FOREIGN KEY product_id REFERENCES products(id),
    price FLOAT CHECK (price >= 0),
    number_of_products INT CHECK (number_of_products > 0)
    total_money FLOAT CHECK (total_money >= 0),
    colors VARCHAR(20) DEFAULT ''
);

ALTER TABLE ten_bang AUTO_INCREMENT = 1; //dua so id tu tang cua bang ve 1 