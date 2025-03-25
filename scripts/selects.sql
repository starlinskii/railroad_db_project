-- Получить данные конкретного пассажира с ID 1:
SELECT * FROM Railroad.Passenger WHERE id = 1;

-- Получить первых 10 пассажиров:
SELECT * FROM Railroad.Passenger LIMIT 10;

-- Получить второй набор из 10 пассажиров:
SELECT * FROM Railroad.Passenger OFFSET 10 LIMIT 10;

-- Получить общее количество поездов для каждой модели:
SELECT model_id, COUNT(*) AS train_count
FROM Railroad.Train
GROUP BY model_id;

-- Получить детали поездок вместе с названиями соответствующих станций отправления и прибытия:
SELECT trip.id, dep_station.name AS departure_station, arr_station.name AS arrival_station
FROM Railroad.Trip AS trip
JOIN Railroad.Station AS dep_station ON trip.departure_station_id = dep_station.id
JOIN Railroad.Station AS arr_station ON trip.arrival_station_id = arr_station.id;

-- Получить среднюю оценку поездок с более чем 0 транзакциями:
SELECT trip.id AS trip_id, AVG(review.mark) AS avg_mark
FROM Railroad.Trip AS trip
JOIN Railroad.Transaction AS t ON trip.id = t.trip_id
JOIN Railroad.Review AS review ON review.transaction_id = t.id
GROUP BY trip.id;

-- Получить топ-5 пассажиров, потративших больше всего денег:
SELECT * FROM Railroad.Passenger
ORDER BY spent_money DESC
LIMIT 5;

-- Получить детали поездок вместе с соответствующими городами станций отправления и прибытия:
SELECT trip.id, dep_station.town AS departure_town, arr_station.town AS arrival_town
FROM Railroad.Trip AS trip
JOIN Railroad.Station AS dep_station ON trip.departure_station_id = dep_station.id
JOIN Railroad.Station AS arr_station ON trip.arrival_station_id = arr_station.id;

-- Получить уникальные города, в которых находятся станции:
SELECT DISTINCT town FROM Railroad.Station;

-- Получить количество уникальных моделей поездов, используемых в поездках:
SELECT COUNT(DISTINCT train.model_id) AS unique_model_count
FROM Railroad.Train AS train
JOIN Railroad.Trip AS trip ON trip.train_id = train.id;

-- Классифицировать пассажиров по потраченным деньгам:
SELECT full_name,
       CASE
           WHEN spent_money < 200 THEN 'Low spender'
           WHEN spent_money < 300 THEN 'Moderate spender'
           ELSE 'High spender'
       END AS spending_category
FROM Railroad.Passenger;

-- Обработать пустые значения в столбце contacts:
SELECT id, full_name, COALESCE(contacts, 'No contact info') AS contacts
FROM Railroad.Passenger;

-- Получить станции New York City, кроме Penn Station:
(SELECT id, name, town FROM Railroad.Station WHERE town = 'New York City')
EXCEPT
(SELECT id, name, town FROM Railroad.Station WHERE name = 'Penn Station');

-- Получить всех пассажиров вместе с соответствующими данными о транзакциях (если они есть):
SELECT passenger.id, passenger.full_name, transaction.id AS transaction_id
FROM Railroad.Passenger AS passenger
LEFT JOIN Railroad.Transaction AS transaction
    ON passenger.id = transaction.client_id;

-- Получить все модели поездов вместе с общим количеством поездов для каждой модели (даже если поездов не существует):
SELECT model.id, model.name, COUNT(train.id) AS train_count
FROM Railroad.TrainModel AS model
LEFT JOIN Railroad.Train AS train ON train.model_id = model.id
GROUP BY model.id;

-- Получить все транзакции вместе с соответствующими данными о пассажирах (даже если для транзакции нет пассажира):
SELECT t.id AS transaction_id, t.client_id, p.full_name
FROM Railroad.Transaction AS t
LEFT JOIN Railroad.Passenger AS p ON t.client_id = p.id;

-- Поиск трех пассажиров, которые потратили больше всего денег на поездки, а также подробную информацию об их поездках и соответствующих моделях поездов:
SELECT p.id AS passenger_id, p.full_name, p.spent_money,
       t.id AS trip_id, m.name AS train_model
FROM Railroad.Passenger AS p
JOIN Railroad.Transaction AS tr ON tr.client_id = p.id
JOIN Railroad.Trip AS t ON t.id = tr.trip_id
JOIN Railroad.Train AS train ON train.id = t.train_id
JOIN Railroad.TrainModel AS m ON m.id = train.model_id
ORDER BY p.spent_money DESC
LIMIT 3;

-- Поиск средней оценки за каждую поездку вместе со станциями отправления и прибытия:
SELECT t.id AS trip_id,
       dep.name AS departure_station,
       arr.name AS arrival_station,
       AVG(r.mark) AS avg_mark
FROM Railroad.Trip AS t
JOIN Railroad.Station AS dep ON t.departure_station_id = dep.id
JOIN Railroad.Station AS arr ON t.arrival_station_id = arr.id
LEFT JOIN Railroad.Transaction AS tr ON tr.trip_id = t.id
LEFT JOIN Railroad.Review AS r ON r.transaction_id = tr.id
GROUP BY t.id, dep.name, arr.name
ORDER BY avg_mark DESC;

-- Выбрать полные имена и номера паспортов пассажиров, совершивших более 5 поездок:
SELECT full_name, passport_number
FROM Railroad.Passenger
WHERE trip_count > 5;

-- Выбрать максимальную скорость всех моделей поездов:
SELECT name, max_speed FROM Railroad.TrainModel;