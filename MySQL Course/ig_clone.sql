CREATE DATABASE IF NOT EXISTS ig_clone;
use ig_clone;

CREATE TABLE users (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    photo_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE tags (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE photo_tags (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);

select * from users;

-- We want to reward our users who have been around the longest. Find the 5 oldest users.
select * from users order by created_at limit 5;

-- What day of the week do most users register on? 
-- we need to figure out when to schedule an ad campgain
select 
    DAYNAME(created_at) as day_name,
    count(*) as total
from users
GROUP BY day_name
HAVING total = (
  SELECT COUNT(*) AS max_registrations
    FROM users
    GROUP BY DAYNAME(created_at)
    ORDER BY max_registrations DESC
    LIMIT 1
);

-- We want to target our inactive users with an email campaign. 
-- Find the users who have never posted a photo
SELECT users.id, username FROM users
	LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- We're running a new contest to see who can get the most likes on a single photo.
select users.id as userId, username, photos.id as PhotoId, image_url, count(likes.user_id) as like_count 
from photos
	JOIN likes ON photos.id = likes.photo_id
    JOIN users ON photos.user_id = users.id
Group BY PhotoId
order by like_count DESC
LIMIT 1;

-- second way to perform
select * from users where users.id=(select user_id from photos
WHERE id = (select photo_id as count from likes
GROUP BY photo_id
order by count(photo_id) desc limit 1));

-- Our Investors want to know...
-- How many times does the average user post?
SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg; 
                          

-- A brand wants to know which hashtags to use in a post
-- What are the top 5 most commonly used hashtags?
select tag_id, tags.tag_name,count(tag_id) as total 
from photo_tags
JOIN tags ON photo_tags.tag_id = tags.id 
group by tag_id 
order by total DESC
limit 5;


-- We have a small problem with bots on our site...
-- Find users who have liked every single photo on the site
select user_id, username, count(photo_id) as like_count_of_user from likes join users on likes.user_id = users.id
group by user_id having like_count_of_user = (select count(*) from photos);


-- We also have a problem with celebrities
-- Find users who have never commented on a photo
select users.id,username from users
LEFT JOIN comments ON users.id = comments.user_id
where comments.id IS NULL;

-- count of like on every photo
select count(*) from (
select user_id, username 
from comments
	join users on comments.user_id = users.id
group by user_id
having count(photo_id) = (select count(*) from photos)) as ec;

-- user count never commented
select count(*) from (select users.id,username from users
LEFT JOIN comments ON users.id = comments.user_id
where comments.id IS NULL) as nc;

-- Are we overrun with bots and celebrity accounts?
-- Find the percentage of our users who have either never commented on a photo or have commented on every photo

select (((select count(*) from (
select user_id, username 
from comments
	join users on comments.user_id = users.id
group by user_id
having count(photo_id) = (select count(*) from photos)) as ec) + (select count(*) from (select users.id,username from users
LEFT JOIN comments ON users.id = comments.user_id
where comments.id IS NULL) as nc))/(select count(*) from users))*100 as total;

select * from users;
select * from photos;
select * from comments;




