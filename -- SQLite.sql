-- SQLite
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

.import restaurants.csv restaurants