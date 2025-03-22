-- Получить данные конкретного пассажира с ID 1:
SELECT * FROM Railroad.Passenger WHERE id = 1;

--Получить первых 10 пассажиров:
SELECT * FROM Railroad.Passenger LIMIT 10;

--Получить второй набор из 10 пассажиров:
SELECT * FROM Railroad.Passenger OFFSET 10 LIMIT 10;

-- Получить общее количество поездок для каждой модели поезда:
SELECT model_id, COUNT(*) AS trip_count
FROM Railroad.Train
GROUP BY model_id;

-- Получить детали поездок вместе с названиями соответствующих станций отправления и прибытия:
SELECT trip.id, dep_station.name AS departure_station, arr_station.name AS arrive_station
FROM Railroad.Trip trip
JOIN Railroad.Station dep_station ON trip.departure_station_id = dep_station.id
JOIN Railroad.Station arr_station ON trip.arrive_station_id = arr_station.id;

-- Получить среднюю оценку поездок с более чем 0 транзакциями:
SELECT trip_id, AVG(mark) AS avg_mark
FROM Railroad.Review
GROUP BY trip_id;

-- Получить топ-5 пассажиров, потративших больше всего денег:
SELECT *
FROM Railroad.Passenger
ORDER BY spent_money DESC
LIMIT 5;

--Получить детали поездок вместе с соответствующими городами станций отправления и прибытия:
SELECT trip.id, dep_station.town AS departure_town, arr_station.town AS arrive_town
FROM Railroad.Trip trip
JOIN Railroad.Station dep_station ON trip.departure_station_id = dep_station.id
JOIN Railroad.Station arr_station ON trip.arrive_station_id = arr_station.id;

--Получить уникальные города, в которых находятся станции:
SELECT DISTINCT town FROM Railroad.Station;

-- Получить количество уникальных моделей поездов, используемых в поездках:
SELECT COUNT(DISTINCT model_id) AS unique_models_count
FROM Railroad.Train;

-- Классифицировать пассажиров по потраченным деньгам:
SELECT full_name,
       CASE
           WHEN spent_money < 200 THEN 'Low spender'
           WHEN spent_money >= 200 AND spent_money < 300 THEN 'Moderate spender'
           ELSE 'High spender'
       END AS spending_category
FROM Railroad.Passenger;

--Обработать пустые значения в столбце contacts:
SELECT id, full_name, COALESCE(contacts, 'No contact info') AS contacts
FROM Railroad.Passenger;

--Получить станции New York City execept Penn Station
(SELECT id, name, town FROM Railroad.Station WHERE town = 'New York City')
EXCEPT
(SELECT id, name, town FROM Railroad.Station WHERE name = 'Penn Station');

-- Получить всех пассажиров вместе с соответствующими данными о поездках (если они есть):
SELECT passenger.id, passenger.full_name, transaction.id AS transaction_id
FROM Railroad.Passenger passenger
FULL OUTER JOIN Railroad.Transaction transaction ON passenger.id = transaction.client_id;

-- Получить все модели поездов вместе с общим количеством поездок для каждой модели (даже если поездок не существует):
SELECT model.id, model.name, COUNT(train.id) AS trip_count
FROM Railroad.TrainModel model
LEFT JOIN Railroad.Train train ON model.id = train.model_id
GROUP BY model.id;

-- Получить все транзакции вместе с соответствующими данными о пассажирах (даже если для транзакции нет пассажира):
SELECT transaction.id AS transaction_id, transaction.client_id, passenger.full_name
FROM Railroad.Transaction transaction
RIGHT JOIN Railroad.Passenger passenger ON transaction.client_id = passenger.id;

-- Поиск трех пассажиров, которые потратили больше всего денег на поездки, а также подробную информацию об их поездках и соответствующих моделях поездов:
SELECT Passenger.id AS passenger_id, Passenger.full_name, Passenger.spent_money, Trip.id AS trip_id, TrainModel.name AS train_model
FROM Railroad.Passenger
JOIN Railroad.Transaction ON Passenger.id = Transaction.client_id
JOIN Railroad.Trip ON Transaction.trip_id = Trip.id
JOIN Railroad.Train ON Trip.train_id = Train.id
JOIN Railroad.TrainModel ON Train.model_id = TrainModel.id
ORDER BY Passenger.spent_money DESC
LIMIT 3;

-- Поиск средней оценки за каждую поездку вместе со станциями отправления и прибытия:
SELECT Trip.id AS trip_id, DepartureStation.name AS departure_station, ArriveStation.name AS arrival_station,
       AVG(Review.mark) AS avg_mark
FROM Railroad.Trip
JOIN Railroad.Station AS DepartureStation ON Trip.departure_station_id = DepartureStation.id
JOIN Railroad.Station AS ArriveStation ON Trip.arrive_station_id = ArriveStation.id
LEFT JOIN Railroad.Review ON Trip.id = Review.trip_id
GROUP BY Trip.id, DepartureStation.name, ArriveStation.name
ORDER BY avg_mark DESC;

-- Выбрать полные имена и номера паспортов пассажиров, совершивших более 5 поездок:
SELECT full_name, passport_number
FROM Railroad.Passenger
WHERE trip_count > 5;

-- Выбрать максимальную скорость всех моделей поездов из таблицы TrainModel:
SELECT name, max_speed FROM Railroad.TrainModel;