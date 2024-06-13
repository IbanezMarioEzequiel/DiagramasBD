-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tp5
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tp5
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tp5` DEFAULT CHARACTER SET utf8 ;
USE `tp5` ;

-- -----------------------------------------------------
-- Table `tp5`.`Naves`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp5`.`Naves` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(25) NULL,
  `fabricante` VARCHAR(35) NULL,
  `velocidadMaxima` DECIMAL(4,1) NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp5`.`Misiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp5`.`Misiones` (
  `numero` INT NOT NULL,
  `nombreClave` VARCHAR(15) NULL,
  `dificultad` VARCHAR(25) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`numero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp5`.`NavesMisiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp5`.`NavesMisiones` (
  `numeroMisiones` INT NOT NULL,
  `naveCodigo` INT NOT NULL,
  `rol` VARCHAR(25) NULL,
  PRIMARY KEY (`numeroMisiones`, `naveCodigo`),
  INDEX `fk_NavesMisiones_Naves1_idx` (`naveCodigo` ASC) VISIBLE,
  CONSTRAINT `fk_NavesMisiones_Misiones`
    FOREIGN KEY (`numeroMisiones`)
    REFERENCES `tp5`.`Misiones` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NavesMisiones_Naves1`
    FOREIGN KEY (`naveCodigo`)
    REFERENCES `tp5`.`Naves` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp5`.`Recursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp5`.`Recursos` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(25) NULL,
  `precio` DECIMAL(6,2) NULL,
  `codigoNaves` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Recursos_Naves1_idx` (`codigoNaves` ASC) VISIBLE,
  CONSTRAINT `fk_Recursos_Naves1`
    FOREIGN KEY (`codigoNaves`)
    REFERENCES `tp5`.`Naves` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp5`.`Pilotos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp5`.`Pilotos` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(25) NULL,
  `experiencia` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp5`.`PilotosNaves`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp5`.`PilotosNaves` (
  `idPilotos` INT NOT NULL,
  `codigoNaves` INT NOT NULL,
  `informe` VARCHAR(45) NULL,
  PRIMARY KEY (`idPilotos`, `codigoNaves`),
  INDEX `fk_table1_Naves1_idx` (`codigoNaves` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Pilotos1`
    FOREIGN KEY (`idPilotos`)
    REFERENCES `tp5`.`Pilotos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_Naves1`
    FOREIGN KEY (`codigoNaves`)
    REFERENCES `tp5`.`Naves` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ---- punto2 ----- --
alter table misiones add Estado boolean;
alter table naves add Estado boolean;
alter table pilotos add Estado boolean;
alter table recursos add Estado boolean;

alter table pilotos add apodo varchar(25);
alter table pilotos add apellido varchar(25);

alter table misiones add fechaInicio date;

-- -----punto3----- --
create table Equipos (codigo int primary key,nombre varchar (25),cantidadIntegrante int);
alter table Equipos add idPilotos int;
alter table Equipos add constraint idPilotos foreign key (idPilotos) references pilotos(id);

-- -----punto4----- --
alter table naves drop fabricante;

-- -----punto5----- --
alter table pilotos modify column nombre varchar(30);

-- -----punto6---- --
insert into  pilotos (id,nombre,experiencia,estado,apodo,apellido) values 
(1,"juan","1 año de experiencia",true,"juancho","martinez"),
(2,"esteban","4 años de experiencia",false,"estebanquito","quito"),
(3,"maria","2 años de experiencia",true,"mari","fernadez"),
(4,"matias","6 meses de experiencia",true,"canotauro","fernandez");

insert into naves (codigo,nombre,velocidadMaxima,estado)values
(1, 'Enterprise', 500.0, true),
(2, 'Millennium ', 750.0, false),
(3, 'Serenity', 600.0, false),
(4, 'Normandy', 700.0, true);

insert into misiones(numero,nombreClave,dificultad,descripcion,estado,fechaInicio)values
(1, 'Operación Nova', 'Alta', 'Explorar el sector Z-100', false, '2024-06-01'),
(2, 'Misión Eclipse', 'Media', 'Establecer base lunar', true, '2024-05-23'),
(3, 'Proyecto Cosmos', 'Baja', 'Investigación de campo en Marte', true, '2024-04-12'),
(4, 'Voyager X', 'Alta', 'Recolección de muestras de asteroides', false, '2024-05-15');

insert into navesmisiones(numeroMisiones,navecodigo,rol)values 
(1,4,"recolector"),
(2,3,"explorador"),
(3,2,"constructor"),
(4,1,"medico");

insert into pilotosnaves(idPilotos,codigoNaves,informe)values 
(1,2,"informe de Exploracion"),
(2,3,"informe de velocidad"),
(3,1,"informe de reparacion"),
(4,4,"informe de recoleccion");

insert into recursos(id,nombre,precio,codigoNaves,estado)values
(1,"energia",1000.00,1,true),
(2,"metal",2000.00,2,true),
(3,"plantas",1500.00,3,true),
(4,"combustible",3000.00,4,false);

insert into equipos(codigo,nombre,cantidadIntegrante,idPilotos)values
(1,"shadow",5,1),
(2,"opossingforce",9,3),
(3,"lamda",7,2),
(4,"x-force",6,4);

-- -----punto7----- --
update naves set velocidadMaxima = 200.0 where codigo=2;

-- -----punto8----- --
delete from Recursos where id = 2;

-- Tp6 base de datos --

alter table navesmisiones add duracion int;
alter table pilotosnaves add fecha date;

insert into pilotos (id,nombre,experiencia,estado,apodo,apellido) values 
(5,"Luis","3 años de experiencia",true,"Lucho","Garcia"),
(6,"Ana","5 años de experiencia",true,"Anita","Lopez"),
(7,"Pedro","2 años de experiencia",false,"pedrok","Rodriguez"),
(8,"Laura","1 año de experiencia",true,"Lau","Gomez"),
(9,"Diego","4 años de experiencia",true,"Dieguito","Perez");

insert into naves (codigo,nombre,velocidadMaxima,estado)values
(5, 'Falcon', 800.0, true),
(6, 'Tardis', 900.0, false),
(7, 'Rocinante', 650.0, true),
(8, 'Voyager', 720.0, false),
(9, 'Prometheus', 680.0, true);

insert into misiones(numero,nombreClave,dificultad,descripcion,estado,fechaInicio)values
(5, 'Operación Titan', 'Alta', 'Exploración de Saturno', true, '2024-06-10'),
(6, 'Andromeda', 'Baja', 'Estudio de la galaxia de Andromeda', true, '2024-06-05'),
(7, ' Orion', 'Media', 'recursos en el cinturón de asteroides', false, '2024-06-03'),
(8, ' Pegasus', 'Alta', 'Viaje a la nebulosa de Pegasus', true, '2024-06-08'),
(9, ' Kepler', 'Baja', 'Búsqueda de planetas habitables', false, '2024-06-01');

insert into navesmisiones(numeroMisiones,navecodigo,rol,duracion)values 
(5,5,"explorador", 7),
(6,6,"cientifico", 20),
(7,7,"ingeniero", 12),
(8,8,"piloto", 10),
(9,9,"medico", 18);

insert into pilotosnaves(idPilotos,codigoNaves,informe,fecha)values 
(5,3,"informe de Exploracion", '2024-06-11'),
(6,4,"informe de velocidad", '2024-06-10'),
(7,5,"informe de reparacion", '2024-06-09'),
(8,6,"informe de recoleccion", '2024-06-08'),
(9,7,"informe de exploracion", '2024-06-07');

insert into recursos(id,nombre,precio,codigoNaves,estado)values
(5,"agua",500.00,1,true),
(6,"oxigeno",700.00,2,true),
(7,"alimento",800.00,3,true),
(8,"repuestos",1500.00,4,false),
(9,"sensores",2000.00,5,true);

insert into equipos(codigo,nombre,cantidadIntegrante,idPilotos)values
(5,"zeta",4,5),
(6,"delta",8,6),
(7,"omega",6,7),
(8,"sigma",9,8),
(9,"kappa",7,9);

ALTER TABLE misiones change COLUMN dificultad_int dificultad INT;
alter table misiones drop column dificultad;

alter table misiones add column dificultad_int int ;

UPDATE misiones
SET dificultad_int = 200
WHERE dificultad ='media'
LIMIT 2;


-- 1. Muestre todos los pilotos que participan en la guerra espacial.
select * from pilotos;

-- 2. Muestre el numero y la dificultad de todas las misiones.
select numero,dificultad from misiones;

-- 3. Muestre el nombre clave de las misiones cuya dificultad sea mayor a X.
select nombreClave from misiones where dificultad > 100;

-- 4. Muestre el nombre de todas las naves ordenadas alfabéticamente y cuya velocidad
-- máxima sea mayor a X.
select nombre from naves where velocidadMaxima >500 order by nombre Asc;

-- 5. Muestre el nombre y el precio máximo que posee un recurso.
select nombre, MAX(precio) as precio_maximo from recursos group by nombre;

-- 6. Muestre el nombre de todos los pilotos que pertenecen al equipo de nombre X.
select p.nombre from pilotos p join equipos eq on eq.codigo=p.id where eq.nombre='shadow';

-- 7. Seleccione los nombres de las naves que fueron manejadas por pilotos con experiencia
-- igual a X
select nv.nombre from naves nv join pilotosnaves pl on pl.codigoNaves=nv.codigo 
join pilotos p on pl.idPilotos=p.id where p.experiencia = '1 año de experiencia';

-- 8. Muestre el nombre clave y la descripción de las misiones en las cuales se usaron recursos
-- cuyo precio es mayor a X.
select ms.nombreClave,ms.descripcion from misiones ms join navesmisiones nvs on nvs.numeroMisiones=ms.numero 
join naves nv on nv.codigo=nvs.naveCodigo join recursos r on r.codigoNaves=nv.codigo
where r.precio=800.00; 

-- 9. Muestre el informe realizado por el piloto de nombre X que se corresponde con la nave
-- de nombre Y.
select plnv.informe from pilotosNaves plnv  
join pilotos pl on pl.id=plnv.idPilotos  
join naves nv on nv.codigo=plnv.codigoNaves
where pl.nombre='esteban' and nv.nombre='Serenity'; 
 
-- 10. Muestre el nombre de la nave (puede ser más de una) usada por el piloto de nombre X
-- en la misión de nombre clave Y

select nv.nombre from naves nv join pilotosnaves plnv on plnv.codigoNaves=nv.codigo 
join pilotos pl on pl.id=plnv.idPilotos 
join navesMisiones nvm on nvm.naveCodigo=nv.codigo 
join misiones ms on ms.numero=nvm.numeroMisiones where pl.nombre ='Pedro' and ms.nombreClave='Operación Titan';

-- 11. Muestre la cantidad de naves existentes en la guerra espacial.
select count(codigo)as nave_Existente from naves where estado=1;

-- 12. Suponiendo que el estado 1 o true significa “finalizado” y 0 “en proceso”, muestre la
-- cantidad de misiones finalizadas y las que están en proceso.
select count(*) as finalizada from misiones ms join navesmisiones nvms on nvms.numeromisiones=ms.numero
join naves nv on nv.codigo=nvms.naveCodigo where nv.estado=1;

select count(*) as proceso from misiones ms join navesmisiones nvms on nvms.numeromisiones=ms.numero
join naves nv on nv.codigo=nvms.naveCodigo where nv.estado=0;

-- 13. Muestre el total pagado por la nave de nombre X.
select sum(precio)as total from recursos r join naves nv on nv.codigo=r.id where nv.nombre='Falcon';

-- 14. Muestre la cantidad de pilotos que tiene cada equipo
SELECT equipos.nombre, COUNT(pilotos.id) AS cantidad_pilotos
FROM pilotos
JOIN equipos ON pilotos.id = equipos.codigo
GROUP BY equipos.nombre
ORDER BY cantidad_pilotos DESC;

-- 15. Muestre el total de días en los que cada nave estuvo en alguna misión.
select nv.nombre ,sum(nvm.duracion) as total_dias from navesmisiones nvm 
join naves nv on nv.codigo=nvm.navecodigo group by nv.nombre;

-- 16. Muestre la cantidad de informes presentados por el piloto de nombre X.
select pl.nombre,count(plnv.informe) as Cantidad_de_Informe from pilotosnaves plnv 
join pilotos pl on pl.id=plnv.idPilotos where pl.nombre='matias';

-- 17. Muestre el nombre de las naves junto con el total de los precios que pagó.
select nv.nombre,sum(r.precio) as Total from naves nv 
join recursos r on r.id=nv.codigo group by nv.nombre;
