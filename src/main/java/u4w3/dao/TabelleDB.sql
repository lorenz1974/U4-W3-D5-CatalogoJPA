CREATE DATABASE "u4-w3-d5-catalogoJPA"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Italian_Italy.1252'
    LC_CTYPE = 'Italian_Italy.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE elementi_catalogo (
    id SERIAL PRIMARY KEY,
    codice_isbn VARCHAR(13) UNIQUE NOT NULL,
    titolo VARCHAR(255) NOT NULL,
    anno_pubblicazione INT NOT NULL,
    numero_pagine INT NOT NULL,
    tipo VARCHAR(31) NOT NULL
);

CREATE TABLE libri (
    id INT PRIMARY KEY,
    autore VARCHAR(255) NOT NULL,
    genere VARCHAR(255) NOT NULL,
    FOREIGN KEY (id) REFERENCES elementi_catalogo(id)
);


CREATE TABLE riviste (
    id INT PRIMARY KEY,
    periodicita VARCHAR(50) NOT NULL CHECK (periodicita IN ('SETTIMANALE', 'MENSILE', 'SEMESTRALE')),
    FOREIGN KEY (id) REFERENCES elementi_catalogo(id)
);

CREATE TABLE utenti (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cognome VARCHAR(255) NOT NULL,
    data_nascita DATE NOT NULL,
    numero_tessera VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE prestiti (
    id SERIAL PRIMARY KEY,
    utente_id INT NOT NULL,
    elemento_catalogo_id INT NOT NULL,
    data_inizio_prestito DATE NOT NULL,
    data_restituzione_prevista DATE NOT NULL,
    data_restituzione_effettiva DATE,
    FOREIGN KEY (utente_id) REFERENCES utenti(id),
    FOREIGN KEY (elemento_catalogo_id) REFERENCES elementi_catalogo(id)
);