/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 8.2.0 : Database - inventario
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`inventario` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `inventario`;

/*Table structure for table `detalle_venta` */

DROP TABLE IF EXISTS `detalle_venta`;

CREATE TABLE `detalle_venta` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_venta` (`id_venta`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`),
  CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `detalle_venta_chk_1` CHECK ((`cantidad` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `detalle_venta` */

/*Table structure for table `inventario` */

DROP TABLE IF EXISTS `inventario`;

CREATE TABLE `inventario` (
  `id_inventario` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `descuento` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id_inventario`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `inventario_chk_1` CHECK ((`cantidad` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `inventario` */

insert  into `inventario`(`id_inventario`,`id_producto`,`cantidad`,`descuento`) values (63,1,25,0.00),(64,2,50,0.05),(65,3,40,0.10),(66,4,30,0.00),(67,5,20,0.15),(68,6,35,0.05),(69,7,15,0.00),(70,8,45,0.10),(71,9,18,0.20),(72,10,60,0.00),(73,11,60,0.00);

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `producto` varchar(100) NOT NULL,
  `descripcion` text,
  `precio_costo` decimal(10,2) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `marca` varchar(100) NOT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `productos` */

insert  into `productos`(`id_producto`,`producto`,`descripcion`,`precio_costo`,`precio_venta`,`fecha_creacion`,`marca`) values (1,'Producto de prueba','descripcion de prueba',10.00,25.00,'2024-10-27 21:02:35','marca de prueba'),(2,'Aceite de Motor 5W-30','Aceite sintético para motor de 5 litros, ideal para motores modernos',30.00,55.00,'2024-10-27 21:04:15','Mobil'),(3,'Filtro de Aceite','Filtro de aceite para automóviles estándar, tamaño mediano',5.00,12.00,'2024-10-27 21:04:15','Fram'),(4,'Coolant 50/50','Refrigerante premixado para radiadores, botella de 1 galón',15.00,28.00,'2024-10-27 21:04:15','Prestone'),(5,'Grasa Multiuso','Grasa para aplicaciones automotrices y uso general, 500g',3.00,8.00,'2024-10-27 21:04:15','Valvoline'),(6,'Limpiador de Inyectores','Aditivo para limpiar los inyectores de combustible, 350ml',7.00,15.00,'2024-10-27 21:04:15','STP'),(7,'Filtro de Aire','Filtro de aire para vehículos de tamaño estándar',8.00,18.00,'2024-10-27 21:04:15','K&N'),(8,'Aceite de Transmisión ATF','Aceite para transmisión automática, botella de 1 litro',10.00,20.00,'2024-10-27 21:04:15','Castrol'),(9,'Líquido de Frenos DOT 4','Líquido para frenos compatible con sistemas DOT 4, botella de 500ml',6.00,14.00,'2024-10-27 21:04:15','Bosch'),(10,'Aditivo para Motor','Tratamiento de aceite para reducir fricción y desgaste, 500ml',9.00,20.00,'2024-10-27 21:04:15','Liqui Moly'),(11,'Limpiador de Frenos','Spray limpiador de frenos para eliminar grasa y suciedad, 400ml',4.00,10.00,'2024-10-27 21:04:15','CRC');

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(100) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `roles` */

insert  into `roles`(`id_rol`,`nombre_rol`,`descripcion`) values (1,'Administrador','Usuario con acceso a todos los modulos de la aplicación, capaz de crear, modificar y eliminar otros '),(2,'Encargado De Caja','Usuario con capacidades de acceso de vista al inventario y capacidades para registrar nuevas transac'),(3,'Encargado de inventario','Usuario con capacidades de lectura y escritura al modulo de inventario, registro de nuevos productos');

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_rol` int NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `usuarios` */

insert  into `usuarios`(`id_usuario`,`nombre`,`email`,`password`,`id_rol`,`fecha_creacion`) values (1,'Jorge Gonzalez','admin@gmail.com','$2y$12$J5EJikPGMpMHDWS/6kk5/uNzyt1K0A8n4H69UNrUKuW9F00KjSVAu',1,'2024-10-27 22:23:46');

/*Table structure for table `ventas` */

DROP TABLE IF EXISTS `ventas`;

CREATE TABLE `ventas` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `fecha_venta` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `ventas` */

/* Procedure structure for procedure `descontarDeInventario` */

/*!50003 DROP PROCEDURE IF EXISTS  `descontarDeInventario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `descontarDeInventario`(
    IN p_id_prod INT,
    IN p_cant INT)
BEGIN
    DECLARE actual INT;
    
    SELECT inventario.`cantidad` INTO actual
    FROM inventario.`inventario`
    where inventario.`id_inventario` = p_id_prod;
    
    IF actual>= p_cant then
	    UPDATE inventario.`inventario`
	    set	inventario.`cantidad`= inventario.`cantidad`-p_cant
	    where inventario.`id_inventario`= p_id_prod;
    
	Select Concat("Inventario actualizado.",inventario.`cantidad`) AS mensaje;
    ELSE
	SELECt "No se puede realizar." AS mensaje;
    END IF;
    
    END */$$
DELIMITER ;

/*Table structure for table `getexistenciasinfo` */

DROP TABLE IF EXISTS `getexistenciasinfo`;

/*!50001 DROP VIEW IF EXISTS `getexistenciasinfo` */;
/*!50001 DROP TABLE IF EXISTS `getexistenciasinfo` */;

/*!50001 CREATE TABLE  `getexistenciasinfo`(
 `id_producto` int ,
 `producto` varchar(100) ,
 `marca` varchar(100) ,
 `descripcion` text ,
 `precio_costo` decimal(10,2) ,
 `precio_venta` decimal(10,2) ,
 `existencias` int ,
 `despues_descuento` decimal(20,2) 
)*/;

/*Table structure for table `getusers` */

DROP TABLE IF EXISTS `getusers`;

/*!50001 DROP VIEW IF EXISTS `getusers` */;
/*!50001 DROP TABLE IF EXISTS `getusers` */;

/*!50001 CREATE TABLE  `getusers`(
 `Nombre Completo` varchar(100) ,
 `Email` varchar(100) ,
 `Creado en` timestamp ,
 `Permisos` varchar(100) 
)*/;

/*View structure for view getexistenciasinfo */

/*!50001 DROP TABLE IF EXISTS `getexistenciasinfo` */;
/*!50001 DROP VIEW IF EXISTS `getexistenciasinfo` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `getexistenciasinfo` AS select `p`.`id_producto` AS `id_producto`,`p`.`producto` AS `producto`,`p`.`marca` AS `marca`,`p`.`descripcion` AS `descripcion`,`p`.`precio_costo` AS `precio_costo`,`p`.`precio_venta` AS `precio_venta`,`i`.`cantidad` AS `existencias`,round((`p`.`precio_venta` - (`p`.`precio_venta` * `i`.`descuento`)),2) AS `despues_descuento` from (`productos` `p` join `inventario` `i` on((`p`.`id_producto` = `i`.`id_producto`))) */;

/*View structure for view getusers */

/*!50001 DROP TABLE IF EXISTS `getusers` */;
/*!50001 DROP VIEW IF EXISTS `getusers` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `getusers` AS select `u`.`nombre` AS `Nombre Completo`,`u`.`email` AS `Email`,`u`.`fecha_creacion` AS `Creado en`,`r`.`nombre_rol` AS `Permisos` from (`usuarios` `u` join `roles` `r`) where (`r`.`id_rol` = `u`.`id_rol`) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
