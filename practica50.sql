---Práctica 50 NBA Franco David Laghezza
--1
select ID_EQUIPO_LOCAL as ID_Equipo,ciudad||' '||E.NOMBRE as Nombre,PUNTOS_LOCAL as Puntos_favor,
       PUNTOS_VISITA as Puntos_contra,decode(sign(PUNTOS_LOCAL-PUNTOS_VISITA),1,1,-1,0) as Ganado,--sign devuelve el signo
       D.NOMBRE as Division,C.NOMBRE as Conferencia,nvl(PRORROGAS,0) as Prorrogas,
       P.INICIO_TEMP||'-'||substr(P.FIN_TEMP,3) as Temporada
from PARTIDOS P join EQUIPOS E on P.ID_EQUIPO_LOCAL = E.ID_EQUIPO
join DIVISIONES D on E.ID_DIVISION = D.ID_DIVISION join CONFERENCIAS C using (id_conferencia)
union all
select ID_EQUIPO_VISITA,ciudad||' '||E.NOMBRE,PUNTOS_VISITA,PUNTOS_LOCAL,
       decode(sign(PUNTOS_VISITA-PUNTOS_LOCAL),1,1,-1,0),D.NOMBRE,C.NOMBRE,nvl(PRORROGAS,0),
       P.INICIO_TEMP||'-'||substr(P.FIN_TEMP,3)
from PARTIDOS P join EQUIPOS E on P.ID_EQUIPO_VISITA = E.ID_EQUIPO
join DIVISIONES D on E.ID_DIVISION = D.ID_DIVISION join CONFERENCIAS C using (id_conferencia);
--3
select EQUIPO,DIVISION,CONFERENCIA,TEMPORADA,sum(GANADO) as Ganado,count(*)-sum(GANADO) as Perdido
from TABLA_RESULTADOS
group by EQUIPO,division,CONFERENCIA,TEMPORADA
order by TEMPORADA,Ganado desc;
--4
SELECT DIVISION,EQUIPO,sum(GANADO) as Ganado
from TABLA_RESULTADOS t
where TEMPORADA='2017-18'
group by DIVISION,EQUIPO
having sum(GANADO)>=all (
  select sum(GANADO)
  from TABLA_RESULTADOS t2
  where TEMPORADA=(
    select max(TEMPORADA)
     from TABLA_RESULTADOS t2)
             and t2.DIVISION=t.DIVISION
  group by DIVISION,EQUIPO
       );
--5
select EQUIPO,to_char(FECHA,'fmMonth')||','||extract(year from FECHA) as Fecha,
       sum(GANADO) as Ganado,count(*)-sum(GANADO) as Perdido
from TABLA_RESULTADOS
group by EQUIPO,to_char(FECHA,'fmMonth')||','||extract(year from FECHA)
having count(*)-sum(GANADO)=0 and sum(GANADO)>5;
--6
