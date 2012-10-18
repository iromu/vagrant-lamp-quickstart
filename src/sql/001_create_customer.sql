DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL UNIQUE,
  `password` varchar(40) NOT NULL COMMENT 'salted SHA1 password',
  `salt` varchar(32) NOT NULL COMMENT 'dynamic salt for customer',  
  `created_at` timestamp NOT NULL default 0,
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;