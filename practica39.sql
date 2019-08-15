----Práctica 39 SQL
----1
select TIPO,MODELO,sum(CANTIDAD) as Cantidad
from EXISTENCIAS
group by tipo, modelo
order by Cantidad desc;
---2
select TIPO,MODELO,to_char(avg(PRECIO_compra),'0D000L') as Precio
FROM suministros
GROUP BY TIPO, MODELO
order by Precio asc;
---3
SELECT E.NOMBRE,COUNT(*) as Total
FROM EMPRESAS E,SUMINISTROS S
where E.CIF=S.CIF
GROUP BY NOMBRE
order by NOMBRE;
---4
select L.N_PEDIDO,N_LINEA,nombre as Empresa,localidad,provincia,
       to_char(FECHA,'dd/mm/yyyy')as Fecha,TIPO,MODELO,CANTIDAD,
       to_char(PRECIO,'0D000L') AS PRECIO,
       to_char(CANTIDAD*PRECIO,'0D000L') as Total
from EMPRESAS E join PEDIDOS P on E.CIF = P.CIF join LINEAS_PEDIDO L on P.N_PEDIDO = L.N_PEDIDO;
---5
select L.N_PEDIDO,nombre,localidad,provincia,
       to_char(FECHA,'dd/mm/yyyy')as Fecha,
       to_char(sum(cantidad*precio),'00D000L')
from EMPRESAS E join PEDIDOS P on E.CIF = P.CIF join LINEAS_PEDIDO L on P.N_PEDIDO = L.N_PEDIDO
group by l.n_pedido,nombre,localidad,provincia,fecha
order by L.N_PEDIDO;
---6
select N_PEDIDO, max(N_LINEA)
from pedidos p
join LINEAS_PEDIDO using(n_pedido)
group by n_pedido
having max(n_linea)=1
order by 1,2;
---7
select * from EMPRESAS;
select count(*) as Cuantas,NOMBRE,(substr(DIRECCION,1)) as direccion
from EMPRESAS
having substr(DIRECCION,1,2)='c/' or substr(DIRECCION,1,2)='C/'
group by NOMBRE,DIRECCION;
---8
select substr(NOMBRE,1,1) as Empieza_por, count(*) as Numero
from EMPRESAS
group by substr(NOMBRE,1,1)
order by Empieza_por;
---9
select to_char(FECHA, 'fmmonth "de" YYYY') as fecha,count(*) as Pedidos
from PEDIDOS
group by to_char(FECHA, 'fmmonth "de" YYYY')
order by fecha;