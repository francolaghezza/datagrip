--1--
create table banco(
  num_ba char(4) constraint banco_pk primary key ,
  nombre varchar2(25) constraint banco_uk1 unique
                      constraint banco_nn1 not null
);
create table clientes(
  id_cliente number(8) constraint clientes_pk primary key ,
  nombre varchar2(25) constraint clientes_nn1 not null,
  apellido1 varchar2(25) constraint clientes_nn2 not null,
  apellido2 varchar2(25),
  telefono char(9),
  direccion varchar2(50)
);
create table personal(
  id_persona number(3) constraint personal_pk primary key ,
  nombre varchar2(25) constraint personal_nn1 not null ,
  apellido1 varchar2(25) constraint personal_nn2 not null ,
  apellido2 varchar2(25),
  telefono char(9),
  direccion varchar2(25),
  id_jefe number(3) constraint personal_fk1 references personal on delete set null
);
create table sucursal(
  num_ba char(4) constraint sucursal_fk1 references banco on delete cascade,
  num_su char(4),
  direccion varchar2(50),
  id_director number(3) constraint sucursal_fk2 references personal (id_persona)
                        constraint sucursal_nn1 not null ,
  id_interventor number(3) constraint sucursal_fk3 references personal(id_persona)
);
alter table sucursal add constraint sucursal_pk primary key (num_ba,num_su);
create table cuentas(
  num_ba char(4),
  num_su char(4),
  control char(2),
  num_cu number(10),
  saldo number(20,5) constraint cuentas_ck1 check (saldo>=1000),
  id_cliente number(8) constraint cuentas_fk2 references clientes on delete cascade
);
alter table cuentas
modify saldo default 1000;
alter table cuentas add constraint cuentas_pk primary key (num_ba,num_su,control,num_cu);
alter table cuentas add constraint cuentas_fk1 foreign key (num_ba,num_su) references sucursal on delete cascade;
alter table cuentas add constraint cuentas_ck2 check (control!=60 and control!=35 and control!=17);
------EJERCICIO 2----
alter table banco
add constraint bancos_ck1 check(length(num_ba)=4);
alter table personal add(
  nivel char(1) constraint personal_ck1 check (nivel='B'or nivel='C' or nivel='A')
  );
alter table personal
modify nivel default 'B';
alter table cuentas rename constraint cuentas_pk to numero_completo_pk;
alter table sucursal drop constraint sucursal_nn1;
alter table clientes
modify id_cliente constraint clientes_nn3 not null;
rename personal to trabajadores;
----EJERCICIO 3-----
insert into clientes(id_cliente,nombre,apellido1,apellido2,telefono,direccion)
values (1,'Fernando','Arriaga','Granados','979777877','C/Mayor 15 1ºA');
insert into clientes(id_cliente,nombre,apellido1,apellido2,telefono,direccion)
values (2,'Martina','Salazar','Merino','979506010','C/Mayor 15 1ºA');
insert into clientes(id_cliente,nombre,apellido1,apellido2,telefono,direccion)
values (3,'Cristina','Ollante','Buruaga','979777777','C/Londres 2');
insert into clientes(id_cliente,nombre,apellido1,apellido2,telefono,direccion)
values (4,'Fernando','Arriaga','Granados','979777877','C/Mayor 15 1ºA');
insert into clientes(id_cliente,nombre,apellido1,apellido2,telefono,direccion)
values (5,'Fernando','Arriaga','Granados','979777877','C/Mayor 15 1ºA');
insert into clientes(id_cliente,nombre,apellido1,apellido2,telefono,direccion)
values (6,'Martina','Salazar','Merino','979506010','C/Mayor 15 1ºA');
insert into clientes(id_cliente,nombre,apellido1,apellido2,telefono,direccion)
values (7,'Cristina','Ollante','Buruaga','979777777','C/Londres 2');
insert into banco(num_ba, nombre)
values ('0001','Banco del Cerrato');
insert into banco(num_ba, nombre)
values ('0002','Banco de Campos');
insert into sucursal(num_ba,num_su,direccion)
values ('0001','0001','C/Mayor 30');
insert into sucursal(num_ba,num_su,direccion)
values ('0001','0002','C/San Luis s/n');
insert into sucursal(num_ba,num_su,direccion)
values ('0002','0001','C/Mayor 60');
insert into cuentas(num_ba,num_su,control,num_cu,saldo)
values ('0001','0001','10',1234567890,1900);
insert into cuentas(num_ba,num_su,control,num_cu,saldo)
values ('0001','0001','11',1234567891,1600);
insert into cuentas(num_ba,num_su,control,num_cu,saldo)
values ('0001','0002','12',1234567892,2300);
insert into cuentas(num_ba,num_su,control,num_cu,saldo)
values ('0002','0001','13',1234567893,15000);
insert into cuentas(num_ba,num_su,control,num_cu,saldo)
values ('0002','0001','14',1234567894,23000);
insert into cuentas(num_ba,num_su,control,num_cu,saldo)
values ('0002','0001','15',1234567895,14200);
insert into cuentas(num_ba,num_su,control,num_cu,saldo)
values ('0001','0001','16',1234567896,11900);
insert into trabajadores(id_persona,nombre,apellido1,apellido2,telefono,direccion,nivel)
values (1,'Marcelo','Quiron','Crespo','601010101','Avda Los Angeles 12 2ºA','A');
insert into trabajadores(id_persona,nombre,apellido1,apellido2,telefono,direccion,nivel)
values (2,'Martina','Salazar','Merino','602020202','C/Dulce pastora 18','A');
insert into trabajadores(id_persona,nombre,apellido1,apellido2,telefono,direccion,nivel)
values (3,'Luisa','Marin','Cobreces','603030303','Plaza Roja 3ºC','B');
insert into sucursal(num_ba, num_su, direccion)
values ('0001','0001','C/Mayor 30');
insert into sucursal(num_ba, num_su, direccion)
values ('0001','0002','C/San Luis s/n');
insert into sucursal(num_ba, num_su, direccion)
values ('0002','0001','C/Mayor 60');

