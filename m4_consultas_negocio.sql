-- ══════════════════════════════════════════════════════════
-- TechStore / RetailPro — m4_consultas_negocio.sql
-- Pre-entrega: Consultas SQL de negocio (Módulo 4)
-- Motor: SQL Server
-- ══════════════════════════════════════════════════════════
use ventas_tech_DB;
select * from ventas;

-- ── Consulta 1: Resumen ejecutivo mensual ──────────────────
-- Total facturado, cantidad de pedidos y ticket promedio por mes.
select
sum(cantidad * precio_unitario) as total_facturado,
count(*) as cantidad_pedidos,
avg(cantidad * precio_unitario) as ticket_promedio,
month(fecha_venta) as mes
from ventas
group by month(fecha_venta)
order by mes;

-- ── Consulta 2: Ranking de productos (Top 5) ───────────────
-- Productos que más facturación generaron, con sus unidades vendidas.
select top 5
id_producto ,
sum(cantidad)  AS unidades_vendidas,
sum(cantidad * precio_unitario) as total_facturado
from ventas
group by id_producto
order by total_facturado desc;

-- ── Consulta 3: Clientes recurrentes ───────────────────────
-- Clientes con más de un pedido, con su cantidad de pedidos y gasto total.
select
id_cliente,
count(*) as cantidad_de_pedidos,
sum(cantidad * precio_unitario) as total_gastado
from ventas
group by id_cliente
having COUNT(*) > 1
order by total_gastado desc;

-- ── Consulta 4: Meses por encima/por debajo del promedio ───
-- Compara el total de cada mes contra el promedio general de todos los meses.
with total_mensuales as (
select
month(fecha_venta) as mes,
sum(cantidad * precio_unitario) as total_mes
from ventas
group by month(fecha_venta)
)
select 
mes,
total_mes,
case 
when total_mes > (select avg (total_mes) from total_mensuales) 
then 'por encima'
else 'por debajo'
end as comparacion_promedio
from total_mensuales
order by mes;

-- ══════════════════════════════════════════════════════════
-- Hallazgos
-- ══════════════════════════════════════════════════════════
-- 1. El producto 1 (Laptop Pro 15) concentra $3.600 de los $6.444
--    totales facturados (~56%), siendo el que más factura pese a
--    tener solo 3 unidades vendidas: lo explica su alto precio
--    unitario, no el volumen (a diferencia del producto 2, que
--    vendió 13 unidades pero factura apenas $364).
-- 2. Los 5 clientes cargados hicieron exactamente 2 pedidos cada
--    uno, por lo que la Consulta 3 devuelve el 100% de la base:
--    con esta muestra, "cliente recurrente" es la norma, no la
--    excepción.
-- 3. Todas las ventas cargadas corresponden a marzo de 2024 (un
--    único mes), por lo que la Consulta 4 compara ese mes contra
--    sí mismo: el total de marzo ($6.444) coincide exactamente
--    con el promedio general, y como la condición usa ">"
--    estricto, el resultado etiqueta ese mes como "por debajo"
--    en vez de un empate. Con ventas de más de un mes, esta
--    consulta mostraría variación real entre meses.