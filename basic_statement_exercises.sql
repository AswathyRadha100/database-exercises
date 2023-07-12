#################################################
#     Basic Statements                          #       
#                                               #
#################################################



-- Use the albums_db database.
SHOW DATABASES;
USE albums_db;

 -- To see the table in albums_db database
SHOW TABLES;
-- 'albums'

-- SELECT name, sales AS low_selling_albums FROM albums WHERE sales <20 ;
SELECT name, sales AS low_selling_albums
FROM albums
WHERE sales < 20;

-- What is the primary key for the albums table?
SHOW KEYS FROM albums WHERE Key_name = 'PRIMARY';
-- or
DESCRIBE albums_db.albums;
-- The primary key in albums table is id


-- What does the column named 'name' represent?
--  'name' in the 'albums' table represents the name or title of an album.

-- What do you think the sales column represents?
-- It represent the total number of copies sold

-- Find the name of all albums by Pink Floyd.
SELECT name FROM albums WHERE artist = 'Pink Floyd';
/* albums by Pink Floyd are
'The Dark Side of the Moon'
 'The Wall' */


-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';
-- Sgt. Pepper's Lonely Hearts Club Band was released in 1967

-- What is the genre for the album Nevermind?
SELECT genre FROM albums WHERE name = 'Nevermind';
-- 'Grunge, Alternative rock'

-- Which albums were released in the 1990s?
SELECT name FROM albums WHERE release_date LIKE '199%';
-- OR 
SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999;
/*
'The Bodyguard'
'Jagged Little Pill'
'Come On Over'
'Falling into You'
'Let\'s Talk About Love'
'Dangerous'
'The Immaculate Collection'
'Titanic: Music from the Motion Picture'
'Metallica'
'Nevermind'
'Supernatural'

*/

-- Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT name AS low_selling_albums
FROM albums
WHERE sales < 20000000;


/*
'Thriller'
'Back in Black'
'The Dark Side of the Moon'
'Bat Out of Hell'
'The Bodyguard'
'Their Greatest Hits (1971–1975)'
'Saturday Night Fever'
'Rumours'
'Grease: The Original Soundtrack from the Motion Picture'
'Led Zeppelin IV'
'Bad'
'Jagged Little Pill'
'Come On Over'
'Falling into You'
'Sgt. Pepper\'s Lonely Hearts Club Band'
'Hotel California'
'Dirty Dancing'
'21'
'Let\'s Talk About Love'
'1'
'Dangerous'
'The Immaculate Collection'
'Abbey Road'
'Born in the U.S.A.'
'Brothers in Arms'
'Titanic: Music from the Motion Picture'
'Metallica'
'Nevermind'
'The Wall'
'Supernatural'
'Appetite for Destruction'

*/
