
/*
CONSULTAS y OPERACIONES DE MANTENIMIENTO
Existen 4 operadores principales para realizar consultas y operaciones de mantenimiento
-	SELECT
-	INSERT
-	UPDATE
-	DELETE
*/


DROP TABLE IF EXISTS tb_tabla01
go
create table tb_tabla01
(
		id				int				not null,
		nombre			varchar(50)		null,
		promedio		decimal(4,2)	null,
		fecha_ingreso	datetime		null
)
go

--INSERCION
/*
Para realizar la insercion se debe utilizar la sentencia INSERT y de manera opcional la sentencia INTO y tambien
de manera opcional la lista de columnas a las cuales se les proveera con valores, el orden de esta lista de columnas
determina el orden en el que se pasan los valores
*/
insert into tb_tabla01 (id, nombre, promedio, fecha_ingreso)
values (1,'kevin',15.9,'2004-04-05T12:30:00.000')
go

insert tb_tabla01 
values (1,'kevin',15.9,'2004-04-05T12:30:00.000')

select * from tb_tabla01 
/*
En las sentencias anteriores, el resultado es el mismo pero con distinta sintaxis
*/

insert tb_tabla01 (id)
values (1)
select * from tb_tabla01 
/*
En la sentencia anterior, solamente se provee valores a una unica columna llamada id, por lo tanto las demas columnas
obtendran su valor por defecto, que en caso no se haya establecido sera NULL
*/
insert tb_tabla01  
values (1,getdate())

/*
En la sentencia anterior, el error está en que no se ha declarado la lista de columnas a las cuales se asignaran
valores en dicha insercion, es decir en caso no provea la lista de columnas entonces la tabla esperará en la
inserción valores para todas las columnas.
*/

insert tb_tabla01 (id,fecha_ingreso) 
values (1,getdate())

/*
La sentencia anterior es la sentencia correcta
*/

select * from tb_tabla01

/*
Existen variaciones de la sentencia INSERT, tales como el INSERT SELECT
*/

go
insert into tb_tabla01 select * from tb_tabla01
select * from tb_tabla01
go
/*
en la sentencia anterior se utiliza el INSERT SELECT para insertar nuevamente en 
la tabla todo el contenido existente en ella
*/

--ACTUALIZACION
/*
Para realizar la actualizacion se debe utilizar la sentencia UPDATE y a continuacion 
se proveerá el nombre de la tabla cuyos registros se actualizaran. Para establecer los 
registros a actualizar es necesario indicar la columna a actualizar junto con el nuevo 
valor que se le proporcionará, en caso sean multiples columnas a actualizar entonces 
se separarán por comas cada una de las columnas a actualizar. Finalmente, es 
recomendable utilizar el operador WHERE para filtrar las filas cuyas columnas 
recibirán la actualización.
*/
DROP TABLE IF EXISTS tb_tabla01
go
create table tb_tabla01
(
		id				int				not null,
		nombre			varchar(50)		null,
		promedio		decimal(4,2)	null,
		fecha_ingreso	datetime		null
)
go
insert into tb_tabla01 (id, nombre, promedio, fecha_ingreso)
values (1,'kevin',18.5,'2004-05-05T02:50:00.00')
insert into tb_tabla01 (id, nombre, promedio, fecha_ingreso)
values (2,'Juan',15.0,'2004-12-05T02:50:00.00')
insert into tb_tabla01 (id, nombre, promedio, fecha_ingreso)
values (3,'Jose',13.1,'2005-08-05T02:50:00.00')
insert into tb_tabla01 (id, nombre, promedio, fecha_ingreso)
values (4,'Luis',17.9,'2003-01-05T02:50:00.00')
insert into tb_tabla01 (id, nombre, promedio, fecha_ingreso)
values (5,'Andre',19.3,'2008-05-01T02:50:00.00')
go
select * from tb_tabla01
go
update tb_tabla01
set nombre = 'Lucho'
where nombre = 'Luis'
select * from tb_tabla01
/*
en la sentencia anterior se actualizó la columna nombre a un nuevo valor donde
el registro a actualizar tuviera 'Luis' como valor en la columna nombre
*/

update tb_tabla01
set nombre = 'Daniel', 
promedio = promedio - 3.0
where id = 1
go
select * from tb_tabla01


/*
en la sentencia anterior, se actualizaron 2 columnas de un registro que cumplía con la 
condición de poseer un id igual a 1
*/

update tb_tabla01
set promedio = 0,
fecha_ingreso = getdate()
where id < 10
go
select * from tb_tabla01

/*
en la sentencia anterior, se realiza un update a la tabla tb_tabla01 donde se proveen
nuevos valores a las columnas promedio y fecha_ingreso para los registros cuyo id
sea menor a 10, es decir todos
*/


--ELIMINACION
/*
Para realizar la eliminacion de registros se debe utilizar la sentencia DELETE y 
de manera opcional la sentencia FROM, a continuacion se proveerá el nombre de la tabla
de la cual se eliminarán los registros. Para establecer los registros a eliminar es 
recomendable utilizar el operador WHERE para filtrar las filas que se eliminarán
*/
select * from tb_tabla01
go
delete from tb_tabla01
where id > 0
go
select * from dbo.tb_tabla01

/*
en la sentencia anterior, se aplica la sentencia DELETE junto con un WHERE para filtrar
los registros a eliminar, lamentablemente este filtro realizado realizado con la 
sentencia WHERE incluye a todos los registros de la tabla, lo cual es equivalente
a eliminar todos los registros de la tabla sin filtro
*/

--SELECCION
/*
SELECT es la sentencia utilizada para recuperar datos de una o mas tablas, esta 
sentencia se utiliza junto con la sentencia FROM de la siguiente manera: 
*/

--tipos de dato de usuario
create type dni
from char(8) not null

if OBJECT_ID ('usuarios') is not null
	drop table usuarios
go
create table usuarios 
(
	id			int,
	nombre		varchar(400),
	dni			dni
)
go
select * from usuarios

--columna calculada
if OBJECT_ID ('ventas') is not null
	drop table ventas
go
create table ventas 
(
	venta_id			int,
	precio				decimal(10,2),
	cantidad			int,
	monto as (precio * cantidad)
)
select * from ventas 
go
insert into ventas (venta_id, precio, cantidad)
values (1,'20.5',5)

select monto,precio  from ventas

if OBJECT_ID ('usuario') is not null
	drop table usuario
go
create table usuario 
(
	id					int,
	fechanac			date,
	edad as (datediff(year,fechanac,getdate()))
)
go
insert into usuario (id, fechanac)
values (1,'1982-02-04')
select * from usuario

/*
USEMOS LA BASE DE DATOS ADVENTUREWORKS

Para lo anterior, debe conectarse a mi servidor. Los datos son los siguientes:

Nombre del servidor:
pucp-curso-db.database.windows.net

Server admin login:
cursopucp

password:
Pucp2023#

*/

USE AdventureWorks
GO

select * from AdventureWorks.Production.Product


--EJERCICIO 01
/*
Usando la tabla Production.Product dentro de la base de datos AdventureWorks, recuperar
todos los registros cuya columna ReorderPoint tenga un valor entre 400 y 600
*/
 select * from Production.Product
 where ReorderPoint >= 400 and ReorderPoint <= 600

 
--EJERCICIO 02
/*
Usando la tabla Production.Product dentro de la base de datos AdventureWorks, recuperar
todos los registros cuya columna ReorderPoint tenga un valor menor que 400 o mayor
que 600
*/
 select * from Production.Product
 where ReorderPoint < 400 or ReorderPoint > 600


--EJERCICIO 03
/*
Usando la tabla Production.Product dentro de la base de datos AdventureWorks, recuperar
todos los registros cuya columna ProductId sea menor que 500 y su color (columna Color)
no sea 'Black' ni 'Red'
*/
select * from Production.Product
where ProductID < 500 and not (Color = 'Black' or Color = 'Red')

select * from Production.Product
where ProductID < 500 and (Color != 'Black' and Color != 'Red')

/*
en las sentencias anteriores hemos trabajado con los operadores lógicos: AND, OR y NOT,
la precedencia es la misma que en la lógica convencional, es decir primera AND y luego
OR, quedando NOT para negar ambos operadores sin importar el orden. Para cambiar la 
precedencia de los operadores es posible usar los parentesis.
*/

--OPERADORES LOGICOS
/*
- AND
- OR 
- NOT
*/
--OPERADORES ARITMETICOS
/*
- +
- -
- *
- /
- ^
- %
*/
--OPERADORES DE COMPARACION
/*
- =
- >=
- <=
- !=
*/

/*
en la sentencia anterior, se observa como el operador AND posee mayor precedencia que 
el operador OR, de tal manera que la agrupacion natural de las condiciones sea
	-	ProductID < 500 and Color = 'Black'
	-	Color = 'Red'
por lo que se quedará con dos condiciones unicamente. Es decir ingresarán en el 
resultado final ya sea los productos cuyo ProductId sea menor a 500 y cuyo Color
sea 'Black' o también aquellos productos que cumplan con la única condición de tener
un Color igual a 'Red', sin cumplir la condición del ProductID
*/

--SELECCION DE DATOS Y BUSQUEDA CON PATRONES
/*
En SQL Server se utiliza el operador LIKE para realizar búsquedas aproximadas,
este operador es similar al operador =, con la diferencia de que cuando se usa 
con patrones es más potente y permite extender las búsqueda hasta aproximaciones
además de búsquedas exactas. Los patrones de búsqueda usados con el operador LIKE
son los siguientes:
*/
/*
	%	-->		es un comodín que representa cero, uno o más caracteres dentro de una 
				cadena
*/
select * from AdventureWorks.Person.Contact where FirstName like 'Al%'
/*	
	en la sentencia anterior se devuelven los nombres que inicien con la cadena 'Al'
*/

select * from AdventureWorks.Person.Contact where FirstName = 'Al%'
/*	
	en la sentencia anterior se devuelven los nombres que sean 'Al%'
*/

select * from AdventureWorks.Person.Contact where FirstName like 'Alan'

/*	
	en la sentencia anterior se devuelven los nombres que sean 'Alan'
*/

select * from AdventureWorks.Person.Contact where FirstName like '%A%'
/*	
	en la sentencia anterior se devuelven los nombres que contengan la letra A
	en cualquier parte de la cadena
*/

/*
	_	-->		es un comodín que representa una posición dentro de una cadena, esta 
				posición puede ser cualquier caracter incluído un espacio en blanco
*/

	select * from AdventureWorks.Person.Contact where FirstName like 'A___'
/*	
	en la sentencia anterior se devuelven los nombres que contengan la letra A
	al inicio de la cadena y 3 caracteres de cualquier tipo, incluido espacios
	en blanco
*/

	select * from AdventureWorks.Person.Contact where FirstName like '_a_'
/*	
	en la sentencia anterior se devuelven los nombres de 3 caracteres que contengan 
	la letra a en la segunda posición de la cadena y cualquier caracter ya sea en 
	su primera o tercera posición
*/

	select * from AdventureWorks.Person.Contact where FirstName like 'a__%'
	
/*	
	en la sentencia anterior se devuelven los nombres de 3 o más caracteres que 
	contengan la letra a en la primera posición de la cadena y cualquier caracter en su
	segunda o tercera posición
*/

	select * from AdventureWorks.Person.Contact where FirstName like '%a__%'
	
/*	
	en la sentencia anterior se devuelven los nombres de 3 o más caracteres que 
	contengan una cadena de 3 letras: a en la primera posición de la cadena y 
	cualquier caracter en su segunda o tercera posición de la cadena de 3 letras
*/

/*
	[]	-->		son comodines que van a encerrar un conjunto de caracteres permitidos
				en una posición dada de una cadena
*/
	select * from AdventureWorks.Person.Contact where FirstName like '_[aeiou]%'
/*	
	en la sentencia anterior se devuelven los nombres de 2 o más caracteres que 
	contengan en la primera posición de la cadena un caracter cualquiera y en 
	la segunda posición una vocal.
*/
	select * from AdventureWorks.Person.Contact where Phone like '[7][0-9][6]-%'
	
/*	
	en la sentencia anterior se devuelven las cadenas de texto del campo telefono
	de al menos 4 caracteres que tengan en la primera posicion un 7, en la segunda 
	posicion un numero del 0 al 9, en la tercera posicion un 6 y en la cuarta 
	posicion un guion (-)
*/

	select * from AdventureWorks.Person.Contact 
	where FirstName like '[aeiou][a-z]%[aeiou]'
/*	
	en la sentencia anterior se devuelven las cadenas de texto del campo Nombre
	de al menos 3 caracteres que tengan en la primera y la última posicion una 
	vocal y en la segunda posición una letra de la A a la Z
*/

/*
	[^]		-->	es un comodin que complementa los comodines [], que se ubica al 
				principio y que indica que los caracteres que le siguen no pueden
				ir dentro de esa posición en la cadena
*/
	select * from AdventureWorks.Person.Contact 
	where FirstName like '[^aeiou]%[^aeiou]'

/*	
	en la sentencia anterior se devuelven las cadenas de texto del campo Nombre
	de al menos 2 caracteres que NO tengan en la primera ni en la última posicion 
	una vocal.
*/

	select * from AdventureWorks.Person.Contact 
	where Phone like '9[^1-8]%'
/*	
	en la sentencia anterior se devuelven las cadenas de texto del campo Telefono
	de al menos 2 caracteres que tengan en la primera posicion un 9 y en la segunda 
	posicion no tenga un caracter del 1 al 8.
*/



--OPERADOR BETWEEN
/*
El operador BETWEEN permite ejecutar consultas que ejecutan búsquedas basadas en rango de 
valores numéricos, valores de cadena, ó valores de fecha.
*/

	select * from AdventureWorks.Person.Contact 
	where FirstName between 'A' and 'D'
	order by FirstName 

	select * from AdventureWorks.Person.Contact 
	where FirstName like '[a-d]%'
	order by FirstName desc

/*
en el ejemplo anterior se busca todos los registros de la tabla Contact en la base de datos AdventureWorks
cuyo valor del campo FirstName esten ubicadas en el abecedario entre la letra A y la letra D, este operador
incluye los valores que sean iguales a los limites indicados
*/
	select * from AdventureWorks.Person.Contact 

	select * from AdventureWorks.Person.Contact 
	where ContactID between 1 and 1000
	order by  ContactID DESC
	
/*
en el ejemplo anterior se busca todos los registros de la tabla Contact en la base de datos AdventureWorks
cuyo valor del campo ContactId este entre los valores 1 y 1000, incluyendo a los valores indicados como
extremos
*/


--EJERCICIO 04
/*
Usando la tabla Production.Product dentro de la base de datos AdventureWorks, recuperar
todos los registros cuya columna ListPrice esté entre 100 y 200 o 1000 y 1500. Utilizar
el operador BETWEEN
*/	

SELECT * FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 200 OR
	  ListPrice BETWEEN 1000 AND 1500


SELECT * FROM Production.Product
WHERE ListPrice>=100 AND ListPrice<=200 or ListPrice >=1000 and ListPrice <=1500



--OPERADOR IN
/*
El operador IN permite ejecutar consultas que ejecutan búsquedas basadas en conjuntos de 
valores numéricos, valores de cadena, ó valores de fecha.
*/

select * from AdventureWorks.Production.Product 

select * from AdventureWorks.Production.Product 
where Size  in ('40','42','44','46','48','50')
order by Size  desc


select * from AdventureWorks.Production.Product 
where	Size = '40' 
	or	Size = '42' 
	or	Size = '44'
	or	Size = '46'
	or	Size = '48'
	or	Size = '50'
order by Size


--BUSQUEDA DE VALORES NULL
/*
Un valor NULL indica que el valor es desconocido, no aplicable, ó que simplemente se registrará 
posteriormente. Un valor NULL es distinto a una cadena vacía ó al valor cero (0), y también es 
distinto a cualquier otro valor NULL.
La busqueda para valores NULL se realiza con el operador IS y no con el operador =
*/

select * from AdventureWorks.Production.Product 

select * from AdventureWorks.Production.Product 
where Size IS NULL

select * from AdventureWorks.Production.Product 
where Size = NULL


--FUNCIONES DE FECHA
/*
SQL Server ofrece un conjunto de funciones de fecha.
*/
SELECT DATEPART(year, GETDATE())
SELECT DATEPART(DAYOFYEAR, GETDATE())
SELECT DATEPART(month, GETDATE())
SELECT DATEPART(WEEKDAY, GETDATE())
SELECT DATEPART(month, '2010-05-08T00:00:00')
SELECT year('2010-05-08T00:00:00')
SELECT DATEPART(MONTH, '2010-05-08T00:00:00')
SELECT month('2010-05-08T00:00:00')
SELECT DATEPART(DAY, '2010-05-08T00:00:00')
SELECT day('2010-05-08T00:00:00')

/*

DATEPART(interval, date) esta función devuleve un valor especifico de la fecha. Ademas, se lo retorna como entero.
*/

select DATEDIFF(year,'1982-02-04T00:00:00',GETDATE())
select DATEDIFF(day,'1982-02-04T00:00:00',GETDATE())

/*
DATEDIFF(interval, date1, date2) esta función devuelve la diferencia en años de dos fechas

*/

SELECT DATENAME(day, '2017/08/25') AS datenamecolm
SELECT DATENAME(WEEKDAY, '2023/06/26') AS DatePartString
/*
 DATENAME(interval, date) esta funcion retorna una valor especifico de la fecha. Ademas, lo retorna como cadena.


*/
--EJERCICIO 05
/*
Usando la tabla Sales.SalesOrderHeader dentro de la base de datos AdventureWorks, recuperar
todos los registros cuya columna OrderDate tenga una fecha cuyo año sea 2003. Utilizar
la funcion DATEPART
*/	

SELECT * FROM Sales.SalesOrderHeader
WHERE DATEPART(year, OrderDate)= 2003
ORDER BY OrderDate 


--EJERCICIO 06
/*
Usando la tabla Sales.SalesOrderHeader dentro de la base de datos AdventureWorks, recuperar
todos los registros cuya columna OrderDate tenga una fecha cuyo antiguedad sea menor que 20 años.
Utilizar la funcion DATEDIFF
*/	

SELECT * FROM Sales.SalesOrderHeader
WHERE DATEDIFF(year,OrderDate,getdate())<20
order by OrderDate desc



--EJERCICIO 07
/*
Obtener el nombre del dia de su fecha de nacimiento. Usar la funcion DATENAME
*/	

SELECT DATENAME(WEEKDAY,'1993-01-09T00:00:00')


--EJERCICIO 08
/*
Usando la tabla Person.Contact dentro de la base de datos AdventureWorks, recuperar
todos los registros cuya columna LastName inicie y termine con las letras n, s, t o p 
o tenga una vocal en la segunda y cuarta posición
*/

SELECT * FROM Person.Contact
WHERE LastName LIKE '[nstp]%[nstp]' or
	  LastName LIKE '_[aeiou]_[aeiou]%'
