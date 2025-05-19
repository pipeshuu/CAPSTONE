CREATE TABLE "producto"(
    "producto_id" BIGINT NOT NULL,
    "sku" VARCHAR(100) NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT NULL,
    "unidad_medida" VARCHAR(50) NULL,
    "peso" DECIMAL(10, 2) NULL,
    "categoria_id" BIGINT NOT NULL,
    "image_url" VARCHAR(255) NOT NULL,
    "precio" BIGINT NOT NULL
);
ALTER TABLE
    "producto" ADD PRIMARY KEY("producto_id");
ALTER TABLE
    "producto" ADD CONSTRAINT "producto_sku_unique" UNIQUE("sku");
CREATE TABLE "bodega"(
    "bodega_id" BIGINT NOT NULL,
    "nombre" TEXT NOT NULL,
    "direccion" TEXT NULL,
    "tipo" VARCHAR(20) NOT NULL,
    "parent_bodega_id" BIGINT NULL
);
ALTER TABLE
    "bodega" ADD PRIMARY KEY("bodega_id");
ALTER TABLE
    "bodega" ADD CONSTRAINT "bodega_nombre_unique" UNIQUE("nombre");
CREATE TABLE "empleado"(
    "empleado_id" BIGINT NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellidos" TEXT NULL,
    "cargo_id" BIGINT NOT NULL,
    "usuario_sistema_id" BIGINT NOT NULL,
    "bodega_id" BIGINT NOT NULL,
    "usuario_id" BIGINT NOT NULL
);
ALTER TABLE
    "empleado" ADD PRIMARY KEY("empleado_id");
CREATE TABLE "inventario"(
    "inv_id" BIGINT NOT NULL,
    "producto_id" BIGINT NOT NULL,
    "bodega_id" BIGINT NOT NULL,
    "cantidad_actual" INTEGER NOT NULL,
    "cantidad_maxima" INTEGER NOT NULL,
    "pocision" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "inventario" ADD PRIMARY KEY("inv_id");
CREATE TABLE "movimiento"(
    "mov_id" BIGINT NOT NULL,
    "inv_id" BIGINT NOT NULL,
    "detalle_sol_id" BIGINT NOT NULL,
    "tipo_mov" VARCHAR(20) NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "fecha_creacion" TIMESTAMP(0) WITH
        TIME zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "fecha_modificacion" TIMESTAMP(0) WITHOUT TIME ZONE NULL
);
ALTER TABLE
    "movimiento" ADD PRIMARY KEY("mov_id");
CREATE TABLE "solicitud"(
    "solicitud_id" BIGINT NOT NULL,
    "estado" VARCHAR(255) NOT NULL,
    "empleado_id" BIGINT NOT NULL,
    "justificacion" VARCHAR(255) NOT NULL,
    "prioridad" BIGINT NOT NULL,
    "fecha_creacion" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "fecha_modificacion" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "solicitud" ADD PRIMARY KEY("solicitud_id");
CREATE TABLE "categoria"(
    "categoria_id" BIGINT NOT NULL,
    "nombre" VARCHAR(255) NOT NULL,
    "descripcion" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "categoria" ADD PRIMARY KEY("categoria_id");
CREATE TABLE "Usuario"(
    "id" BIGINT NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "hashed_password" VARCHAR(255) NOT NULL,
    "activo" BOOLEAN NOT NULL
);
ALTER TABLE
    "Usuario" ADD PRIMARY KEY("id");
CREATE TABLE "detalle_solicitud"(
    "detalle_sol_id" BIGINT NOT NULL,
    "observacion" VARCHAR(255) NOT NULL,
    "producto_id" BIGINT NOT NULL,
    "solicitud_id" BIGINT NOT NULL,
    "cantidad" INTEGER NOT NULL
);
ALTER TABLE
    "detalle_solicitud" ADD PRIMARY KEY("detalle_sol_id");
CREATE TABLE "cargo"(
    "cargo_id" BIGINT NOT NULL,
    "nombre" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "cargo" ADD PRIMARY KEY("cargo_id");
CREATE TABLE "usuario_sistema"(
    "usuario_sistema_id" BIGINT NOT NULL,
    "nombre" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "usuario_sistema" ADD PRIMARY KEY("usuario_sistema_id");
CREATE TABLE "Reporte"(
    "reporte_id" BIGINT NOT NULL,
    "fecha_creacion" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "titulo" VARCHAR(255) NOT NULL,
    "estado" VARCHAR(255) NOT NULL,
    "tipo" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "Reporte" ADD PRIMARY KEY("reporte_id");
ALTER TABLE
    "empleado" ADD CONSTRAINT "empleado_bodega_id_foreign" FOREIGN KEY("bodega_id") REFERENCES "bodega"("bodega_id");
ALTER TABLE
    "bodega" ADD CONSTRAINT "bodega_parent_bodega_id_foreign" FOREIGN KEY("parent_bodega_id") REFERENCES "bodega"("bodega_id");
ALTER TABLE
    "producto" ADD CONSTRAINT "producto_categoria_id_foreign" FOREIGN KEY("categoria_id") REFERENCES "categoria"("categoria_id");
ALTER TABLE
    "inventario" ADD CONSTRAINT "inventario_bodega_id_foreign" FOREIGN KEY("bodega_id") REFERENCES "bodega"("bodega_id");
ALTER TABLE
    "empleado" ADD CONSTRAINT "empleado_usuario_sistema_id_foreign" FOREIGN KEY("usuario_sistema_id") REFERENCES "usuario_sistema"("usuario_sistema_id");
ALTER TABLE
    "solicitud" ADD CONSTRAINT "solicitud_empleado_id_foreign" FOREIGN KEY("empleado_id") REFERENCES "empleado"("empleado_id");
ALTER TABLE
    "detalle_solicitud" ADD CONSTRAINT "detalle_solicitud_producto_id_foreign" FOREIGN KEY("producto_id") REFERENCES "producto"("producto_id");
ALTER TABLE
    "movimiento" ADD CONSTRAINT "movimiento_detalle_sol_id_foreign" FOREIGN KEY("detalle_sol_id") REFERENCES "detalle_solicitud"("detalle_sol_id");
ALTER TABLE
    "empleado" ADD CONSTRAINT "empleado_usuario_id_foreign" FOREIGN KEY("usuario_id") REFERENCES "Usuario"("id");
ALTER TABLE
    "inventario" ADD CONSTRAINT "inventario_producto_id_foreign" FOREIGN KEY("producto_id") REFERENCES "producto"("producto_id");
ALTER TABLE
    "empleado" ADD CONSTRAINT "empleado_cargo_id_foreign" FOREIGN KEY("cargo_id") REFERENCES "cargo"("cargo_id");
ALTER TABLE
    "detalle_solicitud" ADD CONSTRAINT "detalle_solicitud_solicitud_id_foreign" FOREIGN KEY("solicitud_id") REFERENCES "solicitud"("solicitud_id");
ALTER TABLE
    "movimiento" ADD CONSTRAINT "movimiento_inv_id_foreign" FOREIGN KEY("inv_id") REFERENCES "inventario"("inv_id");