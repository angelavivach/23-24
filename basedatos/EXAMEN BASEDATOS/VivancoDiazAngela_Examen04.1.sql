-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema FABRICA
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema FABRICA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FABRICA` ;
USE `FABRICA` ;

-- -----------------------------------------------------
-- Table `FABRICA`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FABRICA`.`CLIENTE` (
  `COD_CLIENTE` INT NOT NULL,
  `NOMBRE` VARCHAR(12) NULL,
  `DOMICILIO` ENUM("CALLE", "PORTAL", "PISO") NULL,
  PRIMARY KEY (`COD_CLIENTE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FABRICA`.`EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FABRICA`.`EMPLEADO` (
  `NUMERO` INT UNSIGNED NOT NULL,
  `NOMBRE` VARCHAR(12) NULL,
  `TELEFONO1` VARCHAR(9) NULL,
  `TELEFONO2` VARCHAR(9) NULL,
  PRIMARY KEY (`NUMERO`),
  UNIQUE INDEX `NUMERO_UNIQUE` (`NUMERO` ASC) VISIBLE,
  UNIQUE INDEX `TELEFONO1_UNIQUE` (`TELEFONO1` ASC) VISIBLE,
  UNIQUE INDEX `TELEFONO2_UNIQUE` (`TELEFONO2` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FABRICA`.`DEPARTAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FABRICA`.`DEPARTAMENTO` (
  `COD_DEPART` INT NOT NULL,
  `NOMBRE` VARCHAR(12) NULL,
  `EMPLEADO_NUMERO` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`COD_DEPART`, `EMPLEADO_NUMERO`),
  INDEX `fk_DEPARTAMENTO_EMPLEADO1_idx` (`EMPLEADO_NUMERO` ASC) VISIBLE,
  CONSTRAINT `fk_DEPARTAMENTO_EMPLEADO1`
    FOREIGN KEY (`EMPLEADO_NUMERO`)
    REFERENCES `FABRICA`.`EMPLEADO` (`NUMERO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FABRICA`.`PRODUCTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FABRICA`.`PRODUCTO` (
  `COD_PRODUCTO` INT NOT NULL,
  `PRECIO` FLOAT(5,2) UNSIGNED NULL,
  `DEPARTAMENTO_COD_DEPART` INT NOT NULL,
  PRIMARY KEY (`COD_PRODUCTO`, `DEPARTAMENTO_COD_DEPART`),
  INDEX `fk_PRODUCTO_DEPARTAMENTO1_idx` (`DEPARTAMENTO_COD_DEPART` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTO_DEPARTAMENTO1`
    FOREIGN KEY (`DEPARTAMENTO_COD_DEPART`)
    REFERENCES `FABRICA`.`DEPARTAMENTO` (`COD_DEPART`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FABRICA`.`COMPRA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FABRICA`.`COMPRA` (
  `CLIENTE_COD_CLIENTE` INT NOT NULL,
  `PRODUCTO_COD_PRODUCTO` INT NOT NULL,
  `PRODUCTO_DEPARTAMENTO_COD_DEPART` INT NOT NULL,
  PRIMARY KEY (`CLIENTE_COD_CLIENTE`, `PRODUCTO_COD_PRODUCTO`, `PRODUCTO_DEPARTAMENTO_COD_DEPART`),
  INDEX `fk_CLIENTE_has_PRODUCTO_PRODUCTO1_idx` (`PRODUCTO_COD_PRODUCTO` ASC, `PRODUCTO_DEPARTAMENTO_COD_DEPART` ASC) VISIBLE,
  INDEX `fk_CLIENTE_has_PRODUCTO_CLIENTE1_idx` (`CLIENTE_COD_CLIENTE` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENTE_has_PRODUCTO_CLIENTE1`
    FOREIGN KEY (`CLIENTE_COD_CLIENTE`)
    REFERENCES `FABRICA`.`CLIENTE` (`COD_CLIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CLIENTE_has_PRODUCTO_PRODUCTO1`
    FOREIGN KEY (`PRODUCTO_COD_PRODUCTO` , `PRODUCTO_DEPARTAMENTO_COD_DEPART`)
    REFERENCES `FABRICA`.`PRODUCTO` (`COD_PRODUCTO` , `DEPARTAMENTO_COD_DEPART`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
