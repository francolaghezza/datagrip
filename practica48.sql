--PRÁCTICA 48 Franco David Laghezza
--1 Días de diferencia entre la fecha actual y el último pedido realizado
create view Dias_diferencia as (select round(sysdate-max(FECHA)) as Dias_Diferencia
from pedidos);
select * from Dias_diferencia;
update pedidos set fecha=fecha+(select round(sysdate-max(FECHA));
select fecha from pedidos;
--2
create table piezas2 as(
select tipo||'-'||modelo as Tipo_modelo,to_char(precio_venta,'90D00L') as Precio_venta
       ,cif,nombre,localidad,provincia,to_char(precio_compra,'90D00L') as Precio_compra
from suministros s join piezas p using (tipo,modelo)
                   join empresas e using (cif));
--3
drop table piezas2;
--4 Los proveedores de Cantabria han incrementado un 15% el precio de compra de cada pieza
update suministros
set precio_compra=precio_compra*1.15
where cif in (
  select cif
  from empresas
  where provincia = 'Cantabria'
);
--5 Nuevo almacén
insert into ALMACENES (N_ALMACEN, DESCRIPCION, DIRECCION)
values (4,'Almacén gigante','Calle nueva 1');
select * from ALMACENES;
--piezas del almacén 3 cuya cantidad sea mayor que la media de cantidades de las piezas en ese almacén
update EXISTENCIAS
set n_almacen=4
where N_ALMACEN=3 and CANTIDAD>
                      (
                        select avg(CANTIDAD) from EXISTENCIAS where N_ALMACEN=3
                        );
select * from EXISTENCIAS where N_ALMACEN=4;
--6 Eliminar de nuestra base de datos la empresa “Castelar y Bunyol”
alter table SUMINISTROS disable constraint SUMINISTROS_FK2;
delete from EMPRESAS
where NOMBRE='Castelar i Bunyol';
--7 La empresa ‘Suministros de Castilla’ ha decidido hacer un descuento del 20% en todos los pedidos
update LINEAS_PEDIDO
set PRECIO=PRECIO*0.8
where n_pedido in(
select n_pedido from PEDIDOS p
  join EMPRESAS e using (cif)
  where NOMBRE='Suministros de Castilla');
--8 Crea una tabla llamada descatalogadas con las tipo y modelo como clave principal
create table descatalogadas(
  tipo char(9),
  modelo number (3)
);
alter table descatalogadas add constraint descatalogadas_pk primary key (tipo,modelo);
--9 Rellena la tabla anterior con las piezas que ya no vende nadie
insert into descatalogadas(tipo,modelo)
select TIPO,MODELO
FROM PIEZAS P
LEFT JOIN SUMINISTROS S USING(tipo,modelo)
where PRECIO_COMPRA is null;
select * from descatalogadas;
--10 Elimina de la tabla de piezas, las piezas descatalogadas
DELETE FROM piezas
where (TIPO,MODELO) in (
    SELECT tipo,MODELO
    from DESCATALOGADAS
);
SELECT TO_CHAR(FECHA,'fmDay dd "de" Month "de" yyyy') as Fecha
FROM PEDIDOS;

select max(to_char(Precio_venta,'90D00'))||' '||'Ptas' as Pieza_más_cara
from PIEZAS;
select DISTINCT PRECIO_VENTA from PIEZAS;