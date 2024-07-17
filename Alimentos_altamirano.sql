DROP DATABASE IF EXISTS alimentos_altamirano;
CREATE DATABASE alimentos_altamirano;
USE alimentos_altamirano;

-- Creación de Tablas de acuerdo al detalle listado en PDF--
-- Tabla Marcas --
CREATE TABLE marca (
	cod_marca INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(10) NOT NULL
);
-- Tabla Articulos --
CREATE TABLE articulos (
	cod_articulo VARCHAR(10) PRIMARY KEY,
    art_descripcion VARCHAR(100) NOT NULL,
    cod_marca INT UNSIGNED NOT NULL,
    FOREIGN KEY (cod_marca) REFERENCES marca(cod_marca),
    peso_unitario DECIMAL(7,2) NOT NULL
);
-- Tabla Lista de Precios --
CREATE TABLE lista_de_precios (
	cod_lp VARCHAR(10) PRIMARY KEY,
    nombre_lista VARCHAR(20) NOT NULL,
    cod_articulo VARCHAR(10) NOT NULL,
    FOREIGN KEY (cod_articulo) REFERENCES articulos(cod_articulo),
    precio_unitario DECIMAL(7,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_finalizacion DATE NOT NULL
);
-- Tabla Zona --
CREATE TABLE zona (
	cod_zona INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    zona VARCHAR(10) NOT NULL
);
-- Tabla Comisiones --
CREATE TABLE comisiones (
	cod_comision INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    comision DECIMAL(5,2) NOT NULL
);
-- Tabla Vendedores --
CREATE TABLE vendedores (
	cod_vendedor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    cod_zona INT UNSIGNED NOT NULL,
    FOREIGN KEY (cod_zona) REFERENCES zona(cod_zona),
	cod_comision INT UNSIGNED NOT NULL,
    FOREIGN KEY (cod_comision) REFERENCES comisiones(cod_comision)
);
-- Tabla Categorias --
CREATE TABLE categorias (
	cod_categoria INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo_cliente VARCHAR(50) NOT NULL
);
-- Tabla Clientes --
CREATE TABLE clientes (
	cod_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    razon_social VARCHAR(100) NOT NULL,
    cod_categoria INT UNSIGNED NOT NULL,
    FOREIGN KEY (cod_categoria) REFERENCES categorias(cod_categoria)
);
-- Tabla Tipo Comprobantes --
CREATE TABLE tipo_comprobantes (
	id_tipo_comp INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo_comp VARCHAR(20) NOT NULL
);
-- Tabla Ventas --
CREATE TABLE ventas (
	fecha_emision DATE,
	id_comprobante INT UNSIGNED AUTO_INCREMENT,
    comp_nro VARCHAR(50) UNIQUE,
    id_tipo_comp INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_tipo_comp) REFERENCES tipo_comprobantes(id_tipo_comp),
    cod_cliente INT UNSIGNED NOT NULL,
    FOREIGN KEY (cod_cliente) REFERENCES clientes(cod_cliente),
    razon_social VARCHAR(100) NOT NULL,
    imp_facturado DECIMAL(12,2) NOT NULL,
	cod_vendedor INT UNSIGNED NOT NULL,
    FOREIGN KEY (cod_vendedor) REFERENCES vendedores(cod_vendedor),
    PRIMARY KEY (id_comprobante, comp_nro)
);
-- Tabla Ventas por articulo --
CREATE TABLE ventas_por_articulo (
	id_vta_art INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    comp_nro VARCHAR(50) UNIQUE NOT NULL,
    FOREIGN KEY (comp_nro) REFERENCES ventas(comp_nro),
    cod_articulo VARCHAR(10) NOT NULL,
    FOREIGN KEY (cod_articulo) REFERENCES articulos(cod_articulo),
    item_cantidad INT NOT NULL,
    importe_neto DECIMAL(12,2) NOT NULL,
	cod_lp VARCHAR(10) NOT NULL,
    FOREIGN KEY (cod_lp) REFERENCES lista_de_precios(cod_lp)
);
