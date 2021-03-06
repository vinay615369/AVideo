SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `categories` 
ADD `parentId` INT NOT NULL DEFAULT '0' AFTER `nextVideoOrder`;

CREATE TABLE `category_type_cache` (
  `categoryId` int(11) NOT NULL,
  `type` int(2) NOT NULL COMMENT '0=both, 1=audio, 2=video' DEFAULT 0,
  `manualSet` int(1) NOT NULL COMMENT '0 = auto, 1 = manual' DEFAULT 0
    
) ENGINE=InnoDB;

ALTER TABLE `category_type_cache`
  ADD UNIQUE KEY `categoryId` (`categoryId`);
COMMIT;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

UPDATE configurations SET  version = '5.01', modified = now() WHERE id = 1;