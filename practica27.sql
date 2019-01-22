create table jugadores(
  id_jugador number(3) constraint jugadores_pk primary key,
  nombre varchar2(50) constraint jugadores_nn1 not null,
  fecha_nac date,
  id_equipo number(2)
);
create table equipos(
  id_equipo number(2) constraint equipos_pk primary key ,
  nombre varchar2(50) constraint equipos_uk1 unique
                    constraint equipos_nn1 not null ,
  estadio varchar2(50) constraint equipos_uk2 unique ,
  aforo number(6),
  ano_fundacion number(4),
  ciudad varchar2(50)
);
alter table jugadores add constraint jugadores_fk1 foreign key (id_equipo) references equipos on delete set null;

create table partidos(
  id_equipo_casa number(2) constraint partidos_fk1 references equipos on delete cascade,
  id_equipo_fuera number(2) constraint partidos_fk2 references equipos,
  fecha timestamp,
  goles_casa number(2),
  goles_fuera number(2),
  observaciones varchar2(1000)
);
alter table partidos add constraint partidos_pk primary key (id_equipo_casa,id_equipo_fuera);
create table goles(
  id_equipo_casa number(2),
  id_equipo_fuera number(2),
  minuto interval day to second,
  descripcion varchar2(1000),
  id_jugador number(3) constraint goles_fk2 references jugadores
);
alter table goles add constraint goles_pk primary key (id_equipo_casa,id_equipo_fuera);
alter table goles add constraint goles_fk1 foreign key (id_equipo_casa,id_equipo_fuera) references partidos;