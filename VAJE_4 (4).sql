USE 2023_pb_vs_ida_rezo;
SET SQL_SAFE_UPDATES = 0;

DROP TABLE IF EXISTS specializacija_zdravnik;
DROP TABLE IF EXISTS laboratorijskiPregled;
DROP TABLE IF EXISTS  zdravilo_recept;
DROP TABLE IF EXISTS medicinskaAsistenca;
DROP TABLE IF EXISTS  recept;
DROP TABLE IF EXISTS specializiraniPregled;
DROP TABLE IF EXISTS  Obisk;
DROP TABLE IF EXISTS Bolnik;
DROP TABLE IF EXISTS Zdravniki;
DROP TABLE IF EXISTS Urnik;
DROP TABLE IF EXISTS naslov;
DROP TABLE IF EXISTS terapija;
DROP TABLE IF EXISTS  specialisticneOrdinacije;
DROP TABLE IF EXISTS specializacija;
DROP TABLE IF EXISTS zdravila;
DROP TABLE IF EXISTS  vrstaPregleda;


CREATE TABLE IF NOT EXISTS Urnik (
  idUrnik INT NOT NULL AUTO_INCREMENT,
  zacetekDel TIME(0) NOT NULL,
  konecDela TIME(0) NOT NULL,
  statusUrnika TINYINT NOT NULL,
  datumZacetekVeljavnosti DATETIME NOT NULL,
  datumKoncaVeljavnosti DATETIME NOT NULL,
  PRIMARY KEY (idUrnik));

CREATE TABLE IF NOT EXISTS Zdravniki (
  idZdravnik INT NOT NULL AUTO_INCREMENT,
  ime VARCHAR(45) NOT NULL,
  priimek VARCHAR(45) NOT NULL,
  datumRojstva DATETIME NOT NULL,
  delovnaDoba INT NOT NULL,
  TK_urnik INT NOT NULL,
  PRIMARY KEY (idZdravnik),
  CONSTRAINT 
    FOREIGN KEY (TK_urnik)
    REFERENCES Urnik (idUrnik)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS naslov(
  idNaslov INT NOT NULL AUTO_INCREMENT,
  ulica VARCHAR(45) NOT NULL,
  postnaSt int  ,
  mesto VARCHAR(45) NOT NULL,
  postnaStevilka INT NOT NULL,
  PRIMARY KEY (idNaslov));

CREATE TABLE IF NOT EXISTS Bolnik (
  idBolnik INT NOT NULL AUTO_INCREMENT,
  ime VARCHAR(45) NOT NULL,
  priimek VARCHAR(45) NOT NULL,
  TK_naslov INT NOT NULL,
  izobrazba VARCHAR(45) NULL,
  datumRojstva DATE NOT NULL,
  TK_izbraniZdravnik INT NOT NULL,
  teza DECIMAL NOT NULL,
  visina DECIMAL NOT NULL,
  PRIMARY KEY (idBolnik),
 
  CONSTRAINT 
    FOREIGN KEY (TK_izbraniZdravnik)
    REFERENCES Zdravniki (idZdravnik)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT 
    FOREIGN KEY (TK_naslov)
    REFERENCES naslov(idNaslov)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS terapija(
  idTerapija INT NOT NULL AUTO_INCREMENT,
  naziv VARCHAR(150) NOT NULL,
  casZdravljenja INT NOT NULL,
  PRIMARY KEY (idTerapija));

CREATE TABLE IF NOT EXISTS Obisk (
  idObisk INT NOT NULL AUTO_INCREMENT,
  razlogObiska VARCHAR(45) NOT NULL,
  predvidenaKontrola DATE NULL,
  TK_bolnik INT NOT NULL,
  datum DATE NOT NULL,
  TK_terapija INT NULL,
  PRIMARY KEY (idObisk),
  CONSTRAINT 
    FOREIGN KEY (TK_bolnik)
    REFERENCES Bolnik (idBolnik)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT 
    FOREIGN KEY (TK_terapija)
    REFERENCES terapija (idTerapija)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS specialisticneOrdinacije (
  idSpecialisticneOrdinacije INT NOT NULL AUTO_INCREMENT,
  ime VARCHAR(45) NOT NULL,
  stZaposlenih INT NOT NULL,
  naslov VARCHAR(45),
  ocena INT NOT NULL,
  PRIMARY KEY (idSpecialisticneOrdinacije));

CREATE TABLE IF NOT EXISTS specializiraniPregled (
  idspecializiraniPregled INT NOT NULL AUTO_INCREMENT,
  TK_bolnik INT NOT NULL,
  TK_zdravnikNapotitelj INT NOT NULL,
  TK_specOrdinacija INT NOT NULL,
  obrazlozitev VARCHAR(45) NOT NULL,
  datumPregleda DATE NOT NULL,
  PRIMARY KEY (idspecializiraniPregled),
  CONSTRAINT 
    FOREIGN KEY (TK_specOrdinacija)
    REFERENCES specialisticneOrdinacije(idSpecialisticneOrdinacije)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT 
    FOREIGN KEY (TK_zdravnikNapotitelj)
    REFERENCES Zdravniki(idZdravnik)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT 
    FOREIGN KEY (TK_bolnik)
    REFERENCES Bolnik (idBolnik)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS medicinskaAsistenca (
  idMedicinskaAsistenca INT NOT NULL AUTO_INCREMENT,
  ime VARCHAR(45) NOT NULL,
  priimek VARCHAR(45) NOT NULL,
  datumRojstva VARCHAR(45) NOT NULL,
  TK_zdravnik INT NOT NULL,
  dostopnost TINYINT NOT NULL,
  PRIMARY KEY (idMedicinskaAsistenca),

  CONSTRAINT 
    FOREIGN KEY (TK_zdravnik)
    REFERENCES Zdravniki (idZdravnik)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS specializacija (
  idSpecializacija INT NOT NULL auto_increment,
  naziv VARCHAR(45) NOT NULL,
  časŠtudija INT NOT NULL,
  PRIMARY KEY (idSpecializacija));

CREATE TABLE IF NOT EXISTS recept (
  idRecept INT NOT NULL auto_increment,
  veljavnost DATE NOT NULL,
  stanje VARCHAR(45) NOT NULL,
  TK_bolnik INT NOT NULL,
  PRIMARY KEY (idRecept),

  CONSTRAINT
    FOREIGN KEY (TK_bolnik)
    REFERENCES Bolnik (idBolnik)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS zdravila (
  idZdravila INT NOT NULL AUTO_INCREMENT,
  ime VARCHAR(45) NOT NULL,
  cena DECIMAL NOT NULL,
  rokPoteka DATE NOT NULL,
  PRIMARY KEY (idZdravila));

CREATE TABLE IF NOT EXISTS vrstaPregleda(
  idVrstaPregleda INT NOT NULL AUTO_INCREMENT,
  ime VARCHAR(45) NOT NULL,
  dostopnostNaOrdinaciji TINYINT NOT NULL,
  PRIMARY KEY (idVrstaPregleda));

CREATE TABLE IF NOT EXISTS laboratorijskiPregled (
  idLaboratorijskiPregled INT NOT NULL AUTO_INCREMENT,
  TK_bolnik INT NOT NULL,
  TK_vrstaPregleda INT NOT NULL,
  TK_napotitelj INT NOT NULL,
  datum DATE NOT NULL,
  PRIMARY KEY (idLaboratorijskiPregled),
 
  CONSTRAINT 
    FOREIGN KEY (TK_vrstaPregleda)
    REFERENCES vrstaPregleda (idVrstaPregleda)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT 
    FOREIGN KEY (TK_bolnik)
    REFERENCES Bolnik (idBolnik)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT 
    FOREIGN KEY (TK_napotitelj)
    REFERENCES Zdravniki (idZdravnik)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS specializacija_zdravnik (
  idSpecializacija_zdravnik INT NOT NULL AUTO_INCREMENT,
  TK_zdravnik INT NOT NULL,
  TK_specializacija INT NOT NULL,
  PRIMARY KEY (idSpecializacija_zdravnik),

  CONSTRAINT zdravnik_tk 
    FOREIGN KEY (TK_zdravnik)
    REFERENCES Zdravniki (idZdravnik)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT 
    FOREIGN KEY (TK_specializacija)
    REFERENCES specializacija (idSpecializacija)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS zdravilo_recept(
  idZdravilo_recept INT NOT NULL AUTO_INCREMENT,
  TK_recept INT NOT NULL,
  TK_zdravilo INT NOT NULL,
  PRIMARY KEY (idZdravilo_recept),
 
  CONSTRAINT
    FOREIGN KEY (TK_recept)
    REFERENCES recept (idRecept)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT 
    FOREIGN KEY (TK_zdravilo)
    REFERENCES zdravila (idZdravila)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


INSERT INTO Urnik values(null,'08:00:00','16:00:00',true,'2023-11-26','2023-01-26');
INSERT INTO Urnik values(null,'08:00:00','12:00:00',true,'2023-01-27','2023-05-26');
INSERT INTO Urnik values(null,'09:00:00','15:00:00',true,'2023-05-27','2023-07-26');
INSERT INTO Urnik values(null,'12:00:00','20:00:00',true,'2023-07-27','2023-09-26');
INSERT INTO Urnik values(null,'07:00:00','15:00:00',true,'2023-09-27','2023-11-27');


INSERT INTO Zdravniki values(null,"ida","rezo",'2002-05-08',5,2);
INSERT INTO Zdravniki values(null,"sabina","mrak",'2002-05-08',5,2);
INSERT INTO Zdravniki values(null,"Janez","Kos",'2002-05-08',5,2);
INSERT INTO Zdravniki values(null,"tea","napast",'2002-05-08',5,2);
INSERT INTO Zdravniki values(null,"nika","jordan",'2002-05-08',5,2);
INSERT INTO Zdravniki values(null,"Ivo","Ranjak",'2002-05-08',5,2);
INSERT INTO Zdravniki values(null,"matic","ban",'2002-05-08',5,2);
INSERT INTO Zdravniki values(null,"nejc","hajsen",'2002-05-08',5,2);
INSERT INTO Zdravniki values(null,"peter","vreternik",'2002-05-08',5,2);
INSERT INTO Zdravniki values(null,"ana","gregel",'2002-05-08',5,2);


INSERT INTO naslov (idNaslov, postnaSt,ulica, mesto, postnaStevilka) VALUES (null,8, 'Dominkuseva Ulica', 'Maribor', 2000);
INSERT INTO naslov (idNaslov,postnaSt, ulica, mesto, postnaStevilka) VALUES (null, 32,'Rozmanova ulica', 'Novo mesto', 8000);
INSERT INTO naslov (idNaslov, postnaSt,ulica, mesto, postnaStevilka) VALUES (null, 12,'Ulica roberta hvalca', 'Ljubljana', 3000);
INSERT INTO naslov (idNaslov, postnaSt,ulica, mesto, postnaStevilka) VALUES (null, null,'Ulica padlih borcev', 'Murska Sobota', 4000);
INSERT INTO naslov (idNaslov, postnaSt,ulica, mesto, postnaStevilka) VALUES (null, null,'Ulica jozeta kranjca', 'Koper', 5000);

INSERT INTO Bolnik VALUES(null,'ana','novak',3,1,'1980-08-02',2,169.00,180.00);
INSERT INTO Bolnik  VALUES(null,'marko','kovac',2,2,'1989-08-23',3,69.00,185.00);
INSERT INTO Bolnik  VALUES(null,'maja','horvat',1,1,'1981-08-15',2,66.00,159.00);
INSERT INTO Bolnik VALUES(null,'luka','zupancic',3,3,'1970-05-21',3,70.00,190.00);
INSERT INTO Bolnik  VALUES(null,'petra','bizjak',3,6,'1963-06-22',3,50.00,173.00);
INSERT INTO Bolnik  VALUES(null,'andrej','jereb',3,8,'1970-07-25',4,100.00,188.00);
INSERT INTO Bolnik VALUES(null,'nika','kos',3,9,'1970-08-01',5,90.00,180.00);
INSERT INTO Bolnik VALUES(null,'miha','svalj',1,8,'1967-03-02',3,89.00,198.00);
INSERT INTO Bolnik  VALUES(null,'sara','resnik',3,2,'1970-02-17',5,78.00,160.00);
INSERT INTO Bolnik  VALUES(null,'jure','vidmar',3,4,'1980-01-15',4,99.00,186.00);



INSERT INTO terapija VALUES(null,'Antibiotiki za bakterijske okužbe',7);
INSERT INTO terapija VALUES(null,'Fizioterapija za poškodbe mišic ali sklepov',300);
INSERT INTO terapija VALUES(null,'Antihistaminiki za alergijske reakcije',10);
INSERT INTO terapija VALUES(null,'Zdravila proti bolečinam za lajšanje akutne bolečine',120);
INSERT INTO terapija VALUES(null,'Antitusični sirup za suh kašelj',4);


INSERT INTO  Obisk VALUES(null,'Kašelj',null,2,'2021-01-01',5);
INSERT INTO  Obisk VALUES(null,'Vročina',null,1,'2023-12-26',1);
INSERT INTO  Obisk VALUES(null,'Bolečine',null,3,'2023-01-26',2);
INSERT INTO  Obisk VALUES(null,'Slabost',null,4,'2021-01-01',null);
INSERT INTO  Obisk VALUES(null,'Bruhanje',null,5,'2023-06-26',2);
INSERT INTO  Obisk VALUES(null,'Zamašen nos',null,3,'2023-08-16',2);
INSERT INTO  Obisk VALUES(null,'Vrtoglavica',null,2,'2023-09-20',2);
INSERT INTO  Obisk VALUES(null,'Utrujenost',null,1,'2023-11-26',2);
INSERT INTO  Obisk VALUES(null,'Srbenje',null,4,'2021-01-01',2);
INSERT INTO  Obisk VALUES(null,'Izpuščaj',null,2,'2023-04-26',2);


INSERT INTO specialisticneOrdinacije values(null,'Ordinacija za dermatologijo',70,null,7);
INSERT INTO specialisticneOrdinacije values(null,'Ordinacija za ortopedijo',40,null,9);
INSERT INTO specialisticneOrdinacije values(null,'Ordinacija za kardiologijo',44,null,6);
INSERT INTO specialisticneOrdinacije values(null,'Ordinacija za nevrologijo',50,null,8);
INSERT INTO specialisticneOrdinacije values(null,'Ordinacija za psihoterapijo',77,null,7);

INSERT INTO specializiraniPregled values(null,1,8,1,'Bolečine v hrbtu','2022-05-08');
INSERT INTO specializiraniPregled values(null,1,9,2,'Bolečine v hrbtu','2023-01-12');
INSERT INTO specializiraniPregled values(null,3,5,4,'Bolečine v hrbtu','2020-05-16');
INSERT INTO specializiraniPregled values(null,2,6,2,'Bolečine v hrbtu','2021-04-08');
INSERT INTO specializiraniPregled values(null,5,5,4,'Bolečine v hrbtu','2020-09-08');
INSERT INTO specializiraniPregled values(null,1,6,2,'Bolečine v hrbtu','2023-07-20');
INSERT INTO specializiraniPregled values(null,4,2,3,'Bolečine v hrbtu','2022-01-01');
INSERT INTO specializiraniPregled values(null,5,2,4,'Bolečine v hrbtu','2024-05-08');
INSERT INTO specializiraniPregled values(null,2,2,1,'Bolečine v hrbtu','2021-09-26');
INSERT INTO specializiraniPregled values(null,3,8,2,'Bolečine v hrbtu','2021-09-17');



INSERT INTO medicinskaAsistenca values(null,'eva','konrad','2023-01-26',1,true);
INSERT INTO medicinskaAsistenca values(null,'tilen','Turk','2023-01-26',1,true);
INSERT INTO medicinskaAsistenca values(null,'filip','Zupan','2023-01-26',1,true);
INSERT INTO medicinskaAsistenca values(null,'lara','golob','2023-01-26',1,true);
INSERT INTO medicinskaAsistenca values(null,'teja','konrad','2023-01-26',1,true);

INSERT INTO specializacija values(null,'Gastroenterologija in hepatologija',4);
INSERT INTO specializacija values(null,'Onkologija in radioterapijaa',5);
INSERT INTO specializacija values(null,'Nefrologija in hipertenzija',6);
INSERT INTO specializacija values(null,'Endokrinologija in presnovne bolezni',8);
INSERT INTO specializacija values(null,'Pulmologija in alergologija',6);


INSERT INTO  recept values(null,'2023-12-06','Aktiven',3);
INSERT INTO  recept values(null,'2023-11-06','Izdan',3);
INSERT INTO  recept values(null,'2023-12-29','Aktiven',3);
INSERT INTO  recept values(null,'2023-12-25','Izdan',3);
INSERT INTO  recept values(null,'2023-12-16','Aktiven',3);
INSERT INTO  recept values(null,'2023-11-30','Izdan',3);
INSERT INTO  recept values(null,'2023-12-01','Preklican',3);
INSERT INTO  recept values(null,'2023-02-16','Preklican',3);
INSERT INTO  recept values(null,'2023-01-08','Pretečen',3);
INSERT INTO  recept values(null,'2023-12-20','Pretečen',3);


INSERT INTO  zdravila values(null,'Paracetamol',30.50,'2023-12-20');
INSERT INTO  zdravila values(null,'Amoxiclav',20.50,'2023-01-28');
INSERT INTO  zdravila values(null,'Ibuprofen',10.80,'2023-11-29');
INSERT INTO  zdravila values(null,'Omeprazol',29.88,'2023-02-18');
INSERT INTO  zdravila values(null,'Atorvastatin',15.50,'2023-12-20');

INSERT INTO vrstaPregleda values(null,'Kontrolni pregled',true);
INSERT INTO vrstaPregleda values(null,'EKG ',true);
INSERT INTO vrstaPregleda values(null,'Ultrazvočni pregled',true);
INSERT INTO vrstaPregleda values(null,'Rentgenski posnetek',true);
INSERT INTO vrstaPregleda values(null,'Laboratorijski test',true);


INSERT INTO laboratorijskiPregled values(null,5,1,2,'2023-12-20');
INSERT INTO laboratorijskiPregled values(null,7,4,1,'2021-10-20');
INSERT INTO laboratorijskiPregled values(null,8,5,4,'2023-11-25');
INSERT INTO laboratorijskiPregled values(null,9,2,5,'2022-06-26');
INSERT INTO laboratorijskiPregled values(null,2,3,2,'2023-05-28');
INSERT INTO laboratorijskiPregled values(null,1,4,2,'2023-04-12');
INSERT INTO laboratorijskiPregled values(null,3,1,1,'2020-04-11');
INSERT INTO laboratorijskiPregled values(null,6,5,1,'2020-09-03');
INSERT INTO laboratorijskiPregled values(null,3,2,4,'2022-12-09');
INSERT INTO laboratorijskiPregled values(null,8,3,2,'2021-12-18');

INSERT INTO specializacija_zdravnik values(null,1,1);
INSERT INTO specializacija_zdravnik values(null,6,5);
INSERT INTO specializacija_zdravnik values(null,5,2);
INSERT INTO specializacija_zdravnik values(null,1,3);
INSERT INTO specializacija_zdravnik values(null,3,4);
INSERT INTO specializacija_zdravnik values(null,1,2);
INSERT INTO specializacija_zdravnik values(null,6,5);
INSERT INTO specializacija_zdravnik values(null,2,2);
INSERT INTO specializacija_zdravnik values(null,6,1);
INSERT INTO specializacija_zdravnik values(null,5,4);


INSERT INTO zdravilo_recept values (null,1,2);
INSERT INTO zdravilo_recept values (null,3,4);
INSERT INTO zdravilo_recept values (null,2,5);
INSERT INTO zdravilo_recept values (null,1,5);
INSERT INTO zdravilo_recept values (null,5,5);
INSERT INTO zdravilo_recept values (null,3,1);
INSERT INTO zdravilo_recept values (null,4,1);
INSERT INTO zdravilo_recept values (null,3,3);
INSERT INTO zdravilo_recept values (null,5,2);
INSERT INTO zdravilo_recept values (null,4,3);


##Kateri bolniki so bili pregledani na dan “1.1.2021”?

select idObisk from Obisk where datum = '2021-1-1';

##Izpišite vse specialistične preglede in osebe ter datum, kdaj so bile osebe nanje
##poslane. Specialistični pregled naj se izpiše, tudi če še nobenega bolnika niso
##poslali nanj.
select specialisticneOrdinacije.idSpecialisticneOrdinacije, specialisticneOrdinacije.ime as id_ordinacije,Bolnik.idBolnik as id_bolnik,Bolnik.ime as ime,Bolnik.priimek as priimek, specializiraniPregled.TK_zdravnikNapotitelj as napotitelj, specializiraniPregled.datumPregleda from specialisticneOrdinacije
left join specializiraniPregled on specialisticneOrdinacije.idSpecialisticneOrdinacije = specializiraniPregled.TK_specOrdinacija
left join Bolnik on specializiraniPregled.TK_bolnik=Bolnik.idBolnik;


 ##Izpišite imena in priimke vseh bolnikov ter izračunajte z rojstnega dneva njihovo starost.
select ime, priimek, TIMESTAMPDIFF(YEAR, datumRojstva, CURDATE()) from Bolnik;

##Kateri zdravnik je opravil največ pregledov?

SELECT Zdravniki.ime, Zdravniki.priimek, COUNT(Bolnik.TK_izbraniZdravnik) AS stevilo_obiskov
FROM Obisk
INNER JOIN Bolnik ON Obisk.TK_bolnik = Bolnik.idBolnik 
INNER JOIN Zdravniki ON Zdravniki.idZdravnik = Bolnik.TK_izbraniZdravnik
GROUP BY Zdravniki.ime, Zdravniki.priimek
HAVING COUNT(Bolnik.TK_izbraniZdravnik) = (
    SELECT MAX(visits)
    FROM (
        SELECT COUNT(Bolnik.TK_izbraniZdravnik) AS visits
        FROM Obisk
        INNER JOIN Bolnik ON Obisk.TK_bolnik = Bolnik.idBolnik 
        INNER JOIN Zdravniki ON Zdravniki.idZdravnik = Bolnik.TK_izbraniZdravnik
        GROUP BY Zdravniki.ime, Zdravniki.priimek
    ) AS MaxVisits
);



 

 ##Kateri dan je doktor “Janez Kos” imel največ pregledov?

SELECT datum, steviloPojavitev
FROM (
    SELECT datum, COUNT(datum) AS steviloPojavitev
    FROM Obisk
    INNER JOIN Bolnik ON Obisk.TK_bolnik = Bolnik.idBolnik
    INNER JOIN Zdravniki ON Bolnik.TK_izbraniZdravnik = Zdravniki.idZdravnik
    WHERE Zdravniki.ime = "Janez" AND Zdravniki.priimek = "Kos"
    GROUP BY datum
) AS tabela
WHERE steviloPojavitev = (
    SELECT MAX(steviloPojavitev)
    FROM (
        SELECT COUNT(datum) AS steviloPojavitev
        FROM Obisk
        INNER JOIN Bolnik ON Obisk.TK_bolnik = Bolnik.idBolnik
        INNER JOIN Zdravniki ON Bolnik.TK_izbraniZdravnik = Zdravniki.idZdravnik
        WHERE Zdravniki.ime = "Janez" AND Zdravniki.priimek = "Kos"
        GROUP BY datum
    ) AS max_counts
);


##V katerih mesecih je število preiskav v laboratoriju večje, kot jih povprečno
##naredijo v vseh mesecih?
select mesec, stevilo_pojavitev
 from (select  monthname(laboratorijskiPregled.datum) AS mesec, COUNT(*) AS stevilo_pojavitev from laboratorijskiPregled 
inner join Bolnik on laboratorijskiPregled.TK_bolnik = Bolnik.idBolnik
inner join vrstaPregleda on  laboratorijskiPregled.TK_vrstaPregleda = vrstaPregleda.idVrstaPregleda
inner join Zdravniki on laboratorijskiPregled.TK_napotitelj = Zdravniki.idZdravnik
GROUP BY mesec
ORDER BY stevilo_pojavitev DESC
) as tabela
where stevilo_pojavitev =(
select max(stevilo_pojavitev)  from 
(select  monthname(laboratorijskiPregled.datum) AS mesec, COUNT(*) AS stevilo_pojavitev from laboratorijskiPregled 
inner join Bolnik on laboratorijskiPregled.TK_bolnik = Bolnik.idBolnik
inner join vrstaPregleda on  laboratorijskiPregled.TK_vrstaPregleda = vrstaPregleda.idVrstaPregleda
inner join Zdravniki on laboratorijskiPregled.TK_napotitelj = Zdravniki.idZdravnik
GROUP BY mesec
ORDER BY stevilo_pojavitev DESC
) as tabela1
);




##Spremeni izobrazbo zdravnika “Ravnjak Ivo” v “specialist splošne medicine”.

update specializacija_zdravnik
inner join specializacija on specializacija_zdravnik.TK_specializacija = specializacija.idSpecializacija
inner join Zdravniki on specializacija_zdravnik.TK_zdravnik = Zdravniki.idZdravnik
set specializacija.naziv = "specialist splošne medicine"
where Zdravniki.ime = "Ivo" and Zdravniki.priimek="Ranjak"
;

##Izbriši zdravilo “Amoxiclav”.
delete from zdravila where ime ="Amoxiclav";