
--EJERCICIO 1
create table canales(
  id_canal number(2) constraint canales_pk primary key,
  nomnbre varchar2(50) constraint canales_uk1 unique
                    constraint canales_nn1 not null
);
create table programas(
  id_prg number(4) constraint programas_pk primary key ,
  nombre varchar2(50) constraint programas_nn1 not null
                      constraint programas_uk1 unique ,
  es_serie char(1) constraint programas_nn2 not null
                  constraint programas_ck1 check (es_serie='S' or es_serie='N')
);
alter table programas
modify es_serie DEFAULT 'S';
