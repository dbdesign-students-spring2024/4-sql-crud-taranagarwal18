# SQL CRUD

# Part 1: Restaurant Finder

## Table Structure

### SQL Commands to Create Tables

#### Creating Restaurants & Reviews Table:
```sql
CREATE TABLE restaurants (
    RestaurantID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Address TEXT NOT NULL,
    Category TEXT,
    PriceTier TEXT CHECK(PriceTier IN ('cheap', 'medium', 'expensive')),
    Neighborhood TEXT,
    OpeningHours TEXT,
    AverageRating FLOAT CHECK(AverageRating BETWEEN 0 AND 5),
    GoodForKids BOOLEAN
);

CREATE TABLE reviews (
    ReviewID INTEGER PRIMARY KEY AUTOINCREMENT,
    RestaurantID INTEGER,
    UserID INTEGER,
    Rating INTEGER CHECK(Rating BETWEEN 1 AND 5),
    Comment TEXT,
    Date DATE,
    FOREIGN KEY (RestaurantID) REFERENCES restaurants(RestaurantID)
);
```

## Importing Practice Restaurant Data

To import the restaurant data from a CSV file into the SQLite database, use the following commands:
```sql
.mode csv
.import /Users/taranagarwal/Desktop/database & design/4-sql-crud-taranagarwal18/data/restaurants.csv restaurants
```
## Queries

Write a single SQL query to perform each of the following tasks:

1. Find all cheap restaurants in a particular neighborhood (pick any neighborhood as an example).
```sql
SELECT * FROM Restaurants
WHERE PriceTier = 'cheap' AND Neighborhood = 'Bronx';
```
2. Find all restaurants in a particular genre (pick any genre as an example) with 3 stars or more, ordered by the number of stars in descending order.
```sql
SELECT * FROM Restaurants
WHERE Category = 'Indian' AND AverageRating >= 3
ORDER BY AverageRating DESC;
```
3. Find all restaurants that are open now.
```sql
SELECT * FROM Restaurants
WHERE OpeningHours <= strftime('%H:%M', 'now', 'localtime');
```
4. Leave a review for a restaurant
```sql
INSERT INTO Reviews (RestaurantID, Rating, Comment)
VALUES (10, 4, 'Great atmosphere and delicious food!');
```
5. Delete all restaurants that are not good for kids
```sql
DELETE FROM Restaurants
WHERE GoodForKids = 'FALSE';
```
6. Find the number of restaurants in each NYC neighborhood
```sql
SELECT Neighborhood, COUNT(*) AS NumberOfRestaurants
FROM Restaurants
GROUP BY Neighborhood;
```

# Part 2: Social Media App
## Table Structure

### SQL Commands to Create Tables

#### Creating Users, Messages and Stories Tables:

```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  handle VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE posts (
  post_id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_type TEXT CHECK(post_type IN ('message', 'story')) NOT NULL,
  sender TEXT NOT NULL, 
  receiver TEXT,       
  post_text TEXT NOT NULL,
  date_time_posted DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  visibility TEXT CHECK(visibility IN ('Visible', 'Not visible')) NOT NULL
);
```

## Importing posts and users Data
```sql
-- Import users
.mode csv
.import data/users.csv users

-- Import posts (which include messages and stories)
.mode csv
.import data/posts.csv posts
```

# SQL Queries for Social Media App

Perform various operations with the following SQL queries:

1. **Register a new User**
   ```sql
   INSERT INTO Users (email, password, handle) VALUES ('newuser@example.com', 'hashed_password', 'newuserhandle');
   ```
2. Create a new Message sent by a User to another User
   ```sql
  INSERT INTO Messages (sender_id, receiver_id, text_content) VALUES (1, 2, 'Hello, how are you?');
   ```
3. Create a new Story by a User
 ```sql
  INSERT INTO Stories (user_id, text_content) VALUES (1, 'This is my story content.');
   ```
4. Show the 10 most recent visible Messages and Stories
 ```sql
  (SELECT user_id, text_content, timestamp FROM Messages WHERE viewed = TRUE ORDER BY timestamp DESC LIMIT 10)
UNION ALL
(SELECT user_id, text_content, timestamp FROM Stories WHERE expired = FALSE ORDER BY timestamp DESC LIMIT 10);
   ```
5. Show the 10 most recent visible Messages sent by a User
```sql
SELECT * FROM Messages WHERE sender_id = 1 AND viewed = TRUE ORDER BY timestamp DESC LIMIT 10;
```


