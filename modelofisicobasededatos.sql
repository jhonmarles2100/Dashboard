-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema inventario
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inventario
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inventario` DEFAULT CHARACTER SET utf8 ;
USE `inventario` ;

-- -----------------------------------------------------
-- Table `inventario`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`usuarios` (
  `idusuarios` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `usuario` VARCHAR(25) NOT NULL,
  `contrasena` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idusuarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`producto` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `producto` VARCHAR(25) NOT NULL,
  `precio` DOUBLE NOT NULL,
  `marca` VARCHAR(30) NOT NULL,
  `referencia` VARCHAR(30) NOT NULL,
  `color` VARCHAR(20) NOT NULL,
  `contenido` VARCHAR(30) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`inventarioProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`inventarioProducto` (
  `idCodigo` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `can_minima` INT NOT NULL,
  `can_disponible` INT NOT NULL,
  `can_maxima` INT NOT NULL,
  PRIMARY KEY (`idCodigo`),
  INDEX `producto_id_idx` (`producto_id` ASC),
  CONSTRAINT `producto_id`
    FOREIGN KEY (`producto_id`)
    REFERENCES `inventario`.`producto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`provedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`provedor` (
  `nitProvedor` VARCHAR(30) NOT NULL,
  `nombre_provedor` VARCHAR(45) NOT NULL,
  `nombreContacto` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `direccion` VARCHAR(45) NULL,
  `ciudad` VARCHAR(25) NULL,
  `tipo_pago` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`nitProvedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`solicitud_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`solicitud_compra` (
  `id_solicitudcompra` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  `provedor_id` VARCHAR(30) NOT NULL,
  `descripciondelproducto` VARCHAR(45) NOT NULL,
  `fecha_solicitud` DATE NOT NULL,
  `fecha_envioprov` DATE NOT NULL,
  `fecha_requerida` DATE NOT NULL,
  `fecha_llegada` DATE NOT NULL,
  PRIMARY KEY (`id_solicitudcompra`),
  INDEX `usuario_solicitud_idx` (`usuario_id` ASC),
  INDEX `provedor_solicitud_idx` (`provedor_id` ASC),
  CONSTRAINT `usuario_solicitud`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `inventario`.`usuarios` (`idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `provedor_solicitud`
    FOREIGN KEY (`provedor_id`)
    REFERENCES `inventario`.`provedor` (`nitProvedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`detalle_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`detalle_compra` (
  `item` VARCHAR(30) NOT NULL,
  `id_detallecompra` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `solicitudcompra_id` INT NOT NULL,
  `cantidadsolicitada` INT NOT NULL,
  `cantidadrecibida` INT NOT NULL,
  PRIMARY KEY (`id_detallecompra`),
  INDEX `producto_detallec_idx` (`producto_id` ASC),
  INDEX `solicitudcompra_id_idx` (`solicitudcompra_id` ASC),
  CONSTRAINT `producto_detallec`
    FOREIGN KEY (`producto_id`)
    REFERENCES `inventario`.`producto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `solicitudcompra_id`
    FOREIGN KEY (`solicitudcompra_id`)
    REFERENCES `inventario`.`solicitud_compra` (`id_solicitudcompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`movimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`movimientos` (
  `id_movimiento` VARCHAR(30) NOT NULL,
  `usuario_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `tipo_mov` VARCHAR(35) NOT NULL,
  `catidad_mov` INT NOT NULL,
  `fecha_mov` DATE NOT NULL,
  `cantida_entrada` INT NULL,
  `cantidad_salida` INT NULL,
  `total` INT NULL,
  `lote` VARCHAR(45) NOT NULL,
  `caducidad` DATE NULL,
  PRIMARY KEY (`id_movimiento`),
  INDEX `usuario_id_idx` (`usuario_id` ASC),
  INDEX `producto_id_idx` (`producto_id` ASC),
  CONSTRAINT `usuario_id`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `inventario`.`usuarios` (`idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `producto_id`
    FOREIGN KEY (`producto_id`)
    REFERENCES `inventario`.`producto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;