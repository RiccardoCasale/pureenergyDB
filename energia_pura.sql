USE pureenergy;

 CREATE TABLE attrezzatura(
	attrezzaturaID INT PRIMARY KEY IDENTITY(1,1),
	tipo VARCHAR(250) NOT NULL CHECK (tipo IN ('bicicletta','tapis roulant','pesi')),
	descrizione TEXT NOT NULL,
	stato VARCHAR(250) NOT NULL CHECK (stato IN ('manutenzione','disponibile','fuori servizio')),
	dataAcquisto DATE NOT NULL,
	attivitaRIF INT NOT NULL,
	istruttoreRIF INT NOT NULL,
	FOREIGN KEY(attivitaRIF) REFERENCES attivita(attivitaID),
	FOREIGN KEY(istruttoreRIF) REFERENCES  istruttore(istruttoreID),
	UNIQUE(attrezzaturaID, istruttoreRIF)
);

CREATE TABLE istruttore(
	istruttoreID INT PRIMARY KEY IDENTITY(1,1),
	nominativo VARCHAR(250) NOT NULL,
	orario_lavoro VARCHAR(250) NOT NULL
);

CREATE TABLE attivita(
	attivitaID INT PRIMARY KEY IDENTITY(1,1),
	categoria VARCHAR(250) CHECK (categoria IN('pilates','nuoto','yoga','spinning','sala pesi')),
	giorno VARCHAR(250) NOT NULL CHECK(giorno IN ('Lunedi','Martedi','Mercoledi','Giovedi','Venerdi','Sabato')),
	orario TIME NOT NULL,
	capacita INT NOT NULL,
	istruttoreRIF INT NOT NULL,
	FOREIGN KEY(istruttoreRIF) REFERENCES istruttore(istruttoreID)
);

CREATE TABLE membro(
	membroID INT PRIMARY KEY IDENTITY(1,1),
	nominativo VARCHAR(250) NOT NULL,
	sesso CHAR(1) CHECK (sesso IN('M','F')),
	dataNas DATE NOT NULL,
	email VARCHAR(250) NOT NULL,
	tel VARCHAR(250) NOT NULL,
	UNIQUE (email, tel)
);

CREATE TABLE prenotazione(
	prenotazioneID INT PRIMARY KEY IDENTITY(1,1),
	cancellazione BIT DEFAULT 0,
	dataCancellazione DATE,
	membroRIF INT NOT NULL,
	attivitaRIF INT NOT NULL,
	FOREIGN KEY(membroRIF) REFERENCES membro(membroID) ON DELETE CASCADE,
	FOREIGN KEY(attivitaRIF) REFERENCES attivita(attivitaID) ON DELETE CASCADE,
	UNIQUE (membroRIF , attivitaRIF)
);

CREATE TABLE abbonamento(
	membroID INT PRIMARY KEY IDENTITY(1,1),
	tipo VARCHAR(250) CHECK (tipo IN('settimanale','mensile','annuale')),
	data_inizio DATE NOT NULL,
	data_fine DATE NOT NULL,
	membroRIF INT NOT NULL UNIQUE,
	FOREIGN KEY(membroRIF) REFERENCES membro(membroID) ON DELETE CASCADE
);

--DML
INSERT INTO istruttore (nominativo, orario_lavoro)
VALUES 
('Mario Rossi', '09:00-13:00'),
('Luca Bianchi', '15:00-19:00'),
('Anna Verdi', '08:00-12:00'),
('Francesca Neri', '14:00-18:00'),
('Giulia Galli', '10:00-14:00'),
('Marco Conti', '17:00-21:00'),
('Sara Bruni', '12:00-16:00'),
('Matteo Ferrari', '11:00-15:00'),
('Elena Costa', '08:30-12:30'),
('Alberto Romano', '13:00-17:00');

INSERT INTO attivita (categoria, giorno, orario, istruttoreRIF)
VALUES
('pilates', 'Lunedi', '09:00:00', 1),
('nuoto', 'Martedi', '10:00:00', 2),
('yoga', 'Mercoledi', '08:30:00', 3),
('pilates', 'Giovedi', '14:00:00', 4),
('nuoto', 'Venerdi', '12:00:00', 5),
('yoga', 'Sabato', '17:30:00', 6),
('pilates', 'Lunedi', '12:00:00', 7),
('nuoto', 'Martedi', '11:30:00', 8),
('yoga', 'Mercoledi', '09:30:00', 9),
('pilates', 'Giovedi', '10:00:00', 1);

INSERT INTO membro (nominativo, sesso, dataNas, email, tel)
VALUES
('Alessandro Fabbri', 'M', '1990-04-15', 'alessandro.fabbri@gmail.com', '3331234567'),
('Maria De Luca', 'F', '1985-05-20', 'maria.deluca@gmail.com', '3347654321'),
('Giovanni Bianchi', 'M', '1992-02-10', 'giovanni.bianchi@gmail.com', '3358765432'),
('Simona Gallo', 'F', '1991-07-30', 'simona.gallo@gmail.com', '3369876543'),
('Lorenzo Neri', 'M', '1988-11-18', 'lorenzo.neri@gmail.com', '3370987654'),
('Paola Esposito', 'F', '1994-03-25', 'paola.esposito@gmail.com', '3389876532'),
('Carlo Martini', 'M', '1989-01-08', 'carlo.martini@gmail.com', '3397654321'),
('Giulia Fontana', 'F', '1993-09-11', 'giulia.fontana@gmail.com', '3312345678'),
('Federico Rossi', 'M', '1986-08-14', 'federico.rossi@gmail.com', '3321234567'),
('Chiara Romani', 'F', '1990-12-01', 'chiara.romani@gmail.com', '3395671234');

INSERT INTO attrezzatura (tipo, descrizione, stato, attivitaRIF, istruttoreRIF)
VALUES
('bicicletta', 'Bicicletta da spinning', 'disponibile', 1, 1),
('pesi', 'Set di manubri da 10kg', 'disponibile', 2, 2),
('tapis roulant', 'Tapis roulant elettrico', 'manutenzione', 3, 3),
('bicicletta', 'Bicicletta da spinning', 'disponibile', 4, 4),
('pesi', 'Set di manubri da 15kg', 'disponibile', 5, 5),
('tapis roulant', 'Tapis roulant elettrico', 'disponibile', 6, 6),
('bicicletta', 'Bicicletta da spinning', 'manutenzione', 7, 7),
('pesi', 'Set di manubri da 20kg', 'disponibile', 8, 8),
('tapis roulant', 'Tapis roulant magnetico', 'disponibile', 9, 9),
('bicicletta', 'Bicicletta da corsa', 'disponibile', 10, 1),
('pesi', 'Set di manubri da 5kg', 'manutenzione', 1, 2),
('tapis roulant', 'Tapis roulant manuale', 'disponibile', 2, 3);

INSERT INTO prenotazione (cancellazione, membroRIF, attivitaRIF)
VALUES
(0, 1, 1),
(0, 2, 2),
(1, 3, 3),
(0, 4, 4),
(0, 5, 5),
(1, 6, 6),
(0, 7, 7),
(0, 8, 8),
(1, 9, 9),
(0, 10, 10);

INSERT INTO abbonamento (tipo, data_inizio, data_fine, membroRIF)
VALUES
('mensile', '2024-09-01', '2024-09-30', 1),
('annuale', '2024-01-01', '2024-12-31', 2),
('settimanale', '2024-09-01', '2024-09-07', 3),
('mensile', '2024-09-01', '2024-09-30', 4),
('annuale', '2024-01-01', '2024-12-31', 5),
('mensile', '2024-09-01', '2024-09-30', 6),
('settimanale', '2024-09-01', '2024-09-07', 7),
('annuale', '2024-01-01', '2024-12-31', 8),
('mensile', '2024-09-01', '2024-09-30', 9),
('settimanale', '2024-09-01', '2024-09-07', 10);

--1
SELECT * FROM membro;

--2
SELECT membro.nominativo , abbonamento.tipo
FROM abbonamento
JOIN membro ON abbonamento.membroRIF = membro.membroID
WHERE abbonamento.tipo = 'mensile';

--3
SELECT * 
FROM attivita
WHERE attivita.categoria = 'Yoga';

--4
SELECT istruttore.nominativo , attivita.categoria
FROM istruttore
JOIN attivita ON attivita.istruttoreRIF = istruttore.istruttoreID
WHERE attivita.categoria = 'pilates';

--5
SELECT * 
FROM attivita
WHERE giorno = 'Lunedi';

--6
SELECT *
FROM membro
JOIN prenotazione ON membro.membroID = prenotazione.membroRIF 
JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
WHERE attivita.categoria = 'spinning';

--7
SELECT *
FROM attrezzatura
WHERE attrezzatura.stato = 'manutenzione';

--8.	Conta il numero di partecipanti per ciascuna classe programmata per il mercoledì.
SELECT COUNT(*) AS count 
FROM membro
JOIN prenotazione ON membro.membroID = prenotazione.membroRIF
JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
WHERE attivita.giorno = 'Mercoledi';

--9. Recupera l'elenco degli istruttori disponibili per tenere una lezione il sabato.
SELECT istruttore.nominativo
FROM istruttore
JOIN attivita ON istruttore.istruttoreID = attivita.istruttoreRIF
WHERE attivita.giorno = 'Sabato';

--10. Recupera tutti i membri che hanno un abbonamento attivo dal 2023.
SELECT nominativo
FROM membro
JOIN abbonamento ON membro.membroID = abbonamento.membroRIF
WHERE YEAR(data_inizio) = 2023;

--11. Trova il numero massimo di partecipanti per tutte le classi di sollevamento pesi.
SELECT capacita
FROM attivita;

--12.	Recupera le prenotazioni effettuate da un membro specifico.
SELECT *
FROM prenotazione
JOIN membro ON prenotazione.membroRIF = membro.membroID
WHERE membro.nominativo = 'Luca Ferrari';

--13.	Recupera l'elenco degli istruttori che conducono più di 5 classi alla settimana.
SELECT istruttore.nominativo , attivita.categoria , COUNT(attivita.istruttoreRIF) AS classi
FROM attivita
JOIN istruttore ON attivita.istruttoreRIF = istruttore.istruttoreID
GROUP BY istruttore.nominativo , attivita.categoria
HAVING COUNT(attivita.istruttoreRIF) >= 5;

--14.	Recupera le classi che hanno ancora posti disponibili per nuove prenotazioni.
SELECT attivita.categoria , attivita.capacita , COUNT(prenotazione.attivitaRIF) AS posti_occupati  , attivita.capacita - COUNT(prenotazione.attivitaRIF) AS posti_disponibili
FROM attivita 
JOIN prenotazione ON attivita.attivitaID = prenotazione.attivitaRIF
GROUP BY attivita.categoria , attivita.capacita
HAVING attivita.capacita - COUNT(prenotazione.attivitaRIF) > 0;

--15.	Recupera l'elenco dei membri che hanno annullato una prenotazione negli ultimi 30 giorni.
SELECT *
        FROM prenotazione
        WHERE dataCancellazione IS NOT NULL AND dataCancellazione BETWEEN CAST(DATEADD(DAY, -30 , GETDATE()) AS DATE) AND CAST(GETDATE() AS DATE);

--16.	Recupera tutte le attrezzature acquistate prima del 2022.
SELECT *
FROM attrezzatura
WHERE YEAR(attrezzatura.dataAcquisto) < 2022;

--17.	Recupera l'elenco dei membri che hanno prenotato una classe in cui l'istruttore è "Mario Rossi".
SELECT * 
FROM membro
JOIN prenotazione ON membro.membroID = prenotazione.membroRIF
JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
JOIN istruttore ON attivita.istruttoreRIF = istruttore.istruttoreID
WHERE istruttore.nominativo = 'Marco Rossi';

--18.	Calcola il numero totale di prenotazioni per ogni classe per un determinato periodo di tempo.
SELECT attivita.categoria , COUNT(prenotazione.membroRIF) AS prenotazioni
FROM prenotazione
JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
Where attivita.giorno IN ('Lunedi','Martedi','Mercoledi')
GROUP BY attivita.categoria;

--19.	Trova tutte le classi associate a un'istruttore specifico e i membri che vi hanno partecipato.
SELECT membro.nominativo AS partecipanti , istruttore.nominativo AS istruttore, attivita.categoria, attivita.giorno
FROM membro
JOIN prenotazione ON membro.membroID = prenotazione.membroRIF
JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
JOIN istruttore ON attivita.istruttoreRIF = istruttore.istruttoreID
WHERE istruttore.nominativo = 'Lucia Neri';

--20.	Recupera tutte le attrezzature in manutenzione e il nome degli istruttori che le utilizzano nelle loro classi.
SELECT attrezzatura.tipo , attrezzatura.dataAcquisto , attrezzatura.stato ,istruttore.nominativo
FROM attrezzatura
JOIN istruttore ON attrezzatura.istruttoreRIF = istruttore.istruttoreID
WHERE attrezzatura.stato = 'manutenzione';

--VIEW

--1.	Crea una view che mostra l'elenco completo dei membri con il loro nome, cognome e tipo di abbonamento.
CREATE VIEW mostra_nome_cognome_abbonamento AS
SELECT membro.nominativo , abbonamento.tipo
FROM membro
JOIN abbonamento ON membro.membroID = abbonamento.membroRIF;

SELECT * FROM mostra_nome_cognome_abbonamento;

--2.	Crea una view che elenca tutte le classi disponibili con i rispettivi nomi degli istruttori.
CREATE VIEW classi_disponibili AS
SELECT attivita.categoria , attivita.capacita ,istruttore.nominativo AS istruttore , COUNT(prenotazione.attivitaRIF) AS posti_occupati  , attivita.capacita - COUNT(prenotazione.attivitaRIF) AS posti_disponibili
FROM istruttore 
JOIN attivita ON istruttore.istruttoreID = attivita.istruttoreRIF
JOIN prenotazione ON attivita.attivitaID = prenotazione.attivitaRIF
GROUP BY attivita.categoria , attivita.capacita, istruttore.nominativo
HAVING attivita.capacita - COUNT(prenotazione.attivitaRIF) > 0;

SELECT * FROM classi_disponibili;

--3.Crea una view che mostra le classi prenotate dai membri insieme al nome della classe e alla data di prenotazione.


-- STORAGE PROCEDURE
--1.	Scrivi una stored procedure che permette di inserire un nuovo membro nel sistema con tutti i suoi dettagli, come nome, 
--cognome, data di nascita, tipo di abbonamento, ecc.
CREATE PROCEDURE inserisci_membro
    @nominativo VARCHAR(250),
    @sesso CHAR(1),
    @dataNas DATE,
    @email VARCHAR(250),
    @tel VARCHAR(250)
AS
BEGIN
    -- Controllo che i parametri non siano NULL
    IF @nominativo IS NULL OR @sesso IS NULL OR @dataNas IS NULL OR @email IS NULL OR @tel IS NULL
    BEGIN
        RAISERROR('Tutti i parametri devono essere forniti e non possono essere NULL.', 16, 1);
        RETURN;
    END

    -- Validazione del sesso
    IF @sesso NOT IN ('M', 'F')
    BEGIN
        RAISERROR('Il sesso deve essere "M" o "F".', 16, 1);
        RETURN;
    END

    -- Inserimento nel database
    INSERT INTO membro (nominativo, sesso, dataNas, email, tel)
    VALUES (@nominativo, @sesso, @dataNas, @email, @tel);
END;

EXEC inserisci_membro 
    @nominativo = 'Mario Rossi', 
    @sesso = 'M', 
    @dataNas = '1990-01-01', 
    @email = 'mario.rossi@example.com', 
    @tel = '1234567890';

	SELECT * FROM membro WHERE nominativo = 'Mario Rossi';

















