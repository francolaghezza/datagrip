--Práctica 45 SQL
--1 Piezas que valen más que la media de todas las piezas
select tipo,modelo,to_char(PRECIO_VENTA,'990D00L') as Precio
from PIEZAS
where PRECIO_VENTA >
      (select avg(PRECIO_VENTA)
        from PIEZAS);
--2 Piezas que suministran proveedores de Madrid y Barcelona
SELECT tipo,modelo
FROM suministros NATURAL JOIN empresas
WHERE provincia='Barcelona'
AND (TIPO,MODELO) IN (
  SELECT
    tipo,
    modelo
  FROM suministros
    NATURAL JOIN empresas
  WHERE provincia = 'Madrid'
);
--2 modo 2
SELECT tipo,modelo
FROM suministros
NATURAL JOIN empresas
WHERE provincia='Barcelona'
INTERSECT
SELECT tipo,modelo
FROM suministros
NATURAL JOIN empresas
WHERE provincia = 'Madrid';
--3 Piezas que sólo están disponibles en el almacén 3
select tipo,MODELO
from EXISTENCIAS
where N_ALMACEN=3
minus
select tipo,MODELO
from EXISTENCIAS
where N_ALMACEN!=3;
--4 Almacenes cuya dirección coincide
select A.N_ALMACEN as Almacen,A.DIRECCION
from ALMACENES A cross join ALMACENES A2
WHERE A2.N_ALMACEN!=A.N_ALMACEN AND length(A2.DIRECCION)=length(A.DIRECCION)
GROUP BY A.N_ALMACEN,A.DIRECCION;
--5 Piezas que no suministra ningún proveedor
select P.tipo,P.modelo
from PIEZAS P
left outer join SUMINISTROS S on P.TIPO = S.TIPO and P.MODELO = S.MODELO
WHERE CIF IS NULL;
--6 Puntas (tipo PU) que solo son suministradas por proveedores de Valladolid
select TIPO,MODELO
from SUMINISTROS S join EMPRESAS E on S.CIF = E.CIF
where TIPO='PU' intersect
select TIPO,MODELO
from SUMINISTROS S join EMPRESAS E on S.CIF = E.CIF
where PROVINCIA='Valladolid'
minus
select TIPO,MODELO
from  SUMINISTROS S join EMPRESAS E on S.CIF = E.CIF
where PROVINCIA!='Valladolid';
--7 Piezas que tenemos en al menos dos almacenes
select TIPO,MODELO,count(*) as Almacenes
from EXISTENCIAS
having count(*)>=2
group by tipo, modelo;
--8 Piezas en los almacenes 1 y 2 pero no en el 3
(select tipo,MODELO
from EXISTENCIAS
where N_ALMACEN=1
intersect
select tipo,MODELO
from EXISTENCIAS
where N_ALMACEN=2)
minus
select tipo,MODELO
from EXISTENCIAS
where N_ALMACEN=3;
---9 Empresas que suministran piezas que no tenemos en los almacenes
select nombre,tipo,modelo
from empresas
join suministros using(cif)
where (tipo,modelo) in (
  select tipo,MODELO
  from suministros
  minus
  select tipo,MODELO
  from existencias
);
--9 OTRA FORMA
select nombre,tipo,modelo
from empresas
join suministros using(cif)
join (
  select tipo,MODELO
  from suministros
  minus
  select tipo,MODELO
  from existencias
) using(tipo,modelo);
---10 Empresa que suministra más tipos y modelos de piezas
--Opcion 1, MAX(COUNT)
SELECT nombre, COUNT(*)
FROM empresas
NATURAL JOIN suministros
GROUP BY nombre
HAVING COUNT(*)=(
  SELECT MAX(COUNT(*))
  FROM empresas
  NATURAL JOIN suministros
  GROUP BY nombre);
--Opcion 2, ALL
SELECT nombre, COUNT(*)
FROM empresas
NATURAL JOIN suministros
GROUP BY nombre
HAVING COUNT(*)>=ALL(
  SELECT COUNT(*)
  FROM empresas
  NATURAL JOIN suministros
  GROUP BY nombre);
--11 Empresas que venden la misma cantidad de piezas
--Primer resultado, filas separadas
SELECT nombre, COUNT(*)
FROM empresas e
NATURAL JOIN suministros
GROUP BY nombre
HAVING COUNT(*) IN (
  SELECT COUNT(*)
  FROM empresas
  NATURAL JOIN suministros
  WHERE e.nombre!=nombre
  GROUP BY nombre);
--Segundo resultado, misma fila
SELECT s1.nombre, s2.nombre,s1.cuenta
FROM (
  SELECT nombre, COUNT(*) as Cuenta
  FROM empresas e
  NATURAL JOIN suministros
  GROUP BY nombre
) s1
CROSS JOIN (
  SELECT nombre, COUNT(*) as Cuenta
  FROM empresas e
  NATURAL JOIN suministros
  GROUP BY nombre
) s2
WHERE s1.cuenta=s2.cuenta AND s1.nombre<s2.nombre;
--12 Pedido más caro
SELECT n_pedido, fecha, nombre as empresa, SUM(cantidad*precio)||'€' as "Importe Total"
FROM pedidos
NATURAL JOIN lineas_pedido
NATURAL JOIN empresas
GROUP BY n_pedido, fecha, nombre
HAVING SUM(cantidad*precio)=(
  SELECT MAX(SUM(cantidad*precio))
  FROM pedidos
  NATURAL JOIN lineas_pedido
  NATURAL JOIN empresas
  GROUP BY n_pedido, fecha, nombre);
--13 Pedido más caro y más barato
SELECT n_pedido, fecha, nombre as empresa, SUM(cantidad*precio)||'€' as "Importe Total"
FROM pedidos
NATURAL JOIN lineas_pedido
NATURAL JOIN empresas
GROUP BY n_pedido, fecha, nombre
HAVING SUM(cantidad*precio)=(
  SELECT MAX(SUM(cantidad*precio))
  FROM pedidos
  NATURAL JOIN lineas_pedido
  NATURAL JOIN empresas
  GROUP BY n_pedido, fecha, nombre
) OR SUM(cantidad*precio)=(
  SELECT MIN(SUM(cantidad*precio))
  FROM pedidos
  NATURAL JOIN lineas_pedido
  NATURAL JOIN empresas
  GROUP BY n_pedido, fecha, nombre);