# RetailPro – Pre-entregas

Proyecto de análisis de datos para **RetailPro**, un negocio minorista de tecnología que migra sus datos desde planillas de Excel a una base de datos relacional para luego analizarlos en Power BI. Este repositorio reúne las pre-entregas del curso: el modelo de datos en SQL Server (`Ventas_Tech_DB`), las consultas de negocio y de JOINs, y el modelo en Power BI.

## Herramientas utilizadas

- **SQL Server** como motor de base de datos
- **SQL Server Management Studio (SSMS)** para ejecutar los scripts
- **Power BI Desktop** para el modelo de datos y el dashboard (archivo `.pbix`)
- **Git y GitHub** para el control de versiones

## Contenido del repositorio

| Archivo | Descripción |
|---|---|
| `ventas_tech_db.sql` | Crea la base `Ventas_Tech_DB`, sus tablas (`categorias`, `clientes`, `productos`, `ventas`), carga datos de prueba y verifica con `SELECT` |
| `m4_consultas_negocio.sql` | Consultas de negocio sobre `ventas`: resumen mensual, ranking de productos (Top 5), clientes recurrentes y productos por encima/debajo del promedio, más 3 hallazgos finales |
| `m5_consultas_joins.sql` | Consultas con JOINs: vista base con INNER JOIN, clientes sin ventas y productos sin ventas (LEFT JOIN) y consolidado por canal (UNION ALL) |
| `Pipeline_ETL_Parmigiani_Valentino.pbix` | Modelo de datos en Power BI con relaciones, tabla de fechas y medidas DAX |

## Cómo ejecutar los scripts SQL

1. Cloná el repositorio:
   ```bash
   git clone https://github.com/ValentinoPar/pre-entregas-coder.git
   ```
2. Abrí **SSMS** y conectate a tu instancia de SQL Server.
3. Ejecutá los scripts **en este orden**, porque cada uno depende del anterior:
   1. `ventas_tech_db.sql`: crea la base y carga los datos.
   2. `m4_consultas_negocio.sql`: consultas sobre la tabla `ventas`.
   3. `m5_consultas_joins.sql`: consultas que cruzan tablas.
4. Verificá la carga: al final de `ventas_tech_db.sql` hay un `SELECT *` por tabla.

## Autor

Valentino Parmigiani - 2026.
