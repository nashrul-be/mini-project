CREATE DATABASE IF NOT EXISTS mini;

create table role (
	id int unsigned auto_increment primary key,
	role_name varchar(32)
);

create table actors (
	id bigint unsigned auto_increment primary key,
	username varchar(32) not null,
	password varchar(255) not null,
	role_id int unsigned not null,
	verified enum('true', 'false') default 'false',
	active enum('true', 'false') default 'false',
	created_at datetime default now(),
	update_at datetime default now() on update now(),
	foreign key (role_id) references role(id)
);

create table customer (
	id bigint unsigned auto_increment primary key,
	first_name varchar(32) not null,
	last_name varchar(32) not null,
	email varchar(32) not null,
	avatar varchar(255) not null,
	created_at datetime default now(),
	update_at datetime default now() on update now()
);

create table register_approval (
	id bigint unsigned auto_increment primary key,
	admin_id bigint unsigned not null,
	super_admin_id bigint unsigned not null,
	status varchar(32) not null,
	foreign key (admin_id) references actors(id),
	foreign key (super_admin_id) references actors(id)
);

insert into role (`role_name`)
values ('super_admin');

select last_insert_id() into @super_admin_id;

insert into role (`role_name`)
values ('admin');

insert into actors (username, password, role_id)
values ('su_admin', 'su_admin', @super_admin_id);

CREATE USER 'su_admin'@'0.0.0.0' IDENTIFIED BY 'su_admin';

GRANT ALL PRIVILEGES ON mini.* TO 'su_admin'@'0.0.0.0';
