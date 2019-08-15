--Practica 41 GEPGRAFÍA
--1 SQL 92
select L.NOMBRE,L.POBLACION,P.nombre
from  LOCALIDADES L, PROVINCIAS P
where L.N_PROVINCIA=P.N_PROVINCIA;
--1 SQL 99
select PROVINCIAS.NOMBRE as Provicia,LOCALIDADES.NOMBRE as localidad,POBLACION
from LOCALIDADES
join PROVINCIAS using (n_provincia);
--2 SQL 92
select P.NOMBRE as provincia,L.NOMBRE as capital
from PROVINCIAS P,LOCALIDADES L
where P.ID_CAPITAL=L.ID_LOCALIDAD;
--2 SQL 99
select PROVINCIAS.NOMBRE,LOCALIDADES.NOMBRE
from LOCALIDADES
join PROVINCIAS on LOCALIDADES.ID_LOCALIDAD = PROVINCIAS.ID_CAPITAL;
--3 SQL 32
select L.NOMBRE,P.NOMBRE,C.NOMBRE
from LOCALIDADES L,PROVINCIAS P,COMUNIDADES C
where L.N_PROVINCIA=P.N_PROVINCIA and P.ID_COMUNIDAD=C.ID_COMUNIDAD;
--3 SQL 99
select L.NOMBRE as localidad,P.NOMBRE as provincia,C.NOMBRE as comunidad
from LOCALIDADES L
join PROVINCIAS P using (n_provincia)
join COMUNIDADES C using (id_comunidad);
--4 SQL 92
select L.NOMBRE as localidad,CA.NOMBRE as Capital_provincia,P.NOMBRE as provincia,C.NOMBRE as comunidad
from LOCALIDADES L,PROVINCIAS P,COMUNIDADES C,LOCALIDADES CA
where L.N_PROVINCIA=P.N_PROVINCIA and P.ID_COMUNIDAD=C.ID_COMUNIDAD and CA.ID_LOCALIDAD=P.ID_CAPITAL;
--4 SQL 99
select L.NOMBRE as localidad,CA.NOMBRE as Capital_provincia,P.NOMBRE as provincia,C.NOMBRE as comunidad
from PROVINCIAS P
join LOCALIDADES L  using (n_provincia)
join COMUNIDADES C using (id_comunidad)
join LOCALIDADES CA on CA.ID_LOCALIDAD=P.ID_CAPITAL;
--5 SQL 92
select L.NOMBRE as localidad,
       CA.NOMBRE as Capital_provincia,
       P.NOMBRE as provincia,
       C.NOMBRE as comunidad,
       CP.NOMBRE as capital_comunidad
from LOCALIDADES L,PROVINCIAS P,COMUNIDADES C,LOCALIDADES CA,LOCALIDADES CP
where L.N_PROVINCIA=P.N_PROVINCIA and
      P.ID_COMUNIDAD=C.ID_COMUNIDAD and
      CA.ID_LOCALIDAD=P.ID_CAPITAL and
      C.ID_CAPITAL=CP.ID_LOCALIDAD;
--5 SQL 99
select L.NOMBRE as localidad,
       CA.NOMBRE as Capital_provincia,
       P.NOMBRE as provincia,
       C.NOMBRE as comunidad,
       CP.NOMBRE as capital_comunidad
from PROVINCIAS P
join LOCALIDADES L  using (n_provincia)
join COMUNIDADES C using (id_comunidad)
join LOCALIDADES CA on CA.ID_LOCALIDAD=P.ID_CAPITAL
join LOCALIDADES CP on CP.ID_LOCALIDAD=C.ID_CAPITAL;
--6 SQL 92
select L.NOMBRE,L.POBLACION
from LOCALIDADES L, PROVINCIAS P
where L.ID_LOCALIDAD=P.ID_CAPITAL and L.POBLACION>200000;
--7 SQL 92
select L.NOMBRE,L.POBLACION
from LOCALIDADES L, COMUNIDADES C
WHERE L.ID_LOCALIDAD=C.ID_CAPITAL and L.POBLACION>200000;
--8 SQL 92
select L.NOMBRE as localidad,
       CA.NOMBRE as Capital_provincia,
       P.NOMBRE as provincia,
       C.NOMBRE as comunidad
from LOCALIDADES L,PROVINCIAS P,COMUNIDADES C,LOCALIDADES CA
where L.N_PROVINCIA=P.N_PROVINCIA and
      P.ID_COMUNIDAD=C.ID_COMUNIDAD and
      CA.ID_LOCALIDAD=P.ID_CAPITAL and
      L.POBLACION>CA.POBLACION;
--8 SQL 99
select L.NOMBRE as localidad,
       CA.NOMBRE as Capital_provincia,
       P.NOMBRE as provincia,
       C.NOMBRE as comunidad
from PROVINCIAS P
join LOCALIDADES L  using (n_provincia)
join COMUNIDADES C using (id_comunidad)
join LOCALIDADES CA on CA.ID_LOCALIDAD=P.ID_CAPITAL
where L.POBLACION>CA.POBLACION;
--9 SQL 92
select L.NOMBRE as localidad,
       P.NOMBRE as provincia
from LOCALIDADES L,PROVINCIAS P
where L.N_PROVINCIA=P.N_PROVINCIA and
      L.ID_LOCALIDAD!=P.ID_CAPITAL;
--9 SQL 99
select L.NOMBRE as localidad,
       P.NOMBRE as provincia
from PROVINCIAS P
join LOCALIDADES L  using (n_provincia)
where L.ID_LOCALIDAD!=P.ID_CAPITAL;
--10 SQL 92
select L.NOMBRE as localidad,
       P.NOMBRE as provincia
from LOCALIDADES L,PROVINCIAS P
where L.N_PROVINCIA=P.N_PROVINCIA and
      L.ID_LOCALIDAD=P.ID_CAPITAL and
      L.NOMBRE!=P.NOMBRE;
--10 SQL 99
select L.NOMBRE as localidad,
       P.NOMBRE as provincia
from PROVINCIAS P
join LOCALIDADES L  using (n_provincia)
where L.ID_LOCALIDAD=P.ID_CAPITAL and L.NOMBRE!=P.NOMBRE;
--11 SQL 92
select C1.NOMBRE as Comunidad_1,C2.NOMBRE as Comunidad_2
from COMUNIDADES C1,COMUNIDADES C2
where length(C1.NOMBRE)=length(C2.NOMBRE) and C1.NOMBRE!=C2.NOMBRE;
--11 SQL 99
select C1.NOMBRE as Comunidad_1,C2.NOMBRE as Comunidad_2
from COMUNIDADES C1
join COMUNIDADES C2 on C1.NOMBRE!=C2.NOMBRE
where length(C1.NOMBRE)=length(C2.NOMBRE)
group by C1.NOMBRE,C2.NOMBRE;
--12 SQL 92
SELECT C.NOMBRE as Nombre,count(P.NOMBRE)as Numero
FROM PROVINCIAS P,COMUNIDADES C
where P.ID_COMUNIDAD=c.ID_COMUNIDAD
group by C.NOMBRE
order by Nombre asc;
--12 SQL 99
SELECT C.NOMBRE as Nombre,count(P.NOMBRE)as Numero
FROM PROVINCIAS P join COMUNIDADES C using (id_comunidad)
group by C.NOMBRE
order by Nombre asc;
--13 SQL 92
SELECT P.NOMBRE,count(L.NOMBRE)as Numero
FROM PROVINCIAS P,LOCALIDADES L
where P.N_PROVINCIA=l.N_PROVINCIA and P.NOMBRE='Palencia'
group by P.NOMBRE;
--14 SQL 92
SELECT C.NOMBRE as comunidad,count(L.NOMBRE)as Numero
from LOCALIDADES L,PROVINCIAS P,COMUNIDADES C
where l.N_PROVINCIA=p.N_PROVINCIA and P.ID_COMUNIDAD=C.ID_COMUNIDAD
group by C.NOMBRE
order by Numero desc;
--14 SQL 99
SELECT C.NOMBRE as comunidad,count(L.NOMBRE)as Numero
from LOCALIDADES L join PROVINCIAS P using (n_provincia)
join COMUNIDADES C using (id_comunidad)
group by C.NOMBRE
order by Numero desc;
--15 SQL 92
select P.NOMBRE as provincia ,count(L.NOMBRE)as Numero
from PROVINCIAS P,LOCALIDADES L
where L.N_PROVINCIA=P.N_PROVINCIA and L.POBLACION>10000
group by P.NOMBRE
ORDER BY Numero asc;
--15 SQL 99
select P.NOMBRE as provincia ,count(L.NOMBRE)as Numero
from PROVINCIAS P join LOCALIDADES L using (n_provincia)
where L.POBLACION>10000
group by P.NOMBRE
order by Numero asc;
--16 SQL 92
SELECT max(count(*))as Máximo
from LOCALIDADES L,PROVINCIAS P
where L.N_PROVINCIA=P.N_PROVINCIA
group by  P.NOMBRE;
--16 SQL 99
SELECT MAX(COUNT(*)) as Máximo
FROM localidades l
JOIN provincias p USING(n_provincia)
GROUP BY p.nombre;
--17 SQL 92
select P.NOMBRE,sum(L.POBLACION) as poblacion
from PROVINCIAS P,COMUNIDADES C,LOCALIDADES L
where L.ID_LOCALIDAD=P.ID_CAPITAL and
      P.ID_COMUNIDAD=C.ID_COMUNIDAD and
      C.NOMBRE='Castilla y León'
group by p.NOMBRE,l.POBLACION
order by poblacion desc;
--17 SQL 99
select P.NOMBRE,sum(L.POBLACION) as poblacion
from LOCALIDADES L join PROVINCIAS P on L.ID_LOCALIDAD = P.ID_CAPITAL
join COMUNIDADES C on P.ID_COMUNIDAD=C.ID_COMUNIDAD
and  C.NOMBRE='Castilla y León'
group by p.NOMBRE,l.POBLACION
order by poblacion desc;
--18 SQL 92
select L.NOMBRE,P.NOMBRE,L.POBLACION as poblacion
from LOCALIDADES L,PROVINCIAS P,COMUNIDADES C
where L.N_PROVINCIA=P.N_PROVINCIA and P.ID_COMUNIDAD=C.ID_COMUNIDAD
and C.NOMBRE='Castilla y León'
group by L.NOMBRE,P.NOMBRE,L.POBLACION
order by poblacion desc;
--18 SQL 99
select L.NOMBRE,P.NOMBRE,L.POBLACION as poblacion
from LOCALIDADES L join PROVINCIAS P on L.N_PROVINCIA=P.N_PROVINCIA
join COMUNIDADES C on P.ID_COMUNIDAD=C.ID_COMUNIDAD and C.NOMBRE='Castilla y León'
group by L.NOMBRE,P.NOMBRE,L.POBLACION
order by poblacion desc;
--19 SQL 92
select L.NOMBRE,P.NOMBRE,L.POBLACION as poblacion
from LOCALIDADES L,PROVINCIAS P,COMUNIDADES C
where L.N_PROVINCIA=P.N_PROVINCIA and
      P.ID_COMUNIDAD=C.ID_COMUNIDAD and
      L.ID_LOCALIDAD!=P.ID_CAPITAL
and C.NOMBRE='Castilla y León'
group by L.NOMBRE,P.NOMBRE,L.POBLACION
order by poblacion desc;
--19 SQL 99
select L.NOMBRE,P.NOMBRE,L.POBLACION as poblacion
from LOCALIDADES L join PROVINCIAS P on L.N_PROVINCIA=P.N_PROVINCIA
join COMUNIDADES C on P.ID_COMUNIDAD=C.ID_COMUNIDAD and
                      C.NOMBRE='Castilla y León' and
                      L.ID_LOCALIDAD!=P.ID_CAPITAL
group by L.NOMBRE,P.NOMBRE,L.POBLACION
order by poblacion desc;
--20 SQL 92
select P.NOMBRE,count(*) as localidades
from PROVINCIAS P, LOCALIDADES L
where L.N_PROVINCIA=P.N_PROVINCIA
group by P.NOMBRE
having count(*)>200
order by localidades desc;
--20 SQL 99
SELECT p.nombre, COUNT(*) AS localidades
FROM localidades l
JOIN provincias p USING(n_provincia)
GROUP BY p.nombre
HAVING COUNT(*)>200;
--21 SQL 92
select P.NOMBRE as Provincia,to_char(P.SUPERFICIE,'9G999G999')||' '||'km2' as Superficie,
                to_char(L.POBLACION,'9G999G999')||' '||'h' as Poblacion
from PROVINCIAS P,LOCALIDADES L
where P.ID_CAPITAL=L.ID_LOCALIDAD
order by Provincia;
--21 SQL 99
select P.NOMBRE as Provincia,to_char(P.SUPERFICIE,'9G999G999' ||'')||' '||'km2' as Superficie,
                to_char(L.POBLACION,'9G999G999')||' '||'h' as Poblacion
from PROVINCIAS P join LOCALIDADES L on P.ID_CAPITAL = L.ID_LOCALIDAD
order by Provincia;
--22 SQL 92
select P.NOMBRE as Provincia,to_char(L.POBLACION/P.SUPERFICIE,'9G999D000')||' '||'h/km2' as Densidad
from PROVINCIAS P,LOCALIDADES L
where P.ID_CAPITAL=L.ID_LOCALIDAD
order by Provincia;
--22 SQL 99
select P.NOMBRE as Provincia,to_char(L.POBLACION/P.SUPERFICIE,'9G999D000')||' '||'h/km2' as Densidad
from LOCALIDADES L join PROVINCIAS P on P.ID_CAPITAL=L.ID_LOCALIDAD
order by Provincia;
--23 SQL 92
select C.NOMBRE,to_char(L.POBLACION,'9G999G999')||' '||'h' as poblacion
from LOCALIDADES L ,COMUNIDADES C
where L.ID_LOCALIDAD=C.ID_CAPITAL
order by C.NOMBRE;
--23 SQL 99
select C.NOMBRE,to_char(L.POBLACION,'9G999G999')||' '||'h' as poblacion
from LOCALIDADES L join COMUNIDADES C on L.ID_LOCALIDAD = C.ID_CAPITAL
order by C.NOMBRE;
--24 SQL 99
SELECT  L.nombre, L.poblacion
FROM LOCALIDADES L
CROSS JOIN (
	SELECT nombre,poblacion
	FROM LOCALIDADES
	WHERE nombre='Palencia'
) P
WHERE L.poblacion>P.poblacion
ORDER BY L.poblacion;
--25 SQL 99
SELECT  p.nombre, sum(l.poblacion) poblacion
FROM localidades l
JOIN provincias p USING(n_provincia)
CROSS JOIN (
	SELECT p.nombre,sum(poblacion) poblacion
	FROM localidades l
	JOIN provincias p USING(n_provincia)
	WHERE p.nombre='Guipuzcoa'
  GROUP BY p.nombre
) g
GROUP BY p.nombre, g.poblacion
HAVING sum(l.poblacion)>g.poblacion
ORDER BY sum(l.poblacion);

---Comunidades uniproviciales o multiprovinciales
SELECT nombre,
  DECODE(
         (SELECT COUNT(*)
          FROM comunidades
          JOIN provincias USING (id_comunidad)
          WHERE id_comunidad=c.id_comunidad
          GROUP BY id_comunidad
	  ),
       1,'Uniprovincial', 'Multiprovincial'
      ) as tipo_comunidad
FROM comunidades c;

---cross join
SELECT  p.nombre, sum(l.poblacion) poblacion
FROM localidades l
JOIN provincias p USING(n_provincia)
CROSS JOIN (
	SELECT p.nombre,sum(poblacion) poblacion
	FROM localidades l
	JOIN provincias p USING(n_provincia)
	WHERE p.nombre='Guipuzcoa'
  GROUP BY p.nombre
) g
GROUP BY p.nombre, g.poblacion
HAVING sum(l.poblacion)>g.poblacion
ORDER BY sum(l.poblacion);

-----------------Con subselect
select p.nombre,sum(l.poblacion) as Población
from PROVINCIAS P join LOCALIDADES L using (N_PROVINCIA)
group by p.NOMBRE
having sum(l.poblacion) >
  (select sum(l.poblacion)
    from LOCALIDADES l join PROVINCIAS p using (n_provincia)
    where p.nombre='Guipuzcoa'
    group by p.NOMBRE)
order by Población;








