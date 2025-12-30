# Proyecto Data Analytics – Pipeline ETL + Dashboard de Ventas

## 📌 Descripción del proyecto
Este proyecto consiste en el desarrollo de un **pipeline ETL completo** para el análisis de ventas, partiendo de archivos CSV (datos crudos), procesándolos mediante Python y SQL Server, y finalizando con la visualización de KPIs estratégicos en **Power BI**.

El objetivo principal es transformar datos desordenados en información confiable que permita **analizar el desempeño comercial y apoyar la toma de decisiones**.

---

## 🎯 Objetivo del dashboard
Con el objetivo de **incrementar las ventas en un 10% en los próximos 6 meses**, se definieron y analizaron los siguientes KPIs:

- Ventas totales
- Ventas por producto
- Ventas por tienda
- Ventas por cliente
- Margen de beneficio (%)
- Tendencia de ventas en el tiempo
- Identificación de productos estrella

---

## 🧰 Tecnologías utilizadas

### 🔹 Lenguajes y herramientas
- **Python**
  - pandas
  - pyodbc
- **SQL Server**
  - Stored Procedures
  - Tablas Staging, Intermedias y Data Warehouse
- **Power BI**
  - DAX
  - Visualizaciones interactivas
- **Git & GitHub**
  - Control de versiones
  - Documentación del proyecto

---

## 🗂️ Arquitectura del proyecto

```text
data/
└── raw/                 → Archivos CSV originales

src/
├── load_staging_*.py    → Carga de datos a staging
├── dwh/
│   └── load_dwh_*.py    → Ejecución de SP hacia DWH
├── main.py              → Orquestación del proceso ETL
├── conexion.py          → Conexión a SQL Server
└── utils.py             → Logging y utilidades

sql/
├── staging/             → Creación de tablas STG
├── intermediate/        → Stored Procedures INT
└── dwh/                 → Tablas y SP finales del DWH

dashboard/
└── ventas_dashboard.pbix
