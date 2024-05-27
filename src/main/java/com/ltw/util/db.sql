-- Creating tables --
create table categories (
                            id int AUTO_INCREMENT primary key not null,
                            name varchar(50) not null,
                            description text null,
                            profilePic varchar(200) null,
                            createdDate timestamp null,
                            createdBy varchar(50) null,
                            modifiedDate timestamp null,
                            modifiedBy varchar(50) null
);

create table category_types (
                                id int AUTO_INCREMENT primary key not null,
                                name varchar(50) not null,
                                description text null,
                                categoryId int not null,
                                idOnBrowser varchar(50),
                                status int not null,
                                createdDate timestamp null,
                                createdBy varchar(50) null,
                                modifiedDate timestamp null,
                                modifiedBy varchar(50) null
);

create table users (
                       id int AUTO_INCREMENT primary key not null,
                       email varchar(50) not null,
                       password varchar(255) not null,
                       firstName varchar(30) null,
                       lastName varchar(50) null,
                       roleId int not null,
                       status int not null,
                       verifiedCode varchar(500) null,
                       changePwHash varchar(255) null,
                       expiredTime timestamp null,
                       addressLine varchar(100) null,
                       addressWard varchar(100) null,
                       addressDistrict varchar(100) null,
                       addressProvince varchar(100) null,
                       createdDate timestamp null,
                       modifiedDate timestamp null
);

create table blogs (
                       id int AUTO_INCREMENT primary key not null,
                       title varchar(150) not null,
                       author varchar(100) not null,
                       description text not null,
                       profilePic varchar(200) null,
                       categoryId int not null,
                       content text not null,
                       status int not null,
                       createdDate timestamp null,
                       createdBy varchar(50) null,
                       modifiedDate timestamp null,
                       modifiedBy varchar(50) null
);

create table roles (
                       id int AUTO_INCREMENT primary key not null,
                       name varchar(30) not null,
                       description varchar(100) null,
                       status int not null,
                       createdDate timestamp null,
                       createdBy varchar(50) null,
                       modifiedDate timestamp null,
                       modifiedBy varchar(50)
);

create table images (
                        id int AUTO_INCREMENT primary key not null,
                        name varchar(250) not null,
                        link varchar(5000) not null,
                        productId int not null,
                        nameInStorage varchar(100) not null,
                        createdDate timestamp null,
                        createdBy varchar(50) null,
                        modifiedDate timestamp null,
                        modifiedBy varchar(50) null
);

create table products (
                          id int AUTO_INCREMENT primary key not null,
                          name varchar(250) not null,
                          description text not null,
                          categoryTypeId int not null,
                          originalPrice double not null,
                          discountPrice double not null,
                          discountPercent double not null,
                          quantity int not null,
                          size varchar(30) not null,
                          otherSpec varchar(200) null,
                          status int not null,
                          keyword text not null,
                          createdDate timestamp null,
                          createdBy varchar(50) null,
                          modifiedDate timestamp null,
                          modifiedBy varchar(50) null
);

create table customize_pages (
                                 id int AUTO_INCREMENT primary key not null,
                                 welcomeTitle varchar(200) not null,
                                 welcomeDes varchar(1000) not null,
                                 productTitle varchar(200) not null,
                                 productDes varchar(1000) not null,
                                 prTitle1 varchar(200) not null,
                                 prDes1 varchar(1000) not null,
                                 prIcon1 varchar(1000) not null,
                                 prContentTitle1 varchar(500) not null,
                                 prContentDes1 text not null,
                                 prLink1 text not null,
                                 prLink1InStorage varchar(200) not null,
                                 prTitle2 varchar(200) not null,
                                 prDes2 varchar(1000) not null,
                                 prContent2 text not null,
                                 prLink2 text not null,
                                 prLink2InStorage varchar(200) not null,
                                 background text not null,
                                 backgroundInStorage varchar(200) not null,
                                 footerLeft varchar(1000) not null,
                                 footerMiddle varchar(1000) not null,
                                 facebookLink varchar(300) null,
                                 twitterLink varchar(300) null,
                                 instagramLink varchar(300) null,
                                 linkedinLink varchar(300) null
);
insert into customize_pages(welcomeTitle, welcomeDes, productTitle, productDes, prTitle1, prDes1, prIcon1, prContentTitle1,
                            prContentDes1, prlink1, prLink1InStorage, prTitle2, prDes2, prContent2, prLink2, prLink2InStorage, background, backgroundInStorage,
                            footerLeft, footerMiddle, facebookLink, twitterLink, instagramLink, linkedinLink)
values ('', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');

create table orders (
                        id int AUTO_INCREMENT primary key not null,
                        userId int not null,
                        createdDate timestamp null,
                        shipToDate timestamp null,
                        total double not null,
                        paymentMethod varchar(100),
                        status int not null,
                        createdBy varchar(100) null,
                        modifiedDate timestamp null,
                        modifiedBy varchar(100) null
);

create table orders (
                        id int AUTO_INCREMENT primary key not null,
                        userId int not null,
                        createdDate timestamp null,
                        shipToDate timestamp null,
                        total double not null,
                        paymentMethod varchar(100),
                        status int not null,
                        createdBy varchar(100) null,
                        modifiedDate timestamp null,
                        modifiedBy varchar(100) null
);

create table order_details (
                               orderId int not null,
                               productId int not null,
                               quantity int not null,

                               primary key(orderId, productId)
);

create table contacts (
                          id int AUTO_INCREMENT primary key not null,
                          email varchar(50) not null,
                          firstName varchar(30) not null,
                          lastName varchar(50) not null,
                          message text not null,
                          status int not null,
                          createdDate timestamp null,
                          createdBy varchar(50) null,
                          modifiedDate timestamp null,
                          modifiedBy varchar(50) null
);

create table logs (
                      id int AUTO_INCREMENT primary key not null,
                      ip varchar(20) not null,
                      level varchar(10) not null,
                      address text not null,
                      previousValue text,
                      currentValue text,
                      national varchar(50) not null,
                      createdDate timestamp
);


-- Adding foreign keys --
alter table users add constraint users_role
    foreign key (roleId) references roles(id);

alter table category_types add constraint categoryType_category
    foreign key (categoryId) references categories(id);

alter table products add constraint product_categoryType
    foreign key (categoryTypeId) references category_types(id);

alter table images add constraint image_product
    foreign key (productId) references products(id);

alter table orders add constraint order_user
    foreign key (userId) references users(id);

alter table order_details add constraint detail_order
    foreign key (orderId) references orders(id);
alter table order_details add constraint detail_product
    foreign key (productId) references products(id);

-- Inserting sample data --
insert into categories(name, createdDate, modifiedDate) values ("Gỗ", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into categories(name, createdDate, modifiedDate) values ("Đan lát", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into categories(name, createdDate, modifiedDate) values ("Gốm sứ", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Lục bình gỗ", 1, "luc-binh-go", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Đĩa gỗ", 1, "dia-trang-tri-go", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Tượng gỗ", 1, "tuong-go", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Đồng hồ gỗ", 1, "dong-ho-go", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Nội thất gỗ", 1, "noi-that-go", 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Túi xách", 2, "tui-xach", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Ví cầm tay", 2, "vi-cam-tay", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Hộp đựng", 2, "hop-dung", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Nón", 2, "non", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Nhà thú cưng", 2, "nha-thu-cung", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Thùng rác", 2, "thung-rac", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Khác", 2, "khac", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Bộ ấm trà", 3, "bo-am-tra", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Lọ", 3, "lo", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Bình phong thủy", 3, "binh-phong-thuy", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Tranh", 3, "tranh", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Thác nước & Tượng", 3, "thac-nuoc-va-tuong", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Ly, cốc, phin cà phê", 3, "ly-coc-phin", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Khay mứt", 3, "khay-mut", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into category_types(name, categoryId, idOnBrowser, status, createdDate, modifiedDate) values ("Bộ bát đĩa", 3, "bo-bat-dia", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

insert into products(name, description, categoryTypeId, originalPrice, discountPrice, discountPercent, quantity, size, otherSpec, status, keyword, createdDate, modifiedDate)
values ('Cặp lục bình gỗ hương đá', "Lục bình bằng gỗ có ý nghĩa đặc biệt trong phong thủy. Người ta nói rằng những bông hoa này sẽ mang lại cho bạn may mắn và tài lộc.", 1, 5490000, 4950000, 10, 21, "100 x 27 x 27 (cm)", "Gỗ hương đá", 1, "lục bình gỗ, hương đá, phong thủy, lớn", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into products(name, description, categoryTypeId, originalPrice, discountPrice, discountPercent, quantity, size, otherSpec, status, keyword, createdDate, modifiedDate)
values ("Bình phú quý gỗ cẩm", "Bình Phú Quý Gỗ Cẩm Cao 30cm nghệ thuật để trưng bày tủ kính, kệ tivi phòng khách.", 1, 2490000, 2249000, 10, 14, "33 x 17 x 17 (cm)", "Gỗ cẩm", 1, "bình gỗ, cẩm, nghệ thuật, trưng bày, nhỏ", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


insert into blogs(title, author, description, categoryId, content, status, createdDate, createdBy, modifiedDate, modifiedBy)
values ("Thủ công mỹ nghệ và sản phẩm thủ công mỹ nghệ", "Admin", "Thủ công mỹ nghệ là ngành nghề chuyên làm thủ công (làm bằng tay) các mặt hàng có tính thẩm mỹ và nghệ thuật.", 1, "Các sản phẩm thủ công mỹ nghệ là sản phẩm được làm hoàn toàn bằng tay dưới sự hỗ trợ của công cụ đơn giản. Nói cách khác, sản phẩm Thủ công mỹ nghệ (Handicraft) là kết quả từ bàn tay của nghệ nhân thủ công. Chúng thể hiện vẻ đẹp của sự khéo léo cùng kĩ thuật truyền thống; chúng không được tạo ra từ quá trình sản xuất máy móc hàng loạt. Do đó, sản phẩm thủ công mỹ nghệ thường sẽ là sản phẩm của các ngành nghề truyền thống, lâu đời, không chỉ có giá trị nghệ thuật mà còn có giá trị văn hóa và giá trị dân tộc.
Hiện nay, các sản phẩm thủ công mỹ nghệ với những ưu điểm nổi bật do đặc tính sáng tạo, tính nghệ thuật và xu hướng tiêu dùng xanh của xã hội mà ngành hàng này càng được ưa chuộng và phát triển rộng lớn.", 1, CURRENT_TIMESTAMP, "impmd2305@gmail.com", CURRENT_TIMESTAMP, "impmd2305@gmail.com");
insert into blogs(title, author, description, categoryId, content, status)
values ("Test đan lát blog", "Admin 2", "Thử test đan lát blog và cái kết", 1, "Đây là bài blog test với danh mục đan lát", 1);
insert into blogs(title, author, description, categoryId, content, status)
values ("Test gốm sứ blog", "Admin 1", "Thử test gốm sứ blog và cái kết", 1, "Đây là bài blog test với danh mục gốm sứ", 1);
insert into blogs(title, author, description, categoryId, content, status)
values ("Test gốm sứ blog 2", "Admin 2", "Thử test gốm sứ blog 2 và cái kết", 1, "Đây là bài blog test với danh mục gốm sứ 2", 1);
insert into blogs(title, author, description, categoryId, content, status)
values ("Test vô hiệu hóa blog", "Admin 2", "Thử test vô hiệu hóa blog và cái kết", 1, "Đây là bài blog test vô hiệu hóa", 0);

insert into roles(id, name, status, createdDate, modifiedDate) values (1, "Client", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into roles(id, name, status, createdDate, modifiedDate) values (2, "Admin", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into roles(id, name, status, createdDate, modifiedDate) values (3, "Mod", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO roles (name, description, status, createdDate, createdBy, modifiedDate, modifiedBy)
VALUES
    ('Admin', 'Quản trị hệ thống', 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin'),
    ('User', 'Người dùng hệ thống', 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO your_table_name (name, link, productId, nameInStorage, createdDate, createdBy, modifiedDate, modifiedBy) VALUES
                                                                                                                         
('Product A', 'templates\client\images\wooden\binh_go_cam_2_1.jpg', 101, 'product_a.jpg', '2024-05-01 10:00:00', 'admin', '2024-05-01 10:00:00', 'admin'),
('Product C', 'templates\client\images\wooden\binh_go_cam_2_2.jpg', 103, 'product_c.jpg', '2024-05-03 12:00:00', 'admin', '2024-05-03 12:00:00', 'admin'),
('Product D', 'templates\client\images\wooden\binh_go_cam_2_1.jpg', 104, 'product_d.jpg', '2024-05-04 13:00:00', 'admin', '2024-05-04 13:00:00', 'admin'),
('Product E', 'templates\client\images\wooden\binh_go_cam_2_2.jpg', 105, 'product_e.jpg', '2024-05-05 14:00:00', 'admin', '2024-05-05 14:00:00', 'admin');

-- Testing queries --
select * from categories;

select * from users;

select * from roles;

select * from blogs;

select * from images;

select * from category_types;

select * from products;

select * from customize_pages;

select * from orders;

select * from order_details;

select * from contacts;