from conexion import sql_conn
from utils import log

def cargar_tiendas(proceso_id: int):
    with sql_conn() as conn:
        cursor = conn.cursor()

        log("Cargando INT Dim Tienda")
        cursor.execute("{CALL SP_Carga_Int_Dim_Tienda(?)}", (proceso_id,))

        log("Cargando Dim Tienda")
        cursor.execute("{CALL SP_Carga_Dim_Tienda(?)}", (proceso_id,))