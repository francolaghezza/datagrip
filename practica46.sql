---PRÁCTICA 46 SUBSELECT TRENES
---1 Trenes que pasan por Palencia
select cod_dia as Dias_semana,count(*) as Total_trenes
from DIAS join TRENES using (cod_tren)
          join PARADAS using (cod_tren)
          join ESTACIONES using (cod_est)
where LOCALIDAD='PALENCIA'
group by COD_DIA;

--2 Código de los trenes que pasan por Villalba de Guadarrama y por Venta de Baños
select COD_TREN as Tren
from TRENES join PARADAS using (cod_tren)
            join ESTACIONES using (cod_est)
where LOCALIDAD='VILLALBA DE GUADARRAMA'
INTERSECT
select COD_TREN as Tren
from TRENES join PARADAS using (cod_tren)
            join ESTACIONES using (cod_est)
WHERE LOCALIDAD='VENTA DE BAÑOS';
--3 Código de los trenes que salen los lunes y no salen los domingos
select T.COD_TREN as Tren
from TRENES T join DIAS D on T.COD_TREN = D.COD_TREN
where COD_DIA=1
minus
select T.COD_TREN as Tren
from TRENES T join DIAS D on T.COD_TREN = D.COD_TREN
where COD_DIA=7;
--4 Trenes que pasan por Miranda de Ebro
select COD_TREN as Codigo,cod_tipo as Tipo,
       decode(cod_dia,
          1,'Lunes',
          2,'Martes',
          3,'Miércoles',
          4,'Jueves',
          5,'Viernes',
          6,'Sábado',
          7,'Domingo') as Dias,to_char(HORA,'HH24:MI') as Hora
from TRENES join PARADAS using (cod_tren)
            join TIPOS_TREN using (cod_tipo)
            join DIAS using (cod_tren)
            join ESTACIONES using (cod_est)
where LOCALIDAD='MIRANDA DE EBRO';
--5 Estaciones por las que pasan más trenes
select NOMBRE,count(*) as Total
from ESTACIONES join PARADAS P on ESTACIONES.COD_EST = P.COD_EST
GROUP BY NOMBRE
order by Total desc;
--6 Estaciones que tienen un nombre de más de una palabra
select NOMBRE
from ESTACIONES
where regexp_like(NOMBRE,' ');
--7 Día en el que menos trenes pasan por Palencia
select  decode(cod_dia,
          1,'Lunes',
          2,'Martes',
          3,'Miércoles',
          4,'Jueves',
          5,'Viernes',
          6,'Sábado',
          7,'Domingo') as Dia,count(*) as Trenes
from DIAS join TRENES using (cod_tren) join PARADAS using (cod_tren)
            join ESTACIONES using (cod_est)
where LOCALIDAD='PALENCIA'
group by COD_DIA
having count(COD_DIA)>=all(
  select count(*) as Trenes
  from DIAS join TRENES using (cod_tren) join PARADAS using (cod_tren)
            join ESTACIONES using (cod_est)
  where LOCALIDAD='PALENCIA'
  group by COD_DIA
  );
--8 Código del tren que hace más paradas y qué paradas hace
select COD_TREN,count(*)as Paradas
from PARADAS
group by COD_TREN
having count(*)=(
  select max(count(*))
  from PARADAS
  group by COD_TREN
  );
--9 Nombre de las paradas que hace ese tren así como la hora y minuto en la que pasa por dicha parada
SELECT nombre,to_char(hora,'hh24:mi') FROM estaciones
NATURAL JOIN paradas
WHERE cod_tren IN(
  SELECT cod_tren
  FROM  paradas
  GROUP BY cod_tren
  HAVING count(*)>=(
      SELECT MAX(COUNT(*))
      FROM  paradas
      GROUP BY cod_tren
  )
)
ORDER BY n_parada;
--10 Mostrar los códigos de trenes que pasan por VENTA DE BAÑOS de 3:00 a 7:59:59 de la mañana y que luego pasan por MADRID
SELECT cod_tren
FROM PARADAS p
NATURAL JOIN ESTACIONES
WHERE LOCALIDAD='VALLADOLID' AND EXTRACT(HOUR FROM HORA) BETWEEN 3 AND 7
AND COD_TREN IN(
    SELECT cod_tren
    FROM PARADAS P2
    NATURAL JOIN ESTACIONES
    WHERE localidad='MADRID' and p2.n_parada>p.n_parada
);
--10 con EXISTS
select COD_TREN
from PARADAS p join ESTACIONES e using(cod_est)
where extract(hour from HORA)>=3 and extract(hour from HORA)<8
and LOCALIDAD='VENTA DE BAÑOS'
and exists (
  select COD_TREN
  from PARADAS p2 join ESTACIONES e2 using(cod_est)
  where LOCALIDAD='MADRID' and p2.N_PARADA>p.N_PARADA and p.COD_TREN=p2.COD_TREN);
--11 Mostrar los códigos de trenes que pasan por Valladolid los lunes, martes y miércoles antes de las 12:00
SELECT cod_tren
FROM paradas
NATURAL JOIN estaciones
NATURAL JOIN dias
WHERE localidad='VALLADOLID' and extract(hour from hora)<12
AND cod_dia in (1,2,3)
GROUP BY cod_tren
HAVING count(DISTINCT cod_dia)=3;
--12 Mostrar el código de los trenes que van de Madrid a Valladolid sin parar en ningún sitio más
SELECT cod_tren
FROM paradas
NATURAL JOIN estaciones
WHERE localidad='MADRID' and n_parada=1
INTERSECT
SELECT cod_tren
FROM paradas
NATURAL JOIN estaciones
WHERE localidad='VALLADOLID' and n_parada=2;
--13 SQL DEVELOPER
SELECT cod_tren, localidad, nombre estacion, to_char(hora,'hh24:mi') hora
FROM
    (SELECT cod_tren
    FROM PARADAS p
    NATURAL JOIN ESTACIONES
    WHERE UPPER(LOCALIDAD)=UPPER('&&localidad1' )
    AND COD_TREN IN(
          SELECT cod_tren
          FROM PARADAS P2
          NATURAL JOIN ESTACIONES
          WHERE UPPER(localidad)=UPPER('&&localidad2') and p2.n_parada>p.n_parada
        )
    )
NATURAL JOIN paradas
NATURAL JOIN estaciones
WHERE UPPER(localidad)=UPPER('&localidad1' ) or UPPER(localidad)=UPPER('&localidad2')
order by cod_tren,hora;