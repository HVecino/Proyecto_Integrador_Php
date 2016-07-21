-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Usuarios` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `documento` VARCHAR(15) NOT NULL,
  `nombres` VARCHAR(35) NOT NULL,
  `apellido1` VARCHAR(35) NOT NULL,
  `apellido2` VARCHAR(35) NULL,
  `correo` VARCHAR(45) NOT NULL,
  `constrasena` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Roles` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Roles` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `nombreRol` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuarios_Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Usuarios_Roles` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios_Roles` (
  `idUsuario` INT NOT NULL,
  `idRol` INT NOT NULL,
  CONSTRAINT `fk_Usuarios_Roles_Usuarios`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `mydb`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_Roles_Roles1`
    FOREIGN KEY (`idRol`)
    REFERENCES `mydb`.`Roles` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuarios_Roles_Usuarios_idx` ON `mydb`.`Usuarios_Roles` (`idUsuario` ASC);

CREATE INDEX `fk_Usuarios_Roles_Roles1_idx` ON `mydb`.`Usuarios_Roles` (`idRol` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`Permisos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Permisos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Permisos` (
  `idPermiso` INT NOT NULL AUTO_INCREMENT,
  `nombrePermiso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPermiso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Roles_Permisos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Roles_Permisos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Roles_Permisos` (
  `idPermiso` INT NOT NULL,
  `idRol` INT NOT NULL,
  CONSTRAINT `fk_Roles_Permisos_Permisos1`
    FOREIGN KEY (`idPermiso`)
    REFERENCES `mydb`.`Permisos` (`idPermiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Roles_Permisos_Roles1`
    FOREIGN KEY (`idRol`)
    REFERENCES `mydb`.`Roles` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Roles_Permisos_Permisos1_idx` ON `mydb`.`Roles_Permisos` (`idPermiso` ASC);

CREATE INDEX `fk_Roles_Permisos_Roles1_idx` ON `mydb`.`Roles_Permisos` (`idRol` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`Materias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Materias` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Materias` (
  `idMateria` INT NOT NULL AUTO_INCREMENT,
  `nombreMateria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMateria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cursos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cursos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cursos` (
  `idCurso` INT NOT NULL AUTO_INCREMENT,
  `nombreCurso` VARCHAR(45) NOT NULL,
  `Usuarios_idUsuario` INT NOT NULL,
  `Materias_idMateria` INT NOT NULL,
  PRIMARY KEY (`idCurso`),
  CONSTRAINT `fk_Cursos_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuario`)
    REFERENCES `mydb`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cursos_Materias1`
    FOREIGN KEY (`Materias_idMateria`)
    REFERENCES `mydb`.`Materias` (`idMateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Cursos_Usuarios1_idx` ON `mydb`.`Cursos` (`Usuarios_idUsuario` ASC);

CREATE INDEX `fk_Cursos_Materias1_idx` ON `mydb`.`Cursos` (`Materias_idMateria` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`Nota`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Nota` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Nota` (
  `idNota` INT NOT NULL AUTO_INCREMENT,
  `resultado` INT NOT NULL,
  PRIMARY KEY (`idNota`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EstadosExamenes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EstadosExamenes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EstadosExamenes` (
  `idEstadosExamen` INT NOT NULL AUTO_INCREMENT,
  `nombreEstadoExamen` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idEstadosExamen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Examenes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Examenes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Examenes` (
  `idExamen` INT NOT NULL AUTO_INCREMENT,
  `fechaInicio` DATE NOT NULL,
  `fechaFin` DATE NOT NULL,
  `idUsuario` INT NOT NULL,
  `idCurso` INT NOT NULL,
  `cantidadPreguntas` INT NOT NULL,
  `horaInicio` DATE NOT NULL,
  `horaFin` DATE NOT NULL,
  `idNota` INT NOT NULL,
  `idEstadosExamen` INT NOT NULL,
  PRIMARY KEY (`idExamen`),
  CONSTRAINT `fk_Examenes_Usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `mydb`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Examenes_Cursos1`
    FOREIGN KEY (`idCurso`)
    REFERENCES `mydb`.`Cursos` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Examenes_Nota1`
    FOREIGN KEY (`idNota`)
    REFERENCES `mydb`.`Nota` (`idNota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Examenes_EstadosExamenes1`
    FOREIGN KEY (`idEstadosExamen`)
    REFERENCES `mydb`.`EstadosExamenes` (`idEstadosExamen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Examenes_Usuarios1_idx` ON `mydb`.`Examenes` (`idUsuario` ASC);

CREATE INDEX `fk_Examenes_Cursos1_idx` ON `mydb`.`Examenes` (`idCurso` ASC);

CREATE INDEX `fk_Examenes_Nota1_idx` ON `mydb`.`Examenes` (`idNota` ASC);

CREATE INDEX `fk_Examenes_EstadosExamenes1_idx` ON `mydb`.`Examenes` (`idEstadosExamen` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`Preguntas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Preguntas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Preguntas` (
  `idPregunta` INT NOT NULL AUTO_INCREMENT,
  `enunciado` TEXT(250) NOT NULL,
  `valorPregunta` INT NOT NULL,
  PRIMARY KEY (`idPregunta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Respuestas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Respuestas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Respuestas` (
  `idRespuesta` INT NOT NULL AUTO_INCREMENT,
  `idPregunta` INT NOT NULL,
  PRIMARY KEY (`idRespuesta`),
  CONSTRAINT `fk_Respuestas_Preguntas1`
    FOREIGN KEY (`idPregunta`)
    REFERENCES `mydb`.`Preguntas` (`idPregunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Respuestas_Preguntas1_idx` ON `mydb`.`Respuestas` (`idPregunta` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`TipoRespuestas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TipoRespuestas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TipoRespuestas` (
  `idTipoRespuesta` INT NOT NULL AUTO_INCREMENT,
  `nombreTipoRespuesta` VARCHAR(25) NOT NULL,
  `idRespuesta` INT NOT NULL,
  PRIMARY KEY (`idTipoRespuesta`),
  CONSTRAINT `fk_TipoRespuestas_Respuestas1`
    FOREIGN KEY (`idRespuesta`)
    REFERENCES `mydb`.`Respuestas` (`idRespuesta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_TipoRespuestas_Respuestas1_idx` ON `mydb`.`TipoRespuestas` (`idRespuesta` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`ExamenesPreguntas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ExamenesPreguntas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ExamenesPreguntas` (
  `idExamen` INT NOT NULL,
  `idPregunta` INT NOT NULL,
  CONSTRAINT `fk_ExamenesPreguntas_Examenes1`
    FOREIGN KEY (`idExamen`)
    REFERENCES `mydb`.`Examenes` (`idExamen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ExamenesPreguntas_Preguntas1`
    FOREIGN KEY (`idPregunta`)
    REFERENCES `mydb`.`Preguntas` (`idPregunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_ExamenesPreguntas_Examenes1_idx` ON `mydb`.`ExamenesPreguntas` (`idExamen` ASC);

CREATE INDEX `fk_ExamenesPreguntas_Preguntas1_idx` ON `mydb`.`ExamenesPreguntas` (`idPregunta` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
