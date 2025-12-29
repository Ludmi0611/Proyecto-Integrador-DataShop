from conexion import sql_conn
from utils import log

def cargar_productos(proceso_id: int):
    with sql_conn() as conn:
        cursor = conn.cursor()

        log("Cargando INT Dim Producto")
        cursor.execute("{CALL SP_Carga_Int_Dim_Producto(?)}", (proceso_id,))

        log("Cargando Dim Producto")
        cursor.execute("{CALL SP_Carga_Dim_Producto(?)}", (proceso_id,))