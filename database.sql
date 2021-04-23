create database if not exists dart;
drop table if exists users;
create table users(
  id int auto_increment primary key,
  name varchar(255) not null,
  email varchar(255) not null
);