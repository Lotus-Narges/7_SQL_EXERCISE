EXERCICE 1:
representation (*num_rep*, titre_rep, lieu)
musicien (*nom*, *num_rep*)
programmer (*date*, *num_rep*, tarif)


a)Donner la liste des titres des représentations
    SELECT titre_rep
    FROM representation;

b)Donner la liste des titres des représentations ayant lieu à l'opéra Bastille
    SELECT titre_rep
    FROM representation
    WHERE lieu = 'opéra Bastille';

c)Donner la liste des noms des musiciens et des titres des représentations auxquelles ils participent  
    SELECT musicien.nom, representation.titre_rep
    FROM musicien
    JOIN representation
    ON musicien.num_rep = representation.num_rep;

d)Donner la liste des titres des représentations, les lieux et les tarifs pour la journée du 14/09/2014.  
    SELECT representation.titre_rep,  representation.lieu, programmer.tarif
    FROM representation
    JOIN programmer
    ON representation.num_rep = programmer.num_rep
    WHERE programmer.date = '14-09-2014';


EXERCICE 2:
etudiant (*num_etudiant*, nom, prenom)
matiere (*codemat*, libellmat, coeffmat)
evaluer (*num_etudiant*, *codemat*, date, note)


a)Quel est le nombre total d'étudiants ?  
    SELECT COUNT (num_etudiant)
    FROM etudiant;

b)Quelles sont, parmi l'ensemble des notes, la note la plus haute et la note la plus basse ?
    SELECT MAX / MIN (note)
    FROM evaluer;

c)Quelles sont les moyennes de chaque étudiant dans chacune des matières ? (utilisez
    CREATE VIEW)
    CREATE VIEW [moyenne] AS
    SELECT etudiant.nom, etudiant.prenom, matiere.libellmat, matiere.coeffmat, AVG(evaluer.note)
    FROM etudiant
    JOIN evaluer
    ON etudiant.num_etudiant = evaluer.num_etudiant
    JOIN matiere
    ON evaluer.codemat = matiere.codemat;

d)Quelles sont les moyennes par matière ? (cf. question c)
    SELECT AVG (evaluer.note), matiere.libellmat
    FROM evaluer
    JOIN matiere
    ON evaluer.codemat = matiere.codemat;

# e)Quelle est la moyenne générale de chaque étudiant ? (utilisez CREATE VIEW + cf. question c)  
#     CREATE VIEW [moyenne-etudiant] AS 
#     SELECT etudiant.nom, etudiant.prenom, 
#     FROM etudiant
#     UNION
#     SELECT AVG (evaluer.note)
#     FROM evaluer;

f)Quelle est la moyenne générale de la promotion ? (cf. question e)  
    SELECT AVG (evaluer.note)
    FROM evaluer;

# g)Quels sont les étudiants qui ont une moyenne générale supérieure ou égale à la moyenne
# générale de la promotion ? (cf. question e)
#     SELECT etudiant.nom, etudiant.prenom
#     FROM etudiant
#     UNION 
#     SELECT AVG (evaluer.note)
#     FROM evaluer
#     WHERE evaluer.note >= (
#         SELECT AVG (evaluer.note)
#         FROM evaluer;
#         );


EXERCICE 3:
articles (*noart*, libelle, stock, prixinvent)
fournisseurs (*nofour*, nomfour, adrfour, villefour)
acheter (*nofour*, *noart*, prixachat, delai)


a)Numéros et libellés des articles dont le stock est inférieur à 10 ?
    SELECT noart, libelle
    FROM articles
    WHERE stock < 10;

b)Liste des articles dont le prix d'inventaire est compris entre 100 et 300 ?
    SELECT noart
    FROM articles
    WHERE prixinvent BETWEEN 100 AND 300;

c)Liste des fournisseurs dont on ne connaît pas l'adresse ?
    SELECT adrfour
    FROM fournisseurs
    WHERE adrfour IS NULL;

d)Liste des fournisseurs dont le nom commence par "STE" ?
    SELECT nomfour 
    FROM fournisseurs
    WHERE nomfour LIKE 'STE%';

e)Noms et adresses des fournisseurs qui proposent des articles pour lesquels le délai d'approvisionnement est supérieur à 20 jours ?
    SELECT fournisseurs.nomfour, fournisseurs.adrfour, acheter.noart
    FROM fournisseurs
    JOIN acheter
    ON fournisseurs.nofour = acheter.nofour
    WHERE acheter.delai < 20;

f)Nombre d'articles référencés ?
    SELECT COUNT(noart)
    FROM articles;

g)Valeur du stock ?
    SELECT articles.stock, articles.prixinvent
    FROM articles;

h)Numéros et libellés des articles triés dans l'ordre décroissant des stocks ?
    SELECT noart, libelle
    FROM articles
    ORDER BY stock DESC;

i)Liste pour chaque article (numéro et libellé) du prix d'achat maximum, minimum et moyen ?
    SELECT articles.noart, articles.libelle
    FROM articles
    JOIN acheter
    ON articles.noart = acheter.noart;
    WHERE acheter.prixachat(
        SELECT MAX / MIN / AVG (acheter.prixachat)
        FROM acheter;)

j)Délai moyen pour chaque fournisseur proposant au moins 2 articles ?
    SELECT acheter.nofour, acheter.delai
    FROM acheter
    WHERE noart >= 2;

    # SELECT A.NOFOUR, NOMFOUR, AVG(DELAI) AS DelaiMoyen FROM ACHETER ACH, FOURNISSEURS F
    # WHERE ACH.NOFOUR = F.NOFOUR
    # GROUP BY A.NOFOUR, NOMFOUR
    # HAVING COUNT(*) >=2;


EXERCICE 4:
etudiant (*numetu*, nom, prenom, datenaiss, rue, cp, ville)
notation (*numetu*, *numepreuve*, note)
epreuve (*numepreuve*, *codemat*, datepreuve, lieu)
matiere (*codemat*, libelle, coef)

a) Liste de tous les étudiants
    SELECT *
    FROM etudiant;

b)Liste de tous les étudiants, classée par ordre alphabétique inverse
    SELECT *
    FROM etudiant
    ORDER BY nom DESC;

c)Libellé et coefficient (exprimé en pourcentage) de chaque matière
    SELECT libelle, coef * 100
    FROM matiere;

d)Nom et prénom de chaque étudiant
    SELECT nom, prenom
    FROM etudiant;

e)Nom et prénom des étudiants domiciliés à Lyon
    SELECT nom, prenom
    FROM etudiant
    WHERE ville = 'Lyon';

f)Liste des notes supérieures ou égales à 10
    SELECT *
    FROM notation
    WHERE note >= 10;

g)Liste des épreuves dont la date se situe entre le 1er janvier et le 30 juin 2014
    SELECT numepreuve
    FROM epreuve
    WHERE datepreuve BETWEEN '01-01-2014' AND '30-06-2014';

h)Nom, prénom et ville des étudiants dont la ville contient la chaîne "ll" (LL)
    SELECT prenom, nom, ville
    FROM etudiant 
    WHERE ville LIKE '%ll%';

i)Prénoms des étudiants de nom Dupont, Durand ou Martin
    SELECT prenom 
    FROM etudiant
    WHERE nom IN ('Dupont', 'Durand', 'Martin');

j)Somme des coefficients de toutes les matières
    SELECT SUM(coef)
    FROM matiere;

k)Nombre total d'épreuves
    SELECT COUNT(numepreuve)
    FROM epreuve;

l)Nombre de notes indéterminées (NULL)
    SELECT COUNT(note)
    FROM notation
    WHERE note = 'NULL';

m)Liste des épreuves (numéro, date et lieu) incluant le libellé de la matière
    SELECT epreuve.numepreuve, epreuve.datepreuve, epreuve.lieu, matiere.libelle
    FROM epreuve
    JOIN matiere
    ON epreuve.codemat = matiere.codemat;

n)Liste des notes en précisant pour chacune le nom et le prénom de l'étudiant qui l'a obtenue
    SELECT etudiant.prenom, etudiant.nom, notation.note
    FROM etudiant
    JOIN notation
    WHERE etudiant.numetu = notation.numetu;

o)Liste des notes en précisant pour chacune le nom et le prénom de l'étudiant qui l'a obtenue et le libellé de la matière concernée
    SELECT etudiant.prenom, etudiant.nom, notation.note, matiere.libelle
    FROM etudiant
    JOIN notation
    ON etudiant.numetu = notation.numetu
    JOIN epreuve
    ON notation.numepreuve = epreuve.numepreuve
    JOIN matiere
    ON epreuve.codemat = matiere.codemat;

p)Nom et prénom des étudiants qui ont obtenu au moins une note égale à 20
    SELECT DISTINCT etudiant.nom, etudiant.prenom, notation.note
    FROM etudiant
    JOIN notation
    ON etudiant.numetu = notation.numetu
    WHERE notation.note = 20;

q)Moyennes des notes de chaque étudiant (indiquer le nom et le prénom)
    SELECT etudiant.nom, etudiant.prenom, AVG(notation.note)
    FROM etudiant
    JOIN notation
    ON etudiant.numetu = notation.numetu
    GROUP BY etudiant.nom, etudiant.prenom;

r)Moyennes des notes de chaque étudiant (indiquer le nom et le prénom), classées de la meilleure à la moins bonne
    SELECT etudiant.nom, etudiant.prenom, AVG(notation.note)
    FROM etudiant
    JOIN notation
    ON etudiant.numetu = notation.numetu
    GROUP BY etudiant.nom, etudiant.prenom
    ORDER BY notation.note DESC;

s)Moyennes des notes pour les matières (indiquer le libellé) comportant plus d'une épreuve
    SELECT AVG(notation.note), matiere.libelle
    FROM note
    JOIN epreuve
    ON notation.numepreuve = epreuve.numepreuve
    JOIN matiere
    ON epreuve.codemat = matiere.codemat
    WHERE epreuve.numepreuve > 1;

t)Moyennes des notes obtenues aux épreuves (indiquer le numéro d'épreuve) où moins de 6 étudiants ont été notés
    SELECT notation.numepreuve, AVG(notation.note)
    FROM notation
    WHERE notation.numepreuve IS NOT NULL
    GROUP BY notation.numepreuve
    HAVING COUNT(*)<6;

EXERCICE 5:
usine (*NumU*, NomU, VilleU)
produit (*NumP*, NomP, Couleur, Poids) 
fournisseur (*NumF*, NomF, Statut, VilleF) 
livraison (*NumP*, *NumU*, *NumF*, Quantité)

a)Ajouter un nouveau fournisseur avec les attributs de votre choix
    INSERT INTO fournisseur 
    VALUES (101 , 'Levinson' , 'checked' , 'Strasbourg');

b)Supprimer tous les produits de couleur bleue et de numéros compris entre 100 et 1999
    DELETE FROM produit
    WHERE Couleur='noire' AND NumP >= 100 AND NumP <= 1999;

c)Changer la ville du fournisseur 3 par Mulhouse
    UPDATE fournisseur
    SET VilleF = 'Mulhouse'
    WHERE NumF = 3;
