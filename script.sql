CREATE TABLE Profile (
  id SERIAL PRIMARY KEY,
  name TEXT,
  bio TEXT,
  username TEXT NOT NULL,
  birth_date DATE,
  CONSTRAINT valid_username CHECK (username ~* '^@+'),
  CONSTRAINT valid_birth_date CHECK (birth_date <= NOW())
);

CREATE TABLE Hashtags (
  id SERIAL PRIMARY KEY,
  global_counter INTEGER DEFAULT 0,
  daily_counter INTEGER DEFAULT 1,
  hashtag TEXT NOT NULL
);

CREATE TABLE Account (
  id SERIAL PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  password TEXT,
  CONSTRAINT valid_email CHECK (email ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')
);