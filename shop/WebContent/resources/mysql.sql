use jsp;

create table member(
	id varchar(20),
	pass varchar(20),
	name varchar(20));

select * from member;

insert into member values('manager', '1234', '홍길동');
insert into member values('jsptest', '1234', '임꺽정');

delete from member where id='manager';
delete from member where id='qweqweasd';
delete from member where id='test2';

-- 230125(수)
create table product(
	p_id varchar(10) not null,
	p_name varchar(20),
	p_unitPrice integer,
	p_description text,
	p_category varchar(20),
	p_manufacturer varchar(20),
	p_unitsInStock long,
	p_condition varchar(20),
	p_filename varchar(20),
	primary key (p_id)
);
drop table product;
select * from product;
insert into product values('P1234', 'iPhone 14promax', 2000000, '6.7-inch, super-oled디스플레이, 4800만 화소', '스마트폰', '애플', 20000, '신상품', 'P1234.PNG');
insert into product values('P1235', 'Lg 울트라기어', 770000, '32-inch, LED, 디스플레이', '모니터', 'LG', 300, '중고', 'P1235.PNG');
insert into product values('P1236', '갤럭시S8', 800000, '11-inch, 램8GB, 와이파이전용', '태블릿', '삼성', 800, '재생품', 'P1236.PNG');
delete from product where P_id='P1239';

-- 230126(목)
alter table member add column photo varchar(40);

select * from member;
delete from member;
desc member;