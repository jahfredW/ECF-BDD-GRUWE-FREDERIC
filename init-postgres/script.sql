CREATE USER docker;

GRANT ALL PRIVILEGES ON DATABASE db_covoit TO docker;
--
--  type_utilisateur
--

CREATE TABLE type_utilisateur(
   Id_type SERIAL,
   covoitureur_conducteur VARCHAR(50) ,
   convoitureur_passager VARCHAR(50) ,
   administrateur VARCHAR(50) ,
   PRIMARY KEY(Id_type)
);


--
--  Carburant
--

CREATE TABLE Carburant(
   Id_Carburant SERIAL,
   nom_carburant VARCHAR(50) ,
   prix VARCHAR(50) ,
   PRIMARY KEY(Id_Carburant)
);


--
--  type_vehicule
--

CREATE TABLE type_vehicule(
   Id_type_vehicule SERIAL,
   intitulé VARCHAR(50) ,
   PRIMARY KEY(Id_type_vehicule)
);


--
--  utilisateur
--

CREATE TABLE utilisateur(
   Id_Utilisateur SERIAL,
   nom VARCHAR(50)  NOT NULL,
   prenom VARCHAR(50)  NOT NULL,
   email VARCHAR(50)  NOT NULL,
   telephone VARCHAR(50)  NOT NULL,
   photo BIT VARYING(50) ,
   isActif BOOLEAN,
   Id_type INTEGER NOT NULL,
   PRIMARY KEY(Id_Utilisateur),
   FOREIGN KEY(Id_type) REFERENCES type_utilisateur(Id_type)
);


--
--  stagiaire
--

CREATE TABLE stagiaire(
   Id_Utilisateur INTEGER,
   nom_formation VARCHAR(50)  NOT NULL,
   informations VARCHAR(50) ,
   PRIMARY KEY(Id_Utilisateur),
   FOREIGN KEY(Id_Utilisateur) REFERENCES utilisateur(Id_Utilisateur)
);


--
--  employe
--

CREATE TABLE employe(
   Id_Utilisateur INTEGER,
   duree_contrat DATE,
   role VARCHAR(50)  NOT NULL,
   PRIMARY KEY(Id_Utilisateur),
   FOREIGN KEY(Id_Utilisateur) REFERENCES utilisateur(Id_Utilisateur)
);


--
--  Commentaire
--

CREATE TABLE Commentaire(
   Id_Commentaire SERIAL,
   Id_Utilisateur INTEGER,
   PRIMARY KEY(Id_Commentaire),
   FOREIGN KEY(Id_Utilisateur) REFERENCES utilisateur(Id_Utilisateur)
);
;

--
--  trajet
--

CREATE TABLE trajet(
   Id_trajet SERIAL,
   adresse_depart VARCHAR(50) ,
   heure_depart TIME,
   adresse_arrivee VARCHAR(50) ,
   descriptif VARCHAR(50) ,
   isConducteur BOOLEAN,
   Id_Utilisateur INTEGER NOT NULL,
   PRIMARY KEY(Id_trajet),
   FOREIGN KEY(Id_Utilisateur) REFERENCES utilisateur(Id_Utilisateur)
);


--
--  trajet_regulier
--

CREATE TABLE trajet_regulier(
   Id_trajet INTEGER,
   date_debut DATE,
   date_fin VARCHAR(50) ,
   jour VARCHAR(50) ,
   PRIMARY KEY(Id_trajet),
   FOREIGN KEY(Id_trajet) REFERENCES trajet(Id_trajet)
);


--
--  formateur
--

CREATE TABLE formateur(
   Id_formateur SERIAL,
   Id_Utilisateur INTEGER NOT NULL,
   PRIMARY KEY(Id_formateur),
   FOREIGN KEY(Id_Utilisateur) REFERENCES employe(Id_Utilisateur)
);


--
--  notifications
--

CREATE TABLE notifications(
   Id_notifications SERIAL,
   initutule VARCHAR(50) ,
   message VARCHAR(300) ,
   Id_Utilisateur INTEGER NOT NULL,
   PRIMARY KEY(Id_notifications),
   FOREIGN KEY(Id_Utilisateur) REFERENCES utilisateur(Id_Utilisateur)
);


--
--  formation
--

CREATE TABLE formation(
   Id_Formation SERIAL,
   nom VARCHAR(50)  NOT NULL,
   Id_formateur INTEGER NOT NULL,
   PRIMARY KEY(Id_Formation),
   UNIQUE(nom),
   FOREIGN KEY(Id_formateur) REFERENCES formateur(Id_formateur)
);


--
--  vehicule
--

CREATE TABLE vehicule(
   Id_vehicule SERIAL,
   nombre_places VARCHAR(50) ,
   Id_trajet INTEGER,
   Id_type_vehicule INTEGER NOT NULL,
   PRIMARY KEY(Id_vehicule),
   FOREIGN KEY(Id_trajet) REFERENCES trajet_regulier(Id_trajet),
   FOREIGN KEY(Id_type_vehicule) REFERENCES type_vehicule(Id_type_vehicule)
);


--
--  trajet_ponctuel
--

CREATE TABLE trajet_ponctuel(
   Id_trajet INTEGER,
   jour_du_trajet VARCHAR(50) ,
   Id_vehicule INTEGER,
   PRIMARY KEY(Id_trajet),
   UNIQUE(Id_vehicule),
   FOREIGN KEY(Id_trajet) REFERENCES trajet(Id_trajet),
   FOREIGN KEY(Id_vehicule) REFERENCES vehicule(Id_vehicule)
);


--
--  session_de_formation
--

CREATE TABLE session_de_formation(
   Id_Formation INTEGER,
   Id_Utilisateur INTEGER,
   Id_formateur INTEGER,
   date_debut DATE NOT NULL,
   date_fin VARCHAR(50)  NOT NULL,
   PRIMARY KEY(Id_Formation, Id_Utilisateur, Id_formateur),
   FOREIGN KEY(Id_Formation) REFERENCES formation(Id_Formation),
   FOREIGN KEY(Id_Utilisateur) REFERENCES stagiaire(Id_Utilisateur),
   FOREIGN KEY(Id_formateur) REFERENCES formateur(Id_formateur)
);

--
--  type_vehicule_carburant
--

CREATE TABLE type_vehicule_carburant(
   Id_Carburant INTEGER,
   Id_type_vehicule INTEGER,
   consommation VARCHAR(50) ,
   PRIMARY KEY(Id_Carburant, Id_type_vehicule),
   FOREIGN KEY(Id_Carburant) REFERENCES Carburant(Id_Carburant),
   FOREIGN KEY(Id_type_vehicule) REFERENCES type_vehicule(Id_type_vehicule)
);


--
--  notation
--

CREATE TABLE notation(
   Id_Commentaire INTEGER,
   Id_trajet INTEGER,
   PRIMARY KEY(Id_Commentaire, Id_trajet),
   FOREIGN KEY(Id_Commentaire) REFERENCES Commentaire(Id_Commentaire),
   FOREIGN KEY(Id_trajet) REFERENCES trajet(Id_trajet)
);


--
--  reservation
--

CREATE TABLE reservation(
   Id_Utilisateur INTEGER,
   Id_trajet INTEGER,
   isValided BOOLEAN,
   PRIMARY KEY(Id_Utilisateur, Id_trajet),
   FOREIGN KEY(Id_Utilisateur) REFERENCES utilisateur(Id_Utilisateur),
   FOREIGN KEY(Id_trajet) REFERENCES trajet(Id_trajet)
);

