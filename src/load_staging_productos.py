import pandas as pd
from conexion import sql_conn
from utils import log

def cargar_stg_productos(csv_path: str):
    log("Leyendo CSV de productos (RAW)")
    df = pd.read_csv(csv_path)

    # # --- LIMPIEZA MÍNIMA  ---
    # Columnas numéricas
    cols_numericas = ['PrecioCosto', 'PrecioVentaSugerido']

    for col in cols_numericas:
        df[col] = pd.to_numeric(df[col], errors='coerce')

    # relleno con la mediana, me hace problemas en sql server por los NaN
    df['PrecioCosto'] = df['PrecioCosto'].fillna(df['PrecioCosto'].median())
    df['PrecioVentaSugerido'] = df['PrecioVentaSugerido'].fillna(
        df['PrecioVentaSugerido'].median()
    )

    # NaN -> None (para SQL)
    df = df.where(pd.notnull(df), None)

    with sql_conn() as conn:
        cursor = conn.cursor()

        log("Limpiando tabla Stg_Dim_Producto")
        cursor.execute("TRUNCATE TABLE Stg_Dim_Producto")

        log("Insertando datos en Stg_Dim_Producto")

        for _, row in df.iterrows():
            cursor.execute("""
                INSERT INTO Stg_Dim_Producto (
                    CodigoProducto,
                    Descripcion,
                    Categoria,
                    Marca,
                    PrecioCosto,
                    PrecioVentaSugerido
                )
                VALUES (?, ?, ?, ?, ?, ?)
            """,
            row["CodigoProducto"],
            row["Descripcion"],
            row["Categoria"],
            row["Marca"],
            row["PrecioCosto"],
            row["PrecioVentaSugerido"]
            )
    log("Carga STAGING Productos OK")
      
            

