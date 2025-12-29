import pandas as pd
from conexion import sql_conn
from utils import log

def cargar_stg_ventas():
    log("Leyendo CSV de ventas (RAW)")

    df1 = pd.read_csv("data/raw/ventas.csv")
    df2 = pd.read_csv("data/raw/ventas_add.csv")
    df3 = pd.read_csv("data/raw/ventas_marzo_abril.csv")

    
    df = pd.concat([df1, df2, df3], ignore_index=True)

    log("Limpieza técnica mínima")

    
    df["FechaVenta"] = pd.to_datetime(df["FechaVenta"])
    df["Cantidad"] = df["Cantidad"].astype("Int64")

    # NaN -> None (para SQL)
    df = df.where(pd.notnull(df), None)

    with sql_conn() as conn:
        cursor = conn.cursor()

        log("Limpiando tabla Stg_Fact_Ventas")
        cursor.execute("TRUNCATE TABLE Stg_Fact_Ventas")

        log("Insertando datos en Stg_Fact_Ventas")

        for _, row in df.iterrows():
            cursor.execute("""
                INSERT INTO Stg_Fact_Ventas (
                    FechaVenta,
                    CodigoProducto,
                    Producto,
                    Cantidad,
                    PrecioVenta,
                    CodigoCliente,
                    Cliente,
                    CodigoTienda,
                    Tienda
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            row["FechaVenta"],
            row["CodigoProducto"],
            row["Producto"],
            row["Cantidad"],
            row["PrecioVenta"],
            row["CodigoCliente"],
            row["Cliente"],
            row["CodigoTienda"],
            row["Tienda"]
            )
            
    log("Carga STAGING Ventas OK")
