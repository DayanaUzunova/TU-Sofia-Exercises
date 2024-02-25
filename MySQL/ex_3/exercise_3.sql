DROP DATABASE IF EXISTS news;
CREATE DATABASE news;
USE news;

create table categories(
    id int auto_increment primary key,
    type varchar(45) not null
);

create table article(
    id int auto_increment primary key,
    title varchar(255) not null,
    description varchar(255) null,
    category_id int not null,
    constraint news_categories_id_fk foreign key (category_id) references categories (id)
);

create table resources(
    id int auto_increment primary key,
    file_path varchar(255) null
);

create table article_resources(
    article_id  int not null,
    recource_id int not null,
    constraint news_resources_news_id_fk
	foreign key (article_id) references article (id),
    constraint resource_id foreign key (recource_id) references resources (id)
);

create table role(
    id int auto_increment primary key,
    role_type varchar(255) not null
);

create table users(
    id int auto_increment primary key,
    first_name varchar(255) null,
    last_name  varchar(255) not null,
    email varchar(255) not null,
    password int not null,
    role_id int not null,
    isActive tinyint(1) default 1 not null,
    constraint users_role_id_fk foreign key (role_id) references role (id)
);

create table comments(
    id int auto_increment primary key,
    user_id int not null,
    article_id int not null,
    text varchar(255) not null,
    constraint comments_article_id_fk
	foreign key (article_id) references article (id),
    constraint comments_users_id_fk foreign key (user_id) references users (id)
);