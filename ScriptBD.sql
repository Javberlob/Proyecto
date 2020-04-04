-- MySQL Script generated by MySQL Workbench
-- Sat Apr  4 23:31:28 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SADA
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `SADA` ;

-- -----------------------------------------------------
-- Schema SADA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SADA` DEFAULT CHARACTER SET utf8 ;
USE `SADA` ;

-- -----------------------------------------------------
-- Table `SADA`.`Comerciales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales` ;

CREATE TABLE IF NOT EXISTS `Comerciales` (
  `idComerciales` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `DNI` VARCHAR(9) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `password` TEXT(300) NOT NULL,
  PRIMARY KEY (`idComerciales`),
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC) ,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SADA`.`rutas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rutas` ;

CREATE TABLE IF NOT EXISTS `rutas` (
  `idruta` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idruta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SADA`.`Clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Clientes` ;

CREATE TABLE IF NOT EXISTS `Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `DNI` VARCHAR(9) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `ruta` INT NOT NULL,
  `descuento` INT NULL,
  PRIMARY KEY (`idClientes`),
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC) ,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) ,
  UNIQUE INDEX `direccion_UNIQUE` (`direccion` ASC) ,
  INDEX `idRuta_idx` (`ruta` ASC) ,
  CONSTRAINT `idRuta`
    FOREIGN KEY (`ruta`)
    REFERENCES `rutas` (`idruta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SADA`.`Facturas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Facturas` ;

CREATE TABLE IF NOT EXISTS `Facturas` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `cliente` INT NOT NULL,
  `comercial` INT NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`idFactura`),
  INDEX `idCliente_idx` (`cliente` ASC) ,
  INDEX `idComercial_idx` (`comercial` ASC) ,
  CONSTRAINT `idCliente`
    FOREIGN KEY (`cliente`)
    REFERENCES `Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idComercial`
    FOREIGN KEY (`comercial`)
    REFERENCES `Comerciales` (`idComerciales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SADA`.`productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS`productos` ;

CREATE TABLE IF NOT EXISTS `productos` (
  `idproductos` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`idproductos`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SADA`.`pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pedidos` ;

CREATE TABLE IF NOT EXISTS `pedidos` (
  `idpedidos` INT NOT NULL AUTO_INCREMENT,
  `factura` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `producto` INT NOT NULL,
  PRIMARY KEY (`idpedidos`),
  INDEX `idFactura_idx` (`factura` ASC) ,
  INDEX `idproducto_idx` (`producto` ASC) ,
  CONSTRAINT `idFactura`
    FOREIGN KEY (`factura`)
    REFERENCES `Facturas` (`idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idproducto`
    FOREIGN KEY (`producto`)
    REFERENCES `productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
