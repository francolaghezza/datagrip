---ejercicio 1
create table articulos(
  cod_art char(7) constraint articulos_pk primary key ,
  nombre varchar2(40) constraint articulos_nn1 not null ,
  marca varchar2(20) constraint articulos_nn2 not null ,
  modelo varchar2(15) constraint articulos_nn3 not null
);
create table secciones(
  id_sec number(3) constraint secciones_pk primary key ,
  id_supersec number(3),
  nombre varchar2(40) constraint secciones_uk1 unique
                      constraint secciones_nn1 not null
);
alter table secciones add constraint secciones_fk1 foreign key (id_supersec) references secciones;
create table pertenecer(
  cod_art char(7),
  id_sec number(3)
);
alter table pertenecer add constraint pertencer_pk primary key (cod_art,id_sec);
alter table pertenecer add constraint pertencer_fk1 foreign key (cod_art) references articulos;
alter table pertenecer add constraint pertenecer_fk2 foreign key (id_sec) references secciones;
create table precios(
  fecha_inicio date,
  fecha_fin date,
  cod_art char(7) constraint precios_fk1 references articulos,
  precio number(7,2)
);
alter table precios add constraint precios_pk primary key (fecha_inicio,cod_art);
alter table precios add constraint precios_ck1 check (precio>0);
alter table precios add constraint precios_ck2 check (fecha_inicio<fecha_fin);
---ejercicio 2
alter table secciones add constraint secciones_ck1 check (id_supersec!=id_sec);
alter table articulos add constraint articulos_ck1 check (modelo like '%-%');
alter table precios add constraint precios_ck3 check (fecha_inicio>=to_date('1/1/2015','dd/mm/yyyy')
                                                        and fecha_inicio<=to_date('31/12/2015','dd/mm/yyyy'));
alter table precios add constraint precios_ck3 check (fecha_inicio>=to_date('1/1/2015','dd/mm/yyyy')
                                                        and fecha_inicio<=to_date('31/12/2015','dd/mm/yyyy'));
alter table articulos modify(nombre varchar2(50));
rename precios to precios_historicos;
alter table precios_historicos rename column fecha_fin to fecha_final;
alter table articulos drop constraint articulos_nn1;
drop table secciones cascade constraints ;