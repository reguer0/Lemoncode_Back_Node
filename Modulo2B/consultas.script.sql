--Listar las pistas (tabla Track) con precio mayor o igual a 1

SELECT trackid , name, unitprice FROM track
WHERE unitprice >= 1


--Listar las pistas de más de 4 minutos de duración

SELECT trackid , name, milliseconds FROM track
WHERE milliseconds > 240000

--Listar las pistas que tengan entre 2 y 3 minutos de duración

SELECT trackid , name, milliseconds FROM track
WHERE milliseconds BETWEEN 120000 AND 180000

--Listar las pistas que uno de sus compositores (columna Composer) sea Mercury

    --esta sentencia dice que el nombre contenga Mercury 
        SELECT trackid , name, composer FROM track
        WHERE composer LIKE '%Mercury%'

    --esta dice que el nombre sea Mercury solo 
        SELECT trackid , name, composer FROM track
        WHERE composer LIKE 'Mercury'

--Calcular la media de duración de las pistas (Track) de la plataforma
SELECT AVG(milliseconds) AS duracion_media FROM track

--Listar los clientes (tabla Customer) de USA, Canada y Brazil
SELECT customerid , firstname, lastname, country FROM customer
WHERE country IN ('USA', 'Canada', 'Brazil')

--Listar todas las pistas del artista 'Queen' (Artist.Name = 'Queen')
SELECT t.trackid , t.name, a.name AS artist_name FROM track t 
JOIN artist a ON t.trackid = a.artistid
WHERE a.name = 'Queen'  

--Listar las pistas del artista 'Queen' en las que haya participado como compositor David Bowie
SELECT t.trackid , t.name, t.composer, a.name AS artist_name FROM track t 
JOIN artist a ON t.trackid = a.artistid
WHERE a.name = 'Queen' AND t.composer LIKE '%David Bowie%'

--Listar las pistas de la playlist 'Heavy Metal Classic'
SELECT t.trackid , t.name, p.name AS playlist_name FROM track t
JOIN playlisttrack pt ON t.trackid = pt.trackid
JOIN playlist p ON pt.playlistid = p.playlistid
WHERE p.name = 'Heavy Metal Classic'

--Listar las playlist junto con el número de pistas que contienen
SELECT p.playlistid , p.name, COUNT(pt.trackid) AS numero_de_pistas FROM playlist p
JOIN playlisttrack pt ON p.playlistid = pt.playlistid
GROUP BY p.playlistid , p.name  

--Listar las playlist (sin repetir ninguna) que tienen alguna canción de AC/DC
SELECT DISTINCT p.playlistid , p.name FROM playlist p
JOIN playlisttrack pt ON p.playlistid = pt.playlistid
JOIN track t ON pt.trackid = t.trackid
JOIN album al ON t.albumid = al.albumid
JOIN artist ar ON al.artistid = ar.artistid
WHERE ar.name = 'AC/DC'

--Listar las playlist que tienen alguna canción del artista Queen, junto con la cantidad que tienen
SELECT p.playlistid , p.name, COUNT(t.trackid) AS numero_de_pistas FROM playlist p
JOIN playlisttrack pt ON p.playlistid = pt.playlistid
JOIN track t ON pt.trackid = t.trackid
JOIN album al ON t.albumid = al.albumid
JOIN artist ar ON al.artistid = ar.artistid
WHERE ar.name = 'Queen'
GROUP BY p.playlistid , p.name

--Listar las pistas que no están en ninguna playlist
SELECT t.trackid , t.name FROM track t
LEFT JOIN playlist pl ON t.trackid = pl.playlistid
WHERE pl.playlistid IS NULL

--Listar los artistas que no tienen album
SELECT a.artistid , a.name FROM artist a
LEFT JOIN album al ON a.artistid = al.artistid
WHERE al.albumid IS NULL

--Listar los artistas con el número de albums que tienen
 --Para saber si está bien, asegurate que algunos de los artistas de la query anterior (artistas sin album) aparecen en este listado con 0 albums
SELECT a.artistid , a.name, COUNT(al.albumid) AS numero_de_albums FROM artist a
LEFT JOIN album al ON a.artistid = al.artistid
GROUP BY a.artistid , a.name    