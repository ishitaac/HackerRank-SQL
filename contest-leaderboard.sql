select hacker_id, name, sum(score) from ( select 
    h.HACKER_ID AS HACKER_ID,
    h.NAME AS NAME,
    MAX(s.SCORE) AS SCORE
    from hackers as h join submissions as s on h.hacker_id = s.hacker_id
    group by h.hacker_id, h.name, s.challenge_id
) AS derived_table
group by hacker_id, name 
having sum(score)>0
order by sum(score) desc, hacker_id asc;

-- EXPLAINATION OF THE QUERY
-- 1. Inner Query:
-- Calculates the maximum score (MAX(s.score)) for each hacker_id and challenge_id pair.
-- Groups by hacker_id, name, and challenge_id to ensure unique combinations.

-- 2. Outer Query:
-- Sums up the maximum scores for each hacker across all challenges.
-- Filters hackers with a total score greater than 0 using HAVING SUM(score) > 0.

-- 3. Ordering:
-- Orders results by descending total score.
-- For ties in total score, orders by ascending hacker_id.

-- OUTPUT
-- Your Output (stdout)
-- 76971 Ashley 760 
-- 84200 Susan 710 
-- 76615 Ryan 700 
-- 82382 Sara 640 
-- 79034 Marilyn 580 
-- 78552 Harry 570 
-- 74064 Helen 540 
-- 78688 Sean 540 
-- 83832 Jason 540 
-- 72796 Jose 510 
-- 76216 Carlos 510 
-- 90304 Lillian 500 
-- 88507 Patrick 490 
-- 72505 Keith 480 
-- 88018 Dennis 480 
-- 78918 Julia 470 
-- 85319 Shawn 470 
-- 71357 Bobby 460 
-- 72047 Elizabeth 460 
-- 74147 Jason 460 
-- 80587 Ruth 460 
-- 89286 Jennifer 460 
-- 75626 Gerald 450 
-- 85788 Julia 440 
-- 90588 Charles 440 
-- 87978 Melissa 410 
