show databases;
use robust_fitness;
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Members` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Members` (
  `members_account_number` CHAR(25) NOT NULL,
  `members_id` CHAR(13) NOT NULL,
  `members_name` VARCHAR(25) NOT NULL,
  `members_surname` VARCHAR(25) NOT NULL,
  `members_contact_number` CHAR(10) NOT NULL,
  `members_startdate` DATETIME NOT NULL,
  `members_active` BIT NOT NULL,
  `members_banking_info` VARCHAR(45) NOT NULL,
  `members_payment_date` DATETIME NOT NULL,
  `members_emailaddress` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`members_account_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Personel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Personel` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Personel` (
  `personel_number` CHAR(25) NOT NULL,
  `personel_id` CHAR(13) NULL,
  `personel_name` VARCHAR(25) NULL,
  `personel_surname` VARCHAR(25) NULL,
  `personel_jobtitle` VARCHAR(25) NULL,
  PRIMARY KEY (`personel_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Payments` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Payments` (
  `payments_invoice_number` CHAR(25) NOT NULL,
  `transaction_id` CHAR(25) NOT NULL,
  `payments_date` DATETIME NOT NULL,
  `payments_type` VARCHAR(25) NOT NULL,
  `payments_amount` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`payments_invoice_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Transaction` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Transaction` (
  `transaction_id` CHAR(25) NOT NULL,
  `members_account_number` CHAR(25) NOT NULL,
  `fitnessclasses_code` CHAR(25) NOT NULL,
  `Personel_personel_number` CHAR(25) NOT NULL,
  `Payments_payments_invoice_number` CHAR(25) NOT NULL,
  PRIMARY KEY (`transaction_id`, `Personel_personel_number`, `Payments_payments_invoice_number`),
  INDEX `fk_Transaction_Personel1_idx` (`Personel_personel_number` ASC) VISIBLE,
  INDEX `fk_Transaction_Payments1_idx` (`Payments_payments_invoice_number` ASC) VISIBLE,
  CONSTRAINT `fk_Transaction_Personel1`
    FOREIGN KEY (`Personel_personel_number`)
    REFERENCES `mydb`.`Personel` (`personel_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaction_Payments1`
    FOREIGN KEY (`Payments_payments_invoice_number`)
    REFERENCES `mydb`.`Payments` (`payments_invoice_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Members_has_Transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Members_has_Transaction` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Members_has_Transaction` (
  `Members_members_account_number` CHAR(25) NOT NULL,
  `Transaction_transaction_id` CHAR(25) NOT NULL,
  PRIMARY KEY (`Members_members_account_number`, `Transaction_transaction_id`),
  INDEX `fk_Members_has_Transaction_Transaction1_idx` (`Transaction_transaction_id` ASC) VISIBLE,
  INDEX `fk_Members_has_Transaction_Members_idx` (`Members_members_account_number` ASC) VISIBLE,
  CONSTRAINT `fk_Members_has_Transaction_Members`
    FOREIGN KEY (`Members_members_account_number`)
    REFERENCES `mydb`.`Members` (`members_account_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Members_has_Transaction_Transaction1`
    FOREIGN KEY (`Transaction_transaction_id`)
    REFERENCES `mydb`.`Transaction` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FitnessClasses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`FitnessClasses` ;

CREATE TABLE IF NOT EXISTS `mydb`.`FitnessClasses` (
  `fitnessclasses_code` CHAR(25) NOT NULL,
  `fitnessclasses_name` VARCHAR(55) NOT NULL,
  `fitnessclasses_type` VARCHAR(25) NOT NULL,
  `fitnessclasses_schedule` DATETIME NOT NULL,
  `instructor_id` CHAR(25) NOT NULL,
  PRIMARY KEY (`fitnessclasses_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Transaction_has_FitnessClasses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Transaction_has_FitnessClasses` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Transaction_has_FitnessClasses` (
  `Transaction_transaction_id` CHAR(25) NOT NULL,
  `FitnessClasses_fitnessclasses_code` CHAR(25) NOT NULL,
  PRIMARY KEY (`Transaction_transaction_id`, `FitnessClasses_fitnessclasses_code`),
  INDEX `fk_Transaction_has_FitnessClasses_FitnessClasses1_idx` (`FitnessClasses_fitnessclasses_code` ASC) VISIBLE,
  INDEX `fk_Transaction_has_FitnessClasses_Transaction1_idx` (`Transaction_transaction_id` ASC) VISIBLE,
  CONSTRAINT `fk_Transaction_has_FitnessClasses_Transaction1`
    FOREIGN KEY (`Transaction_transaction_id`)
    REFERENCES `mydb`.`Transaction` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaction_has_FitnessClasses_FitnessClasses1`
    FOREIGN KEY (`FitnessClasses_fitnessclasses_code`)
    REFERENCES `mydb`.`FitnessClasses` (`fitnessclasses_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Instructor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Instructor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Instructor` (
  `instructor_id` CHAR(25) NOT NULL,
  `instructor_name` VARCHAR(25) NOT NULL,
  `instructor_surname` VARCHAR(25) NOT NULL,
  `instructor_rate` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`instructor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FitnessClasses_has_Instructor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`FitnessClasses_has_Instructor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`FitnessClasses_has_Instructor` (
  `FitnessClasses_fitnessclasses_code` CHAR(25) NOT NULL,
  `Instructor_instructor_id` CHAR(25) NOT NULL,
  PRIMARY KEY (`FitnessClasses_fitnessclasses_code`, `Instructor_instructor_id`),
  INDEX `fk_FitnessClasses_has_Instructor_Instructor1_idx` (`Instructor_instructor_id` ASC) VISIBLE,
  INDEX `fk_FitnessClasses_has_Instructor_FitnessClasses1_idx` (`FitnessClasses_fitnessclasses_code` ASC) VISIBLE,
  CONSTRAINT `fk_FitnessClasses_has_Instructor_FitnessClasses1`
    FOREIGN KEY (`FitnessClasses_fitnessclasses_code`)
    REFERENCES `mydb`.`FitnessClasses` (`fitnessclasses_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FitnessClasses_has_Instructor_Instructor1`
    FOREIGN KEY (`Instructor_instructor_id`)
    REFERENCES `mydb`.`Instructor` (`instructor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


SHOW TABLES;
