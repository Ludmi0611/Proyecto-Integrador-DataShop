import pandas as pd
from conexion import sql_conn
from utils import log

def cargar_stg_tiendas(csv_path: str):
    log("Leyendo CSV de tiendas (RAW)")
    df = pd.read_csv(csv_path)

    # # --- LIMPIEZA MÍNIMA  ---
    df["CP"] = df["CP"].astype("Int64").astype(str)

    # NaN -> None (para SQL)
    df = df.where(pd.notnull(df), None)


    with sql_conn() as conn:
        cursor = conn.cursor()

        log("Limpiando tabla Stg_Dim_Tienda")
        cursor.execute("TRUNCATE TABLE Stg_Dim_Tienda")

        log("Insertando datos en Stg_Dim_Tienda")

        for _, row in df.iterrows():
            cursor.execute("""
                INSERT INTO Stg_Dim_Tienda (
                    CodigoTienda,
                    Descripcion,
                    Direccion,
                    Localidad,
                    Provincia,
                    CP,
                    TipoTienda
                )
                VALUES (?, ?, ?, ?, ?, ?, ?)
            """,
            row["CodigoTienda"],
            row["Descripcion"],
            row["Direccion"],
            row["Localidad"],
            row["Provincia"],
            row["CP"],
            row["TipoTienda"]
            )
    log("Carga STAGING Tiendas OK")