create database TiarasCrownsCloset;
CREATE TABLE Owners (
    owner_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    title VARCHAR(50),
    public_appearances INT
);

CREATE TABLE Items (
    item_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(20) CHECK (type IN ('crown','tiara')),
    year_made INT,
    country_of_origin VARCHAR(50),
    estimated_value NUMERIC(12,2),
    owner_id INT REFERENCES Owners(owner_id) ON DELETE SET NULL
);

CREATE TABLE ItemDetails (
    item_id INT PRIMARY KEY,
    weight_grams NUMERIC(8,2),
    material VARCHAR(50),
    designer VARCHAR(100),
    times_worn_publicly INT,
    FOREIGN KEY (item_id) REFERENCES Items(item_id) ON DELETE CASCADE
);

CREATE TABLE Gemstones (
    gemstone_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    hardness NUMERIC(3,1),
    color VARCHAR(50)
);

CREATE TABLE ItemGemstones (
    item_id INT REFERENCES Items(item_id) ON DELETE CASCADE,
    gemstone_id INT REFERENCES Gemstones(gemstone_id) ON DELETE CASCADE,
    quantity INT DEFAULT 1,
    PRIMARY KEY (item_id, gemstone_id)
);

INSERT INTO Owners (full_name, title, public_appearances) VALUES
('Queen Elizabeth II', 'Queen', 520),
('Princess Diana', 'Princess', 310),
('Queen Mary', 'Queen', 400),
('Princess Catherine', 'Princess', 290),
('Amelia Laurent', 'Collector', 85),
('Hugo van der Meer', 'Collector', 120),
('Queen Victoria', 'Queen', 560),
('Princess Sofia', 'Princess', 210),
('Lord Archibald Rowe', 'Collector', 45),
('Eleanor Whitford', 'Collector', 130);

INSERT INTO Items (name, type, year_made, country_of_origin, estimated_value, owner_id) VALUES
('Imperial State Crown', 'crown', 1937, 'United Kingdom', 3500000, 1),
('Cambridge Lover’s Knot Tiara', 'tiara', 1914, 'United Kingdom', 2500000, 2),
('Vladimir Tiara', 'tiara', 1874, 'Russia', 2800000, 3),
('Golden Rose Crown', 'crown', 1890, 'France', 1800000, 5),
('Sapphire Winter Tiara', 'tiara', 1955, 'Sweden', 1100000, 8),
('Ruby Blossom Crown', 'crown', 1920, 'Spain', 2200000, 4),
('Pearl Dewdrop Tiara', 'tiara', 2001, 'Italy', 600000, 10),
('Crystal Aurora Crown', 'crown', 1988, 'Norway', 950000, 6),
('Emerald Forest Tiara', 'tiara', 1970, 'Germany', 800000, 5),
('Sunburst Royal Crown', 'crown', 1850, 'England', 5000000, 7),
('Opaline Snow Tiara', 'tiara', 1999, 'Finland', 450000, 9),
('Midnight Sapphire Crown', 'crown', 2005, 'Belgium', 1200000, 6);

INSERT INTO ItemDetails (item_id, weight_grams, material, designer, times_worn_publicly) VALUES
(1, 1500, 'Gold', 'Garrard & Co', 89),
(2, 850, 'Platinum', 'Queen Mary', 45),
(3, 920, 'Gold', 'Russian Imperial Jewellers', 67),
(4, 780, 'Gold', 'Pierre Laurent', 12),
(5, 640, 'Silver', 'Nordic Jewelworks', 25),
(6, 1100, 'Gold', 'Casa Roja', 38),
(7, 450, 'Silver', 'Giovanni Aureli', 9),
(8, 1300, 'Platinum', 'Aksel Jewelry', 14),
(9, 520, 'Gold', 'Johann Schneider', 7),
(10, 1750, 'Gold', 'House of Windsor', 120),
(11, 480, 'Silver', 'Elina Korpi', 10),
(12, 1400, 'Platinum', 'Brussels Royal Atelier', 18);

INSERT INTO Gemstones (name, hardness, color) VALUES
('Diamond', 10, 'Clear'),
('Ruby', 9, 'Red'),
('Emerald', 7.5, 'Green'),
('Sapphire', 9, 'Blue'),
('Pearl', 3, 'White'),
('Amethyst', 7, 'Purple'),
('Aquamarine', 7.5, 'Light Blue'),
('Opal', 5.5, 'Iridescent'),
('Pink Diamond', 10, 'Pink'),
('Black Diamond', 10, 'Black'),
('Garnet', 7, 'Red'),
('Citrine', 7, 'Yellow'),
('Topaz', 8, 'Blue'),
('Morganite', 7.5, 'Peach'),
('Onyx', 6.5, 'Black');

INSERT INTO ItemGemstones (item_id, gemstone_id, quantity) VALUES
(1, 1, 120),  -- diamonds
(1, 5, 20),   -- pearls
(1, 2, 10),   -- rubies

(2, 1, 80),
(2, 5, 30),

(3, 3, 25),
(3, 1, 40),

(4, 2, 15),
(4, 12, 18),

(5, 4, 22),
(5, 7, 10),

(6, 2, 40),
(6, 11, 25),

(7, 5, 50),
(7, 8, 12),

(8, 10, 5),
(8, 1, 30),

(9, 3, 18),
(9, 6, 10),

(10, 1, 250),
(10, 9, 14),

(11, 8, 20),
(11, 14, 6),

(12, 4, 35),
(12, 13, 12);

--Cerinte:
-- 1. Sa se afiseze toate tiarele si anul in care au fost create.
SELECT name, year_made FROM Items WHERE type = 'tiara';

-- 2. Sa se afiseze toate tiarele si coroanele create dupa anul 1950.
SELECT name, year_made FROM Items WHERE year_made > 1950;

-- 3. Sa se afiseze propietarii si titlul fiecaruia.
SELECT full_name, title FROM Owners;

-- 4. Sa se afiseze toate pietrele pretioase de culoare rosie.
SELECT name, color FROM Gemstones WHERE color = 'Red';

-- 5. Sa se afiseze toate tiarele si coroanele impreuna cu propietarul lor.
SELECT i.name AS item_name, o.full_name AS owner FROM Items i JOIN Owners o ON i.owner_id = o.owner_id;

-- 6. Sa se afiseze toate tiarele si coroanele si numarul aparitiilor publice ale propietarilor.
SELECT i.name, o.public_appearances FROM Items i JOIN Owners o ON i.owner_id = o.owner_id;

-- 7. Sa se afiseze greutatea si materialul din care este facuta fiecare tiara si coroana.
SELECT i.name, d.weight_grams, d.material FROM Items i JOIN ItemDetails d ON i.item_id = d.item_id;

-- 8. Sa se calculeze si afiseze numarul total de tiare si coroane.
SELECT COUNT(*) AS total_items FROM Items;

-- 9. Sa se calculeze si afiseze valoarea medie estimată a bijuteriilor (tiare si coroane).
SELECT AVG(estimated_value) AS average_value FROM Items;

-- 10. Sa se afiseze toate bijuteriile create dupa anul 1950.
SELECT name, year_made FROM Items WHERE year_made > 1950;

-- 11. Sa se afiseze numarul de bijuterii pentru fiecare propietar.
SELECT o.full_name, COUNT(i.item_id) AS item_count FROM Owners o LEFT JOIN Items i ON o.owner_id = i.owner_id
GROUP BY o.full_name;

-- 12. Sa se afiseze bijuteriile care contin diamante.
SELECT DISTINCT i.name FROM Items i JOIN ItemGemstones ig ON i.item_id = ig.item_id
JOIN Gemstones g ON ig.gemstone_id = g.gemstone_id WHERE g.name = 'Diamond';

-- 13. Sa se afiseze toate bijuteriile cu mai mult de 50 de pietre pretioase.
SELECT i.name, SUM(ig.quantity) AS total_gemstones FROM Items i JOIN ItemGemstones ig ON i.item_id = ig.item_id
GROUP BY i.name HAVING SUM(ig.quantity) > 50;

-- 14. Sa se creasca cu 50% valoarea pentru bijuteriile din Marea Britanie (United Kingdom).
UPDATE Items SET estimated_value = estimated_value * 1.50 WHERE country_of_origin = 'United Kingdom';

-- 15. Sa se stearga bijuteria care afost purtata de 10 ori.
DELETE FROM Items i USING ItemDetails d WHERE i.item_id = d.item_id AND d.times_worn_publicly = 10;

