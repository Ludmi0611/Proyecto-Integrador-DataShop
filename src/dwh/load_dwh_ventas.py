from conexion import sql_conn
from utils import log

def cargar_ventas(proceso_id: int):
    with sql_conn() as conn:
        cursor = conn.cursor()

        log("Cargando INT Fact Ventas")
        cursor.execute("{CALL SP_Carga_Int_Fact_Ventas(?)}", (proceso_id,))

        log("Cargando Fact Ventas")
        cursor.execute("{CALL SP_Carga_Fact_Ventas(?)}", (proceso_id,))