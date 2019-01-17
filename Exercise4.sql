-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DoctorDatabase
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DoctorDatabase
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DoctorDatabase` ;
USE `DoctorDatabase` ;

-- -----------------------------------------------------
-- Table `DoctorDatabase`.`Doctor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DoctorDatabase`.`Doctor` ;

CREATE TABLE IF NOT EXISTS `DoctorDatabase`.`Doctor` (
  `idDoctor` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` INT NULL,
  `Salary` INT NULL,
  PRIMARY KEY (`idDoctor`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idDoctor_UNIQUE` ON `DoctorDatabase`.`Doctor` (`idDoctor` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DoctorDatabase`.`Specialist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DoctorDatabase`.`Specialist` ;

CREATE TABLE IF NOT EXISTS `DoctorDatabase`.`Specialist` (
  `idSpecialist` INT NOT NULL AUTO_INCREMENT,
  `Field_area` VARCHAR(45) NULL,
  `idDoctor` INT NOT NULL,
  PRIMARY KEY (`idSpecialist`),
  CONSTRAINT `Specialisation`
    FOREIGN KEY (`idDoctor`)
    REFERENCES `DoctorDatabase`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idDoctor_UNIQUE` ON `DoctorDatabase`.`Specialist` (`idDoctor` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DoctorDatabase`.`Medical`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DoctorDatabase`.`Medical` ;

CREATE TABLE IF NOT EXISTS `DoctorDatabase`.`Medical` (
  `idOvertime` INT NOT NULL AUTO_INCREMENT,
  `Overtime_rate` INT NULL,
  `idDoctor` INT NOT NULL,
  `idSpecialist` INT NOT NULL,
  PRIMARY KEY (`idOvertime`),
  CONSTRAINT `Overtime_specialisation`
    FOREIGN KEY (`idSpecialist`)
    REFERENCES `DoctorDatabase`.`Specialist` (`idSpecialist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Overtime_specialisation_idx` ON `DoctorDatabase`.`Medical` (`idSpecialist` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DoctorDatabase`.`Patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DoctorDatabase`.`Patient` ;

CREATE TABLE IF NOT EXISTS `DoctorDatabase`.`Patient` (
  `idPatient` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` INT NULL,
  `Date_of_birth` DATE NOT NULL,
  PRIMARY KEY (`idPatient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DoctorDatabase`.`Bills`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DoctorDatabase`.`Bills` ;

CREATE TABLE IF NOT EXISTS `DoctorDatabase`.`Bills` (
  `idBills` INT NOT NULL AUTO_INCREMENT,
  `Total` INT NOT NULL,
  PRIMARY KEY (`idBills`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DoctorDatabase`.`Appointment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DoctorDatabase`.`Appointment` ;

CREATE TABLE IF NOT EXISTS `DoctorDatabase`.`Appointment` (
  `idAppointment` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NOT NULL,
  `Time` VARCHAR(45) NOT NULL,
  `idPatient` INT NOT NULL,
  `idBills` INT NOT NULL,
  `idDoctor` INT NOT NULL,
  PRIMARY KEY (`idAppointment`),
  CONSTRAINT `patient_appt`
    FOREIGN KEY (`idPatient`)
    REFERENCES `DoctorDatabase`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Bills_appt`
    FOREIGN KEY (`idBills`)
    REFERENCES `DoctorDatabase`.`Bills` (`idBills`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `doctor_appt`
    FOREIGN KEY (`idDoctor`)
    REFERENCES `DoctorDatabase`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `patient_appt_idx` ON `DoctorDatabase`.`Appointment` (`idPatient` ASC) VISIBLE;

CREATE INDEX `Bills_appt_idx` ON `DoctorDatabase`.`Appointment` (`idBills` ASC) VISIBLE;

CREATE INDEX `doctor_appt_idx` ON `DoctorDatabase`.`Appointment` (`idDoctor` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DoctorDatabase`.`Payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DoctorDatabase`.`Payment` ;

CREATE TABLE IF NOT EXISTS `DoctorDatabase`.`Payment` (
  `idPayment` INT NOT NULL AUTO_INCREMENT,
  `Method` VARCHAR(45) NULL,
  `Details` VARCHAR(45) NULL,
  PRIMARY KEY (`idPayment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DoctorDatabase`.`Bills - payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DoctorDatabase`.`Bills - payment` ;

CREATE TABLE IF NOT EXISTS `DoctorDatabase`.`Bills - payment` (
  `idBills - payment` INT NOT NULL AUTO_INCREMENT,
  `idBills` INT NOT NULL,
  `idPayment` INT NOT NULL,
  PRIMARY KEY (`idBills - payment`),
  CONSTRAINT `payment`
    FOREIGN KEY (`idPayment`)
    REFERENCES `DoctorDatabase`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bills`
    FOREIGN KEY (`idBills`)
    REFERENCES `DoctorDatabase`.`Bills` (`idBills`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `payment_idx` ON `DoctorDatabase`.`Bills - payment` (`idPayment` ASC) VISIBLE;

CREATE INDEX `bills_idx` ON `DoctorDatabase`.`Bills - payment` (`idBills` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

