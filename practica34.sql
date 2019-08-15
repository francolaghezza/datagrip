--1
select FECHA_PRESTAMO,sysdate-FECHA_PRESTAMO from PRESTAMOS order by FECHA_PRESTAMO desc;
--2
select FECHA_PRESTAMO,N_COPIA,FECHA_TOPE,FECHA_ENTREGA from PRESTAMOS where FECHA_ENTREGA is null;
--3
select ID_PRESTAMO,DNI,FECHA_ENTREGA from PRESTAMOS where extract(month from FECHA_ENTREGA)=extract(month from sysdate);
--4
select dni,to_char(FECHA_ENTREGA,'fmdd/month/yyyy') as FechaEntrega,to_char(FECHA_PRESTAMO,'fmdd/month/yyyy') as FechaPrestamo,to_char(FECHA_TOPE,'fmdd/month/yyyy') as FechaTope from PRESTAMOS;
--5
select TITULO from PELICULAS where TITULO not like '% %';
--6
select TITULO from PELICULAS where TITULO not like '% % %' and TITULO like '% %';
--7
select TITULO,CRITICA from PELICULAS;
select titulo,critica from PELICULAS where  length(TITULO)>length(CRITICA) ;
--8
select upper(translate(TITULO,'áéíóúÁÉÍÓÚ','aeiouAEIOU'))as TITULO from PELICULAS;
--9
select TITULO,AÑO from PELICULAS where substr(AÑO,1,1)+substr(AÑO,2,1)+substr(AÑO,3,1)+substr(AÑO,4,1)<10;
--10
select nvl(substr(TITULO,1,instr(titulo,' ',1,3)),titulo) as TituloComprimido from PELICULAS;
--11
select NOMBRE from CLIENTES where substr(upper(NOMBRE),1,1) in ('A','E') or substr(upper(NOMBRE),3,1) in ('A','E') or substr(upper(NOMBRE),5,1) in ('A','E');
--12
select instr(TITULO,'a',1) from PELICULAS where  TITULO not like '% %';