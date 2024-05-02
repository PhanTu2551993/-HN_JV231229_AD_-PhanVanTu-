use quanlybanhang;

#Thêm dữ liệu vào Bảng CUSTOMERS [5 điểm] :

insert into customers (customer_id, name, email, phone, address)
value
    ('C001', 'Nguyễn Trung Mạnh', 'manhnt@gmail.com', '0984756322', 'Cầu Giấy, Hà Nội'),
    ('C002', 'Hồ Hải Nam', 'namhh@gmail.com', '0984875926', 'Ba Vì, Hà Nội'),
    ('C003', 'Tô Ngọc Vũ', 'lvutn@gmail.com', '0904725784', 'Mộc Châu, Sơn La'),
    ('C004', 'Phạm Ngọc Anh', 'anhpn@gmail.com', '0984635365', 'Vinh, Nghệ An'),
    ('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '0989735624', 'Hai Bà Trưng, Hà Nội');


#Thêm dữ liệu vào Bảng Product [5 điểm] :

insert into products (product_id, name, description, price)
values ('P001', 'Iphone 13 ProMax', 'Bản 512 GB, xanh lá', 22999999),
       ('P002', 'Dell Vostro V3510 Core i5', 'RAM 8GB', 14999999),
       ('P003', 'Macbook Pro M2 8CPU 10GPU', '8GB 256GB', 28999999),
       ('P004', 'Apple Watch Ultra ', 'Titanium Alpine Loop Smaill', 18999999),
       ('P005', 'Airpods 2 2022 ', 'Spatial Audio', 4090000);


# Thêm dữ liệu vào Bảng Order [5 điểm] :

insert into orders (order_id, customer_id, total_amount, order_date)
value ('H001', 'C001', 52999997, '2023-02-22'),
    ('H002', 'C001', 80999997, '2023-03-11'),
    ('H003', 'C002', 54359998, '2023-01-22'),
    ('H004', 'C003', 102999995, '2023-03-14'),
    ('H005', 'C003', 80999997, '2022-03-12'),
    ('H006', 'C004', 110449994, '2023-02-01'),
    ('H007', 'C004', 79999996, '2023-03-29'),
    ('H008', 'C005', 29999998, '2023-02-14'),
    ('H009', 'C005', 28999999, '2023-01-10'),
    ('H010', 'C005', 149999994, '2023-04-01');

## Thêm dữ liệu vào Bảng ORDERS_DETAILS [5 điểm] :

insert into orders_details (order_id, product_id, price, quantity)
value
    ('H001', 'P002', 14999999, 1),
    ('H001', 'P004', 18999999, 2),
    ('H002', 'P001', 22999999, 1),
    ('H002', 'P003', 28999999, 2),
    ('H003', 'P004', 18999999, 2),
    ('H003', 'P005', 40900001, 4),
    ('H004', 'P002', 14999999, 3),
    ('H004', 'P003', 28999999, 2),
    ('H005', 'P001', 22999999, 1),
    ('H005', 'P003', 28999999, 2),
    ('H006', 'P005', 40900001, 5),
    ('H006', 'P002', 14999999, 6),
    ('H007', 'P004', 18999999, 3),
    ('H007', 'P001', 22999999, 1),
    ('H008', 'P002', 14999999, 2),
    ('H009', 'P003', 28999999, 1),
    ('H010', 'P003', 28999999, 2),
    ('H010', 'P001', 22999999, 4);

#1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers . [4 điểm]

    select name 'tên', email,phone 'số điện thoại',address 'địa chỉ'
    from customers;

#2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện
#thoại và địa chỉ khách hàng). [4 điểm]

    select c.name 'tên',phone 'số điện thoại',address 'địa chỉ'
    from customers c
    join orders o on c.customer_id = o.customer_id
    where year(order_date) = 2023 and month(order_date) = 3;

#3. Thống kê doanh thua theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm
#tháng và tổng doanh thu ). [4 điểm]

    select month(order_date) as 'Tháng',sum(total_amount) as 'Tổng doanh thu'
    from orders
    where year(order_date) = 2023
    group by tháng;

#4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách
#hàng, địa chỉ , email và số điên thoại). [4 điểm]

    select c.name 'tên khách hàng',c.address 'địa chỉ' ,c.email,c.phone 'số điên thoại'
    from customers c
    where c.customer_id not in (select o.customer_id
                                from orders o
                                where year(o.order_date) = 2023 and month(o.order_date) = 2);

#5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã
#sản phẩm, tên sản phẩm và số lượng bán ra). [4 điểm]

    select p.product_id 'mã sản phẩm',p.name 'tên sản phẩm', sum(od.quantity) 'số lượng bán ra'
    from products p
    join orders_details od on p.product_id = od.product_id
    join orders o on o.order_id = od.order_id
    where year(order_date) = 2023 and month(order_date) = 3
    group by od.product_id,p.name;

#6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi
#tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu). [5 điểm]

    select c.customer_id 'mã khách hàng',c.name 'tên khách hàng',sum(o.total_amount) 'mức chi tiêu'
    from customers c
    join orders o on c.customer_id = o.customer_id
    where year(order_date) = 2023
    group by o.customer_id,c.name
    order by `mức chi tiêu` desc ;

#7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm
#tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm) . [5 điểm]

    select c.name 'tên người mua',o.total_amount 'tổng tiền' ,o.order_date 'ngày tạo hoá đơn',sum(od.quantity) 'tổng số lượng sản phẩm'
    from orders o
    inner join customers c on c.customer_id = o.customer_id
    inner join orders_details od on o.order_id = od.order_id
    group by o.order_id, c.name,o.total_amount, o.order_date
    having `tổng số lượng sản phẩm` >= 5;


#1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng
#tiền và ngày tạo hoá đơn . [3 điểm]

    create view order_info as
        select c.name 'Tên khách hàng',c.phone 'số điện thoại',address 'địa chỉ',o.total_amount 'tổng tiền', o.order_date 'ngày tạo hoá đơn'
        from customers c
        join orders o on c.customer_id = o.customer_id;

#2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng
#số đơn đã đặt. [3 điểm]

    create view customer_info as
        select c.name 'tên khách hàng',address 'địa chỉ',phone 'số điện thoại',count(o.order_id) 'tổng số đơn đã đặt'
        from customers c
        join orders o on c.customer_id = o.customer_id
        group by c.customer_id,c.name;

#3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã
#bán ra của mỗi sản phẩm.

    create view products_info as
        select name 'tên sản phẩm',description 'mô tả',p.price giá ,sum(od.quantity) 'tổng số lượng đã bán ra'
        from products p
        join orders_details od on p.product_id = od.product_id
        group by p.product_id;

#4. Đánh Index cho trường `phone` và `email` của bảng Customer. [3 điểm]

    create index index_phone on customers (phone);
    create index index_email on customers (email);

#5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.[3 điểm]

    delimiter //
    create procedure GetCustomerInfo(
        In_customer_id varchar(4)
    )
    begin
        select * from customers
            where customer_id = In_customer_id;
    end //
    delimiter ;

    call GetCustomerInfo('C002');

#6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm. [3 điểm]

    delimiter //
    create procedure GetAllProducts()
    begin
        select * from products;
    end //
    delimiter ;

    call GetAllProducts();

#7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng. [3 điểm]

    delimiter //
    create procedure GetOrdersByCustomerID(
        In_customer_id varchar(4)
    )
    begin
        select * from orders
            where customer_id = In_customer_id;
    end //
    delimiter ;

    call GetOrdersByCustomerID('C002');

#8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng
#tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo. [3 điểm]
#9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng
#thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc. [3 điểm]

    delimiter //
    create procedure sales_statistics_by_date_range (
        IN_startDate date,
        IN_endDate date
    )
    begin
    select p.name as 'Tên sản phẩm', sum(od.quantity) as 'Tổng số lượng'
    from products p
             left join orders_details od on p.product_id = od.product_id
             inner join orders o on od.order_id = o.order_id
    where o.order_date between IN_startDate and IN_endDate
    group by p.product_id;
    end//
    delimiter ;

    call sales_statistics_by_date_range('2023-01-01','2023-02-02');

#10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự
#giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê. [3 điểm

    delimiter //
    create procedure sales_statistics_by_month (
        IN_month int,
        IN_year int
    )
    begin
    select p.name as product_name, sum(od.quantity) as total_sold_quantity
    from products p
             left join orders_details od on p.product_id = od.product_id
             inner join orders o on od.order_id = o.order_id
    where year(o.order_date) = IN_year and month(o.order_date) = IN_month
    group by p.product_id
    order by total_sold_quantity desc;
    end//
    delimiter ;

    call sales_statistics_by_month('03','2023');