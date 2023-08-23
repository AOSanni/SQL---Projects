/* Create table about the people and what they do here */
CREATE TABLE famous_people (
    id INTEGER PRIMARY KEY ,
    name TEXT,
    occupation TEXT
);

INSERT INTO famous_people (name, occupation)
    VALUES ('Tom Hanks', 'Movie Star');
INSERT INTO famous_people (name, occupation)
    VALUES ('Adele', 'Artist');
INSERT INTO famous_people (name, occupation)
    VALUES ('J.K. Rowling', 'Author');
INSERT INTO famous_people (name, occupation)
    VALUES ('Johnny Depp', 'Movie Star');
INSERT INTO famous_people (name, occupation)
    VALUES ('Chris Brown', 'Artist');
INSERT INTO famous_people (name, occupation)
    VALUES ('Denzel Washinton', 'Movie Star');
INSERT INTO famous_people (name, occupation)
    VALUES ('Brad Pit', 'Movie Star');
INSERT INTO famous_people (name, occupation)
    VALUES ('Angelina Jolie', 'Movie Star');
INSERT INTO famous_people (name, occupation)
    VALUES ('Drake', 'Artist');
INSERT INTO famous_people (name, occupation)
    VALUES ('Billie Eilish', 'Artist');
INSERT INTO famous_people (name, occupation)
    VALUES ('Miley Cyrus', 'Artist');
INSERT INTO famous_people (name, occupation)
    VALUES ('Tom Clancy', 'Author');    
INSERT INTO famous_people (name, occupation)
    VALUES ('El James', 'Author');
INSERT INTO famous_people (name, occupation)
    VALUES ('Stephene Meyer', 'Author');
INSERT INTO famous_people (name, occupation)
    VALUES ('Akira Toriyama', 'Author');
    
    
CREATE TABLE movies (
    id INTEGER PRIMARY KEY,
    title TEXT,
    MovieStar_id INTEGER
    );

INSERT INTO movies (title, MovieStar_id)
    VALUES ('Forrest Gump', 1);
INSERT INTO movies (title, MovieStar_id)
    VALUES ('Toy Story', 1);
INSERT INTO movies (title, MovieStar_id)
    VALUES ('Public Enemies', 4); 
INSERT INTO movies (title, MovieStar_id)
    VALUES ('Pirates of the Caribbean', 4); 
INSERT INTO movies (title, MovieStar_id)
    VALUES ('Inside Man', 6); 
INSERT INTO movies (title, MovieStar_id)
    VALUES ('Flight', 6);   
INSERT INTO movies (title, MovieStar_id)
    VALUES ('Fight Club', 7); 
INSERT INTO movies (title, MovieStar_id)
    VALUES ('12 Years a Slave', 7); 
INSERT INTO movies (title, MovieStar_id)
    VALUES ('The Tourist', 8); 
INSERT INTO movies (title, MovieStar_id)
    VALUES ('Maleficient', 8); 

CREATE TABLE songs (
    id INTEGER PRIMARY KEY,
    title TEXT,
    artist_id INTEGER
);

INSERT INTO songs (title, artist_id)
    VALUES ('Hello', 2);
INSERT INTO songs (title, artist_id)
    VALUES ('Someone Like You', 2);
INSERT INTO songs (title, artist_id)
    VALUES ('Go Crazy', 5);
INSERT INTO songs (title, artist_id)
    VALUES ('Under the Influence', 5);
INSERT INTO songs (title, artist_id)
    VALUES ('PassionFruit', 9);
INSERT INTO songs (title, artist_id)
    VALUES ('Way 2 Sexy', 9);
INSERT INTO songs (title, artist_id)
    VALUES ('Ocean Eyes', 10);    
INSERT INTO songs (title, artist_id)
    VALUES ('bury a friend', 10);    
INSERT INTO songs (title, artist_id)
    VALUES ('Wrecking Ball', 11);
INSERT INTO songs (title, artist_id)
    VALUES ('Malibu', 11);
    
CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    title TEXT,
    author_id INTEGER
);

INSERT INTO books (title, author_id)
    VALUES ('Harry Potter and the Sorcerers Stone', 3);
INSERT INTO books (title, author_id)
    VALUES ('Harry Potter and the Chamber of Secrets', 3);
INSERT INTO books (title, author_id)
    VALUES ('Red Winter', 12);
INSERT INTO books (title, author_id)
    VALUES ('Zero Hour', 12);
INSERT INTO books (title, author_id)
    VALUES ('Fifty Shades of Grey', 13);
INSERT INTO books (title, author_id)
    VALUES ('Fifty Shades Freed', 13);
INSERT INTO books (title, author_id)
    VALUES ('Twilight', 14);   
INSERT INTO books (title, author_id)
    VALUES ('Eclipse', 14);
INSERT INTO books (title, author_id)
    VALUES ('Dragon Ball', 15);
INSERT INTO books (title, author_id)
    VALUES ('Dragon Ball Super', 15);
    
SELECT * FROM famous_people;

--Retrieve movies and their actors:
SELECT m.title as movie_title, 
fp.name as MStar_Names
FROM Movies m
JOIN Famous_people fp
ON m.MovieStar_id = fp.id;

--Retrieve songs and their artists:
SELECT s.title as song_title, 
fp.name as artist_name
FROM songs s
JOIN Famous_people fp
ON s.artist_id = fp.id;

--Retrieve books and their authors:
SELECT b.title as book_title, 
fp.name as author_name
FROM books b
JOIN Famous_people fp
ON b.author_id = fp.id;
