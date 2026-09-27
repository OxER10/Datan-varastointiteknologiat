-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema company
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema company
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `company` DEFAULT CHARACTER SET utf8 ;
USE `company` ;

-- -----------------------------------------------------
-- Table `company`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`employee` (
  `id` INT(11) NOT NULL,
  `fname` VARCHAR(32) NULL,
  `lname` VARCHAR(64) NULL,
  `salary` DOUBLE NULL,
  `bdate` DATE NULL,
  `email` VARCHAR(64) NULL,
  `department_id` INT NOT NULL,
  `phone1` VARCHAR(32) NULL,
  `phone2` VARCHAR(32) NULL,
  `image` VARCHAR(255) NULL,
  `supervisor_id` INT(11) NOT NULL,
  INDEX `fk_employee_department_idx` (`department_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_employee_employee1_idx` (`supervisor_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `company`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_employee1`
    FOREIGN KEY (`supervisor_id`)
    REFERENCES `company`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`department` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(32) NULL,
  `manager_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_department_employee1_idx` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_employee1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `company`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`dependent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`dependent` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL,
  `bdate` DATETIME NULL,
  `employee_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `employee_id`),
  INDEX `fk_dependent_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_dependent_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `company`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`project` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(64) NULL,
  `manager_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_project_employee1_idx` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `fk_project_employee1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `company`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`works_on`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`works_on` (
  `id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  `hours` FLOAT NULL,
  `project_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_works_on_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_works_on_project1_idx` (`project_id` ASC) VISIBLE,
  CONSTRAINT `fk_works_on_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `company`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_works_on_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `company`.`project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`part`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`part` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`supplier` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`supply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`supply` (
  `project_id` INT(11) NOT NULL,
  `part_id` INT(11) NOT NULL,
  `supplier_id` INT(11) NOT NULL,
  `quantity` INT(11) NULL,
  PRIMARY KEY (`project_id`, `part_id`, `supplier_id`),
  INDEX `fk_supply_part1_idx` (`part_id` ASC) VISIBLE,
  INDEX `fk_supply_supplier1_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_supply_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `company`.`project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supply_part1`
    FOREIGN KEY (`part_id`)
    REFERENCES `company`.`part` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supply_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `company`.`supplier` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`part_of`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`part_of` (
  `part_id` INT(11) NOT NULL,
  `compart_id` INT(11) NOT NULL,
  `quantity` INT(11) NULL,
  INDEX `fk_part_of_part1_idx` (`part_id` ASC) VISIBLE,
  PRIMARY KEY (`part_id`, `compart_id`),
  INDEX `fk_part_of_part2_idx` (`compart_id` ASC) VISIBLE,
  CONSTRAINT `fk_part_of_part1`
    FOREIGN KEY (`part_id`)
    REFERENCES `company`.`part` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_part_of_part2`
    FOREIGN KEY (`compart_id`)
    REFERENCES `company`.`part` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
