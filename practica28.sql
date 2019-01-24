---ejercicio1
create table usuarios(
  id_u number(20) constraint usuarios_pk primary key ,
  usuario varchar2(30) constraint usuarios_uk1 unique
                      constraint usuarios_nn1 not null ,
  e_mail varchar2(60)  constraint usuarios_uk2 unique
                       constraint usuarios_nn2 not null ,
  nombre varchar2(30) constraint usuarios_nn3 not null ,
  apellido1 varchar2(30) constraint usuarios_nn4 not null ,
  apellido2 varchar2(30),
  passw varchar2(100) constraint usuarios_nn5 not null
);
create table contactos(
  id_u number(20),
  contacto number(20)
);
alter table contactos add constraint contactos_ck1 check (id_u!=contacto);
alter table contactos add constraint contactos_ck2 check (contacto!=id_u);
create table post(
  id_u number(20) constraint post_fk1 references usuarios
                  constraint post_nn2 not null,
  pid number(20) constraint post_pk primary key ,
  texto varchar2(1000) constraint post_nn1 not null ,
  pid_rel number(20) constraint post_fk2 references post on delete set null,
  publicacion date constraint post_nn3 not null ,
  duracion interval day to second
);
create table ser_visible(
  id_u number(20),
  contacto number(20),
  pid number(20) constraint ser_visible_fk2 references post
);
alter table ser_visible add constraint ser_visible_pk primary key (id_u,contacto);
alter table contactos add constraint contactos_pk primary key (id_u,contacto);
alter table ser_visible add constraint ser_visible_fk1 foreign key (id_u,contacto) references
                            contactos;
alter table contactos add constraint costactos_fk1 foreign key (id_u) references usuarios;
alter table contactos add constraint contactos_fk2 foreign key (contacto) references usuarios on delete cascade;
alter table post add constraint post_ck1 check (publicacion>=to_date('02/02/2017','dd/mm/yyyy'));
---ejercicio 2
alter table post add constraint post_ck2 check (duracion>=interval '30'minute);
rename ser_visible to compartir;
alter table usuarios rename constraint usuarios_pk to superclave;
alter table usuarios disable constraint usuarios_nn5;
alter table post add (visible char(2) default 'SI');
alter table post modify (publicacion default SYSDATE);
--ejercicio3
insert into usuarios (id_u,usuario,e_mail,nombre,apellido1,apellido2)
values (1,'ramongar','ramon@hotmail.com','Ramon','Garcia','Ortigal');
insert into usuarios (id_u,usuario,e_mail,nombre,apellido1)
values (2,'lurdita','lurdita@bbc.co.uk','Lourdes','Atienza');
insert into usuarios (id_u,usuario,e_mail,nombre,apellido1,apellido2)
values (3,'marioso','marioso19@yahoo.com','Marisol','Jiménez','del Oso');
insert into usuarios (id_u,usuario,e_mail,nombre,apellido1,apellido2)
values (4,'sercal','sercal1980@gmail.com','Francisco','Serrano','Calvo');
commit;
update usuarios set passw=12345;
update usuarios set e_mail='superlourdes@gmail.com' where e_mail='lurdita@bbc.co.uk';
delete from usuarios where usuario='ramongar';
select usuario from usuarios;