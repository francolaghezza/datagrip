--2--
SELECT * FROM existencias;
--3--
SELECT tipo,modelo,n_almacen
FROM existencias
ORDER BY tipo,modelo,n_almacen;
--4--
SELECT tipo,modelo
FROM existencias
ORDER BY tipo,modelo;
--5--
SELECT tipo,modelo
FROM existencias
GROUP BY tipo,modelo;
--6--
SELECT tipo,modelo, SUM(cantidad)
FROM existencias
GROUP BY tipo,modelo;
--7--
SELECT tipo,SUM(cantidad)
FROM existencias
GROUP BY tipo;
--8--
SELECT SUM(cantidad)
FROM existencias;
--9--
SELECT tipo,modelo,(cantidad)
FROM existencias
WHERE (cantidad)>1500
GROUP BY tipo,modelo;
--10--
SELECT tipo,modelo, SUM(cantidad)
FROM existencias
GROUP BY tipo,modelo
HAVING SUM(cantidad)>1500;
--11--
SELECT tipo,modelo, SUM(cantidad)
FROM existencias
WHERE tipo IN ('AR','CL')
GROUP BY tipo,modelo
HAVING SUM(cantidad)>1500
ORDER BY SUM(cantidad) DESC;