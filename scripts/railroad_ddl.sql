CREATE SCHEMA Railroad;

CREATE TABLE Railroad.Passenger
(
   id INTEGER PRIMARY KEY,
   full_name VARCHAR(255) NOT NULL,
   passport_number BIGINT NOT NULL,
   contacts VARCHAR(255) NOT NULL,
   trip_count INTEGER NOT NULL,
   spent_money INTEGER NOT NULL
);

CREATE TABLE Railroad.TrainModel
(
   id INTEGER PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   freight BOOLEAN NOT NULL,
   max_speed INTEGER NOT NULL,
   max_power INTEGER NOT NULL,
   total_mass INTEGER NOT NULL,
   engine_type VARCHAR(255) NOT NULL
);

CREATE TABLE Railroad.Train
(
   id INTEGER PRIMARY KEY,
   model_id INTEGER,
   issue_year DATE NOT NULL,
   last_maintenance DATE NOT NULL,
   carriage_count INTEGER NOT NULL,

   FOREIGN KEY(model_id) REFERENCES Railroad.TrainModel (id)
);

CREATE TABLE Railroad.Driver
(
   id INTEGER PRIMARY KEY,
   full_name VARCHAR(255) NOT NULL,
   freight BOOLEAN NOT NULL,
   grade VARCHAR(255) NOT NULL,
   work_experience INTEGER NOT NULL,
   date_inspire DATE NOT NULL
);


CREATE TABLE Railroad.Station
(
   id INTEGER PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   town VARCHAR(255) NOT NULL
);

CREATE TABLE Railroad.Trip
(
   id INTEGER PRIMARY KEY,
   train_id INTEGER,
   first_driver_id INTEGER,
   second_driver_id INTEGER,
   departure_time TIMESTAMP NOT NULL,
   departure_station_id INTEGER,
   arrive_time TIMESTAMP NOT NULL,
   arrive_station_id INTEGER,

   FOREIGN KEY(train_id) REFERENCES Railroad.Train (id),
   FOREIGN KEY(first_driver_id) REFERENCES Railroad.Driver (id),
   FOREIGN KEY(second_driver_id) REFERENCES Railroad.Driver (id),
   FOREIGN KEY(departure_station_id) REFERENCES Railroad.Station (id),
   FOREIGN KEY(arrive_station_id) REFERENCES Railroad.Station (id)
);

CREATE TABLE Railroad.Transaction
(
   id INTEGER PRIMARY KEY,
   client_id INTEGER,
   trip_id INTEGER,
   departure_time TIMESTAMP NOT NULL,
   departure_station_id INTEGER,
   arrive_time TIMESTAMP NOT NULL,
   arrive_station_id INTEGER,
   price INTEGER NOT NULL,

   FOREIGN KEY(client_id) REFERENCES Railroad.Passenger (id),
   FOREIGN KEY(trip_id) REFERENCES Railroad.Trip (id),
   FOREIGN KEY(departure_station_id) REFERENCES Railroad.Station (  id),
   FOREIGN KEY(arrive_station_id) REFERENCES Railroad.Station (id)
);

CREATE TABLE Railroad.Review
(
   id INTEGER PRIMARY KEY,
   trip_id INTEGER,
   client_id INTEGER,
   mark INTEGER NOT NULL CHECK (mark >= 0 AND mark <= 5),
   content TEXT NOT NULL,

   FOREIGN KEY(client_id) REFERENCES Railroad.Passenger (id),
   FOREIGN KEY(trip_id) REFERENCES Railroad.Trip (id)
);