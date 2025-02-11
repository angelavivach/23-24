-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BANCO
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BANCO
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BANCO` ;
USE `BANCO` ;

-- -----------------------------------------------------
-- Table `BANCO`.`SUCURSAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCO`.`SUCURSAL` (
  `NUMERO` TINYINT(4) UNSIGNED NOT NULL,
  `TIPO_VIA` ENUM("CALLE", "TRAVESIA", "AVENIDA") NULL,
  `NOMBRE_VIA` VARCHAR(45) NULL,
  `NUMERO_VIA` TINYINT(3) UNSIGNED NULL,
  `CIUDAD` ENUM("MADRID", "BARCELONA", "SEVILLA") NULL,
  PRIMARY KEY (`NUMERO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCO`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCO`.`CLIENTE` (
  `CODIGO` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DNI` VARCHAR(9) NULL,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `CIUDAD` ENUM("BARCELONA", "MADRID", "VALLADOLID", "SEVILLA") NOT NULL,
  `FECHA_NACIMIENTO` DATE NOT NULL,
  `SUCURSAL_NUMERO` TINYINT(4) UNSIGNED NOT NULL,
  `DESCUENTO` FLOAT(6,6) UNSIGNED NULL,
  PRIMARY KEY (`CODIGO`),
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC) VISIBLE,
  INDEX `fk_CLIENTE_SUCURSAL1_idx` (`SUCURSAL_NUMERO` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENTE_SUCURSAL1`
    FOREIGN KEY (`SUCURSAL_NUMERO`)
    REFERENCES `BANCO`.`SUCURSAL` (`NUMERO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCO`.`TARJETA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCO`.`TARJETA` (
  `NUMERO` VARCHAR(16) NOT NULL,
  `NOMBRE` VARCHAR(45) NULL,
  `APELLIDO1` VARCHAR(45) NULL,
  `APELLIDO2` VARCHAR(45) NULL,
  `CVC` VARCHAR(3) NULL,
  `FECHA_VENCIMIENTO` DATE NULL,
  `CLIENTE_CODIGO` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`NUMERO`),
  INDEX `fk_TARJETA_CLIENTE_idx` (`CLIENTE_CODIGO` ASC) VISIBLE,
  CONSTRAINT `fk_TARJETA_CLIENTE`
    FOREIGN KEY (`CLIENTE_CODIGO`)
    REFERENCES `BANCO`.`CLIENTE` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCO`.`EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCO`.`EMPLEADO` (
  `LEGAJO` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DNI` VARCHAR(9) NULL,
  `TIPO_VIA` ENUM("CALLE", "TRAVESIA", "AVENIDA") NULL,
  `NOMBRE_VIA` VARCHAR(45) NULL,
  `NUMERO_VIA` TINYINT(3) NULL,
  PRIMARY KEY (`LEGAJO`),
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCO`.`TELEFONO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCO`.`TELEFONO` (
  `idTELEFONO` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NUMERO_TELEFONO` VARCHAR(9) NOT NULL,
  `EMPLEADO_LEGAJO` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idTELEFONO`),
  INDEX `fk_TELEFONO_EMPLEADO1_idx` (`EMPLEADO_LEGAJO` ASC) VISIBLE,
  CONSTRAINT `fk_TELEFONO_EMPLEADO1`
    FOREIGN KEY (`EMPLEADO_LEGAJO`)
    REFERENCES `BANCO`.`EMPLEADO` (`LEGAJO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCO`.`SUCURSAL_has_EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCO`.`SUCURSAL_has_EMPLEADO` (
  `SUCURSAL_NUMERO` TINYINT(4) UNSIGNED NOT NULL,
  `EMPLEADO_LEGAJO` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`SUCURSAL_NUMERO`, `EMPLEADO_LEGAJO`),
  INDEX `fk_SUCURSAL_has_EMPLEADO_EMPLEADO1_idx` (`EMPLEADO_LEGAJO` ASC) VISIBLE,
  INDEX `fk_SUCURSAL_has_EMPLEADO_SUCURSAL1_idx` (`SUCURSAL_NUMERO` ASC) VISIBLE,
  CONSTRAINT `fk_SUCURSAL_has_EMPLEADO_SUCURSAL1`
    FOREIGN KEY (`SUCURSAL_NUMERO`)
    REFERENCES `BANCO`.`SUCURSAL` (`NUMERO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SUCURSAL_has_EMPLEADO_EMPLEADO1`
    FOREIGN KEY (`EMPLEADO_LEGAJO`)
    REFERENCES `BANCO`.`EMPLEADO` (`LEGAJO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCO`.`PRODUCTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCO`.`PRODUCTO` (
  `CODIGO` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` VARCHAR(150) NULL,
  `COLOR` SET("NEGRO", "ROSA", "AZUL") NULL,
  `PRECIO` FLOAT(7,3) NULL,
  PRIMARY KEY (`CODIGO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCO`.`VENDE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCO`.`VENDE` (
  `PRODUCTO_CODIGO` INT UNSIGNED NOT NULL,
  `SUCURSAL_NUMERO` TINYINT(4) UNSIGNED NOT NULL,
  `PRECIO_VENTA` VARCHAR(45) NULL,
  PRIMARY KEY (`PRODUCTO_CODIGO`, `SUCURSAL_NUMERO`),
  INDEX `fk_PRODUCTO_has_SUCURSAL_SUCURSAL1_idx` (`SUCURSAL_NUMERO` ASC) VISIBLE,
  INDEX `fk_PRODUCTO_has_SUCURSAL_PRODUCTO1_idx` (`PRODUCTO_CODIGO` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTO_has_SUCURSAL_PRODUCTO1`
    FOREIGN KEY (`PRODUCTO_CODIGO`)
    REFERENCES `BANCO`.`PRODUCTO` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTO_has_SUCURSAL_SUCURSAL1`
    FOREIGN KEY (`SUCURSAL_NUMERO`)
    REFERENCES `BANCO`.`SUCURSAL` (`NUMERO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCO`.`FABRICA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCO`.`FABRICA` (
  `CUIT` INT NOT NULL,
  `NOMBRE` VARCHAR(45) NULL,
  `PAIS` ENUM("ESPAÑA", "INGLATERRA", "PORTUGAL") NULL,
  `GERENTE` VARCHAR(45) NULL,
  `CANTIDAD_EMPLEADOS` VARCHAR(45) NULL,
  `PRODUCTO_CODIGO` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`CUIT`),
  INDEX `fk_FABRICA_PRODUCTO1_idx` (`PRODUCTO_CODIGO` ASC) VISIBLE,
  CONSTRAINT `fk_FABRICA_PRODUCTO1`
    FOREIGN KEY (`PRODUCTO_CODIGO`)
    REFERENCES `BANCO`.`PRODUCTO` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
