
#1
select g.genre_name, count(gp.performer_id) from genre g
	join genre_performer gp on g.id = gp.genre_id
	group by g.genre_name;

#2
select count(collection_id)
from collection_track join collection 
on collection_track.collection_id = collection.id
join track 
on collection_track.track_id = track.id
where collection.year BETWEEN 2019 AND 2020;

#3
select a.album_name, avg(t.duration) from album a
	join track t on a.id = t.album_id
	group by album_name;

#4
select p.name from performer p
	join performer_album pa on p.id = pa.performer_id
	join album a on a.id = pa.album_id
	where  a.release_year < 2020;
#5
select c.collection_name from collection c
	join collection_track ct on c.id = ct.collection_id 
	join track t on t.id = ct.track_id 
	join album a on a.id = t.album_id 
	join performer_album pa on a.id = pa.album_id
	join performer p on p.id = pa.performer_id
	where p.name like '%%Frank%%';
 
#6
select a.album_name from album a 
	join performer_album pa on a.id = pa.performer_id 
	join performer p on p.id = pa.performer_id
	join genre_performer gp on gp.performer_id  = p.id 
	join genre g on g.id = gp.genre_id 
	group by p."name" , a.album_name 
  having count(gp.genre_id) > 1;
 
#7
 select t.track_name from track t 
 	left join collection_track ct on t.id = ct.track_id
	where ct.track_id is null;

#8 
select p.name from performer p 
	join performer_album pa on p.id = pa.performer_id 
	join album a on a.id = pa.album_id 
	join track t on t.album_id = a.id 
	where duration = (select min(duration) from track);

#9
select a.album_name , count(t.id) from album a 
	join track t on a.id = t.album_id 
	group by a.album_name 
	having count(t.id) in (
		select count(t.id) from album a
		join track t on a.id = t.album_id 
		group by a.album_name 
		order by count(t.id)
		limit 1);
	