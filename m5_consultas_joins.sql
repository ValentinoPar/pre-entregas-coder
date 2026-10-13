-- Cruzando tablas para enriquecer el análisis
USE ventas_tech_DB;
--Consulta 1 — Vista base del proyecto (INNER JOIN)
select
    v.fecha_venta,
    c.id_cliente,
    c.nombre,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
from dbo.ventas as v
inner join dbo.productos as p
on v.id_producto=p.id_producto
inner join dbo.clientes as c
on v.id_cliente=c.id_cliente
inner join dbo.categorias as cat
on p.id_categoria=cat.id_categoria
;

--Consulta 2 — Clientes sin ventas (LEFT JOIN)
select
c.nombre,
c.email,
c.fecha_registro
from dbo.clientes as c
left join dbo.ventas as v
on c.id_cliente=v.id_cliente
WHERE v.id_cliente IS NULL;

--Consulta 3 — Productos sin ventas (LEFT JOIN) 
select
p.nombre_producto,
cat.nombre_categoria,
p.precio
from dbo.productos as p
INNER JOIN dbo.categorias AS cat 
ON p.id_categoria = cat.id_categoria
left join dbo.ventas as v
on p.id_producto=v.id_producto
where v.id_venta IS NULL;

-- Consulta 4 — Consolidado por canal (UNION ALL)

SELECT canal, SUM(total) AS total_canal
FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Online' AS canal
    FROM dbo.ventas 
    WHERE id_cliente in (1,2,3)
    UNION ALL
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Presencial' AS canal
    FROM dbo.ventas 
    WHERE id_cliente not in (1,2,3)
) AS consolidado
GROUP BY canal;
