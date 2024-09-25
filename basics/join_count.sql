-- You need to use LEFT JOIN and COUNT 
-- to find all the artists, their IDs, 
-- and the number of their songs in the database.
select a.id, a.artist_name, count(s.id)
from artist a
    left join song s
    on  s.artist_id = a.id
group by a.id, a.artist_name


-- count(*) does not show songs to artists although 
-- some artists have no songs
select a.id, a.artist_name, count(*)
from artist a
    left join song s
    on  s.artist_id = a.id
group by a.id, a.artist_name