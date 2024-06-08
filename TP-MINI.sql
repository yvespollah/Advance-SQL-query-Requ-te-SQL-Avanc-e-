use etudiant;

select nom,prenom
from enseignant except
(select nom,prenom
from cours as c
join dispense as d on c.nomCours = d.nomCours
join salle as s on s.nomSalle = d.nomSalle
join enseignant as e on e.idEnseignant = c.idEnseignant);

select e.nomFil , count(matricule) as c
from etudiant as e
join filiere as f on e.nomFil = f.nomFil
group by e.nomFil
having  c =3;

select nomCours, avg(heureFin-heureDebut)
from dispense
group by nomCours;


select nom,prenom 
from cours as c
join dispense as d on c.nomCours = d.nomCours
join salle as s on s.nomSalle = d.nomSalle
join enseignant as e on e.idEnseignant = c.idEnseignant
group by nom
having count(c.nomCours) = (select max(m)
								from(
								select count(c.nomCours) as m
								from cours as c
								join dispense as d on c.nomCours = d.nomCours
								join salle as s on s.nomSalle = d.nomSalle
								join enseignant as e on e.idEnseignant = c.idEnseignant
								group by nom) as t1);

select nom, (25- age) as anne_rest
from(select nom,(2024 - anNaiss) as age
		from etudiant) as t1;
        
        

select nomFil
from etudiant as e
join suivie as s on e.matricule = s.matricule
group by e.matricule
having sum(note) = (select max(s)
from(
select sum(note) as s
from etudiant as e
join suivie as s on e.matricule = s.matricule
group by e.matricule) as t1);

select nom,prenom
from etudiant as e , suivie as s
where e.matricule = s.matricule
group by e.matricule
having  count(nomCours)  = (select count(*)
from cours);

select nomCours
from dispense
where heureDebut = ( select min(heureDebut)
						from dispense);



select nomFil
from( 
select *
from etudiant
where sexe = 'F') as t1
group by nomFil
having count(matricule) = (
select max(m)
from(
select count(matricule) as m
from( 
select *
from etudiant
where sexe = 'F') as t1
group by nomFil) as t1
);

select nomCours, avg(note) as moy_gen
from suivie 
group by nomCours;

select *
from etudiant as e
join suivie as s on s.matricule = e.matricule
where nomCours = 
(select nomCours
from suivie 
group by nomCours
having avg(note) = (select max(moy_gen)
					from(
					select avg(note) as moy_gen
					from suivie 
					group by nomCours) as t1))
and s.note > (select max(moy_gen)
					from(
					select avg(note) as moy_gen
					from suivie 
					group by nomCours) as t1);


select nom,prenom
from(select nom,prenom,anNaiss
from etudiant as e
join suivie as s on s.matricule = e.matricule
where nomCours = 
(select nomCours
from suivie 
group by nomCours
having avg(note) = (select max(moy_gen)
					from(
					select avg(note) as moy_gen
					from suivie 
					group by nomCours) as t1))
and s.note > (select max(moy_gen)
					from(
					select avg(note) as moy_gen
					from suivie 
					group by nomCours) as t1)) as t2
where anNaiss = (select max(anNaiss)
					from (select anNaiss
							from etudiant as e
							join suivie as s on s.matricule = e.matricule
							where nomCours = 
							(select nomCours
							from suivie 
							group by nomCours
							having avg(note) = (select max(moy_gen)
												from(
												select avg(note) as moy_gen
												from suivie 
												group by nomCours) as t1))
							and s.note > (select max(moy_gen)
												from(
												select avg(note) as moy_gen
												from suivie 
												group by nomCours) as t1)) as t3 )   ;               
                    












