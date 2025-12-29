import pandas as pd
from conexion import sql_conn
from utils import log

def cargar_stg_clientes(csv_path: str):
    log("Leyendo CSV de clientes (RAW)")
    df = pd.read_csv(csv_path)

    # --- LIMPIEZA MÍNIMA PARA STAGING ---
    df["CP"] = df["CP"].astype("Int64").astype(str)
    df["Telefono"] = df["Telefono"].astype("Int64").astype(str)

    # NaN -> None (para SQL)
    df = df.where(pd.notnull(df), None)

    with sql_conn() as conn:
        cursor = conn.cursor()

        log("Limpiando tabla Stg_Dim_Cliente")
        cursor.execute("TRUNCATE TABLE Stg_Dim_Cliente")

        log("Insertando datos en Stg_Dim_Cliente")

        for _, row in df.iterrows():
            cursor.execute("""
                INSERT INTO Stg_Dim_Cliente (
                    CodCliente,
                    RazonSocial,
                    Telefono,
                    Mail,
                    Direccion,
		            Localidad,
                    Provincia,
		            CP
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """,
            row["CodCliente"],
            row["RazonSocial"],
            row["Telefono"],
            row["Mail"],
            row["Direccion"],
            row["Localidad"],
            row["Provincia"],
            row["CP"]
            )
    log("Carga STAGING Clientes OK")
            

