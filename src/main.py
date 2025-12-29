from load_staging_clientes import cargar_stg_clientes
from load_staging_productos import cargar_stg_productos
from load_staging_tiendas import cargar_stg_tiendas
from load_staging_ventas import cargar_stg_ventas
from dwh.load_dwh_clientes import cargar_clientes
from dwh.load_dwh_productos import cargar_productos
from dwh.load_dwh_tiendas import cargar_tiendas
from dwh.load_dwh_ventas import cargar_ventas

def main():
    proceso_id = 1

    cargar_stg_clientes("data/raw/clientes.csv")
    cargar_stg_productos("data/raw/productos.csv")
    cargar_stg_tiendas("data/raw/tiendas.csv")
    cargar_stg_ventas()

    cargar_clientes(proceso_id)
    cargar_productos(proceso_id)
    cargar_tiendas(proceso_id)
    cargar_ventas(proceso_id)

if __name__ == "__main__":
    main()
