
create schema pub;
create table pub.list (
id serial primary key,
hostname text not null,
wlan text not null,
lan text not null
);

insert into pub.list (hostname, wlan, lan) values
('localhost', '0.0.0.0', '127.0.0.1');


create role reader nologin;
create role writer nologin
create role postgres nologin;


grant usage on schema pub to reader;
grant usage on schema pub to writer;
grant usage on schema pub to postgres;


grant select on pub.list to reader;

grant all on pub.list to writer;
grant usage, select on sequence pub.list_id_seq to writer;

grant all on pub.list to postgres;

create role auth_reader noinherit login password 'reader_secret_password';
create role auth_writer noinherit login password 'writer_secret_password';

grant reader to auth_reader;
grant writer to auth_writer;


create table public.host_index (
id serial primary key,
hostname text not null,
interface varchar(15) not null,
ip varchar(15) not null
);

grant all on public.host_index to root;
