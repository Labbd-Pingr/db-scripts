CREATE TABLE Profile (
  id SERIAL PRIMARY KEY,
  name TEXT,
  bio TEXT,
  username TEXT NOT NULL,
  birth_date DATE,
  CONSTRAINT valid_username CHECK (username ~* '^@+'),
  CONSTRAINT valid_birth_date CHECK (birth_date <= NOW())
);

CREATE TABLE Hashtag (
  id SERIAL PRIMARY KEY,
  global_counter INTEGER DEFAULT 0,
  daily_counter INTEGER DEFAULT 1,
  hashtag TEXT NOT NULL UNIQUE,
  CONSTRAINT valid_hashtag CHECK (hashtag ~* '^#+')
);

CREATE TABLE Account (
  id SERIAL PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  profile_id SERIAL,
  CONSTRAINT valid_email CHECK (email ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),
  FOREIGN KEY (profile_id) REFERENCES Profile(id) ON DELETE CASCADE
);

-- Inserção

INSERT INTO Profile (name, username, birth_date) values ('Thiago Leal', '@leal', '2001-09-04');
INSERT INTO Profile (name, username, birth_date) values ('Daniel Frota', '@frotadani', '1998-01-04');
INSERT INTO Profile (name, username, birth_date) values ('Vinicius Guerrero', '@guerrero', '2001-06-04');

INSERT INTO Account (email, password, profile_id) values ('lealthiago@foo.com', '123', 1);
INSERT INTO Account (email, password, profile_id) values ('frotadaniel@foo.com', '456', 2);
INSERT INTO Account (email, password, profile_id) values ('guerrero@foo.com', '789', 3);

INSERT INTO Hashtag (hashtag) values ('#MonologoNão');
INSERT INTO Hashtag (hashtag) values ('#lula13');
INSERT INTO Hashtag (hashtag) values ('#foraBolsonaro');

-- Verficação
-- Obs: Todas devem falhar

INSERT INTO Profile (name, username, birth_date) values ('Thiago Leal', 'Thiago', '2001-09-04');
INSERT INTO Account (email, password, profile_id) values ('lealthiago@foo.com', '123', 1);
INSERT INTO Account (email, password, profile_id) values ('lealzinho', '123', 1);
INSERT INTO Account (email, password, profile_id) values ('lealzinho@', '123', 1);
INSERT INTO Hashtag (hashtag) values ('#foraBolsonaro');
INSERT INTO Hashtag (hashtag) values ('SeráQueFunciona?');

-- Queries

-- Exiba o perfil de uma conta
SELECT *
FROM Profile as P
JOIN Account as A ON P.id = A.profile_id; 

-- Exiba todos os perfis de pessoas que nasceram no ano 2001
SELECT *
FROM Profile
WHERE birth_date >= '2001-01-01' AND birth_date <= '2001-12-31';

-- Exiba todas as hashtags que foram usadas no dia, ordenadas pela sua frequência
SELECT hashtag
FROM Hashtag
WHERE daily_counter > 0
ORDER BY daily_counter;

-- Exiba todas as hashtags, ordenadas pela sua frequência global
SELECT hashtag
FROM Hashtag
ORDER BY global_counter;

-- Exiba todas as hashtags que são iguais ao username de algum perfil (sem o @)
SELECT H.hashtag
FROM Hashtag as H, Profile as P
WHERE substring(P.username, 2, char_length(P.username) - 1) = substring(H.hashtag, 2, char_length(H.hashtag) - 1);