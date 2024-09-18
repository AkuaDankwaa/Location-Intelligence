CREATE EXTENSION postgis;

--calling all tables
SELECT * FROM residential;
SELECT * FROM schools;
SELECT * FROM parks;

SELECT school, ST_GeometryType(geom), ST_SRID(geom) 
FROM schools;

SELECT ST_X(geom), ST_Y(geom) 
FROM residential
WHERE residential.type = 'Single Family House'

SELECT park, ST_GeometryType(geom), ST_SRID(geom) 
FROM parks;

SELECT ST_NRings(geom)
FROM parks;

--sort residential table using first criterion(lease and type)
CREATE TABLE resident_result1 AS
SELECT gid, res.type, askprice, bedrooms, res.sale_lease, geom, subdivis_3 as buildyear
FROM residential as res
WHERE res.type = 'Single Family House'
 AND res.sale_lease = 'Sale';

SELECT COUNT(*) FROM resident_result1;



--sort resident_result1 table using second criterion(bedroom number, buildyear and price)
CREATE TABLE resident_result2 AS
SELECT *
FROM resident_result1
WHERE bedrooms = 3 AND buildyear >= 1990
	AND askprice >= 175000 AND askprice <= 225000 
;

SELECT COUNT(*) FROM resident_result2;

--sorting school table based on criteria(school names)
CREATE TABLE Schools_result AS 
SELECT *
FROM schools
WHERE school = 'Arnie Primary' 
 OR school = 'Melvin Elementary'
 ;

CREATE TABLE residents_inSchool AS
SELECT resident_result2.*
FROM resident_result2, Schools_result
WHERE ST_Within(resident_result2.geom, Schools_result.geom);

SELECT COUNT(*) FROM residents_inSchool;

--sort table residents_in School using final criterion(within 2 miles of Terry Athletic Park)

SELECT ST_X(ST_Centroid(geom)) AS longitude
FROM parks
WHERE park = 'Terry Athletic Park';

SELECT ST_SRID(geom)
FROM parks
WHERE park = 'Terry Athletic Park';

SELECT ST_SRID(geom)
FROM residents_inSchool;

--srid is undefined implies set and update tables
--source data used custom projection - Lambert Conformal Conic 
-- where:
--Standard_Parrallel_1 = 38.71666666
--Standard_Parrallel_2 = 39.78333333
--Latitude of origin = 38.3333333
--Central Meridian = -98.0
INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext)
VALUES (
	900001,
	'custom',
	900001,
	'+proj=lcc +lat_1=XX +lat_2=YY +lat_0=ZZ +lon_0=AA +x_0=1312333.333 +y_0=0 +datum=WGS84 +units=m +no_defs',
	'PROJCS["Custom_Lambert_Conformal_Conic", GEOGCS["GCS_WGS_1984", DATUM["D_WGS_1984", SPHEROID["WGS_1984", 6378137.0, 298.257223563]], PRIMEM["Greenwich", 0.0], UNIT["Degree", 0.0174532925199433]], PROJECTION["Lambert_Confromal_Conic"], PARAMETER["False_Easting", 1312333.333], PARAMETER["False_Northing", 0.0], PARAMETER["Central_Meridian", -98.0], PARAMETER["Standard_Parallel_1",38.7166666666667], PARAMETER["Standard_Parallel_2", 39.78333333333333], PARAMETER["Latitude_Of_Origin", 38.333333333333], UNIT["Meter", 1.0]]'
);

UPDATE parks
SET geom = ST_SETSRID(geom, 900001)
WHERE ST_SRID(geom) = 0;


SELECT DISTINCT ST_SRID(geom) AS srid
FROM residents_inSchool;

---set custom srid for residents_inSchool
select ST_SRID(geom)
from residents_inSchool;

UPDATE residents_inSchool
SET geom = ST_SETSRID(geom, 900001)
WHERE ST_SRID(geom) = 4269;

SELECT residents_inSchool.*
FROM residents_inSchool
JOIN parks
ON ST_DWithin(
	residents_inSchool.geom,
	ST_Buffer(parks.geom, 3218.68), 0)-- 2 mile = 3218.68 meters
WHERE parks.park = 'Terry Athletic Park'
 AND ST_SRID(parks.geom) = 900001
 AND ST_SRID(residents_inSchool.geom) = 900001
;

SELECT * FROM residential 
WHERE gid = 173;

-- The single-family house that meets all the Garcias' criteria is a 1245 sq.ft., 
--one-story home built in 1996, located on Meadowood Dr., listed for $199,200.




