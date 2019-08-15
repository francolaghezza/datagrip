---Práctica 40 SQL
---1
SELECT N_ALMACEN,TIPO,MODELO
FROM EXISTENCIAS
WHERE CANTIDAD>=1000 AND CANTIDAD<=2000;
---2 SQL 92
select P.TIPO,P.MODELO,TO_CHAR(PRECIO_VENTA,'0D00L')as precio,N_ALMACEN,CANTIDAD
from PIEZAS P,EXISTENCIAS E
where P.TIPO= E.TIPO and P.MODELO= E.MODELO;
--2 SQL 99
select tipo,modelo,to_char(PRECIO_VENTA,'0D00L') as Precio,N_ALMACEN,CANTIDAD
from PIEZAS p
natural join EXISTENCIAS e;
--3 sql 92
select E.NOMBRE,E.LOCALIDAD,S.TIPO,S.MODELO,to_char(S.PRECIO_COMPRA,'0d000l') as precio
from EMPRESAS E,SUMINISTROS S
where e.CIF=s.CIF;
--3 sql 99
select NOMBRE,LOCALIDAD,TIPO,MODELO,to_char(S.PRECIO_COMPRA,'0d000l') as precio
from EMPRESAS e
natural join SUMINISTROS s;
--4 sql 92
select E.NOMBRE,S.TIPO,S.MODELO,to_char(P.PRECIO_VENTA,'0d000l') as precio_compra,
       to_char(S.PRECIO_COMPRA,'0d000l') as precio_venta
from EMPRESAS E,SUMINISTROS S,PIEZAS P
where e.CIF=s.CIF and s.TIPO=p.TIPO and s.MODELO=p.MODELO and PRECIO_COMPRA>PRECIO_VENTA;
--4 sql 99
select NOMBRE,TIPO,MODELO,to_char(PRECIO_VENTA,'0d000l') as precio_compra,
       to_char(S.PRECIO_COMPRA,'0d000l') as precio_venta
from EMPRESAS E
join SUMINISTROS S using (cif)
join PIEZAS P using (tipo,modelo)
where PRECIO_COMPRA>PRECIO_VENTA;
--5 sql 92
select P.N_PEDIDO,E.NOMBRE,to_char(P.FECHA, 'fmday dd "de" month "de" YYYY') as fecha
from PEDIDOS P,EMPRESAS E
where p.cif=e.CIF;
--5 sql 99
select N_PEDIDO,NOMBRE,to_char(FECHA, 'fmday dd "de" month "de" YYYY') as fecha
from EMPRESAS E
join PEDIDOS P using (cif);
--6 sql 92
select P.N_PEDIDO,E.NOMBRE,to_char(P.FECHA,  '"Trimestre" q ') ||
                            substr(to_char(P.FECHA, 'day dd'),1,3) ||
                           to_char(P.FECHA,  'fm dd"#"mm"#"YYYY') as fecha
from PEDIDOS P,EMPRESAS E
where p.cif=e.CIF;
--6 sql 99
select N_PEDIDO,NOMBRE,to_char(FECHA,  '"Trimestre" q ') ||
                     substr(to_char(FECHA, 'day dd'),1,3) ||
                     to_char(FECHA,  'fm dd"#"mm"#"YYYY') as fecha
from EMPRESAS E
join PEDIDOS P using (cif);
--7
select NOMBRE,TELEFONO
from EMPRESAS
where substr(TELEFONO,-1)=1 or substr(TELEFONO,-1)=3 or substr(TELEFONO,-1)=5 or substr(TELEFONO,-1)=6;
--8
select NOMBRE,TELEFONO
from EMPRESAS
where mod(substr(TELEFONO,3,1),2)=0;
--8 Función REGEXP_LIKE
select NOMBRE,TELEFONO
from EMPRESAS
where regexp_like(telefono,'^..[02468]');
--9
select PROVINCIA
from EMPRESAS
where PROVINCIA is not null
group by PROVINCIA;
--10
select TIPO,MODELO,to_char(PRECIO_VENTA,'0D000L') as Precio_sin_iva,
       to_char(PRECIO_VENTA*1.21,'0D000L') as Precio_con_iva
from PIEZAS;
--11 SQL 92
select A.DESCRIPCION,E.CANTIDAD,P.TIPO,P.MODELO,
       to_char(P.PRECIO_VENTA,'0D000L') as Precio,
       case when A.N_ALMACEN=1 then 'Primer almacen'
              when A.N_ALMACEN=2 then 'Segundo almacen'
          when A.N_ALMACEN=3 then 'Tercer almacen'
         end as Numero_almacen
from ALMACENES A,
     EXISTENCIAS E,
     PIEZAS P
where P.TIPO = E.TIPO
  and P.MODELO = E.MODELO
  and E.N_ALMACEN = A.N_ALMACEN
order by A.N_ALMACEN,P.TIPO,P.MODELO;
--11 SQL 99
select DESCRIPCION,CANTIDAD,TIPO,MODELO,
       to_char(PRECIO_VENTA,'0D000L') as Precio,
       case when N_ALMACEN=1 then 'Primer almacen'
              when N_ALMACEN=2 then 'Segundo almacen'
          when N_ALMACEN=3 then 'Tercer almacen'
         end as Numero_almacen
from ALMACENES A
join EXISTENCIAS E using (n_almacen)
join PIEZAS P using (tipo,modelo)
order by N_ALMACEN,TIPO,MODELO;
--12
select NOMBRE,TELEFONO
from EMPRESAS
where length(replace(TELEFONO,' '))<'9'
   or substr(TELEFONO,1,1) not in (6,7,9);
--12 REGEXP_LIKE
select NOMBRE,TELEFONO
from EMPRESAS
where not regexp_like(telefono,'[679][0-9]{8}');
--13
select TIPO,MODELO
FROM PIEZAS P
LEFT JOIN EXISTENCIAS E USING(tipo,modelo)
WHERE N_ALMACEN IS NULL;
--14
select TIPO,MODELO,nvl(to_char(N_ALMACEN),'Sin almacen') as n_almacen
FROM PIEZAS P
LEFT JOIN EXISTENCIAS E USING(tipo,modelo)
ORDER BY TIPO,MODELO,nvl(to_char(N_ALMACEN),'Sin almacen');
--15 SQL 99
select E.NOMBRE as Empresa1, E2.NOMBRE as Empresa2,E.PROVINCIA
from EMPRESAS E
join EMPRESAS E2 on E.PROVINCIA=E2.PROVINCIA and E.NOMBRE>E2.NOMBRE
group by E.nombre,E2.nombre,E.provincia;

