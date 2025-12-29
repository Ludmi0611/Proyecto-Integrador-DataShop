from conexion import sql_conn
from utils import log

def cargar_clientes(proceso_id: int):
    with sql_conn() as conn:
        cursor = conn.cursor()

        log("Cargando INT Dim Cliente")
        cursor.execute("{CALL SP_Carga_Int_Dim_Cliente(?)}", (proceso_id,))

        log("Cargando Dim Cliente")
        cursor.execute("{CALL SP_Carga_Dim_Cliente(?)}", (proceso_id,))
