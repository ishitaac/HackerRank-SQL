SELECT 
    c1.contest_id, 
    c1.hacker_id, 
    c1.name, 
    SUM(dt.total_submissions) AS total_submissions, 
    SUM(dt.total_accepted_submissions) AS total_accepted_submissions, 
    SUM(dt2.total_views) AS total_views, 
    SUM(dt2.total_unique_views) AS total_unique_views
FROM contests AS c1
LEFT JOIN colleges AS c2 ON c1.contest_id = c2.contest_id
LEFT JOIN challenges AS c3 ON c2.college_id = c3.college_id
LEFT JOIN (
    SELECT 
        ss.challenge_id AS challenge_id, 
        SUM(ss.total_submissions) AS total_submissions, 
        SUM(ss.total_accepted_submissions) AS total_accepted_submissions
    FROM submission_stats AS ss
    GROUP BY ss.challenge_id
) AS dt ON c3.challenge_id = dt.challenge_id
LEFT JOIN (
    SELECT 
        vs.challenge_id AS challenge_id, 
        SUM(vs.total_views) AS total_views, 
        SUM(vs.total_unique_views) AS total_unique_views
    FROM view_stats AS vs
    GROUP BY vs.challenge_id
) AS dt2 ON c3.challenge_id = dt2.challenge_id
GROUP BY c1.contest_id, c1.hacker_id, c1.name
HAVING 
     (SUM(dt.total_submissions) +
     SUM(dt.total_accepted_submissions)+
     SUM(dt2.total_views)+
     SUM(dt2.total_unique_views)) > 0
ORDER BY c1.contest_id;
