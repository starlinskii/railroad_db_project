CREATE SCHEMA IF NOT EXISTS Railroad;

CREATE TABLE Railroad.Station (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    town VARCHAR(255) NOT NULL
);

CREATE TABLE Railroad.Driver (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    freight BOOLEAN NOT NULL,
    grade VARCHAR(255) NOT NULL,
    work_experience INT NOT NULL,
    date_inspire DATE NOT NULL
);

CREATE TABLE Railroad.TrainModel (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    freight BOOLEAN NOT NULL,
    max_speed INT NOT NULL,
    max_power INT NOT NULL,
    total_mass INT NOT NULL,
    carriage_count INT NOT NULL,
    engine_type VARCHAR(255) NOT NULL
);

CREATE TABLE Railroad.Train (
    id SERIAL PRIMARY KEY,
    model_id INT NOT NULL,
    issue_year DATE NOT NULL,
    last_maintenance DATE NOT NULL,
    FOREIGN KEY (model_id) REFERENCES Railroad.TrainModel(id)
);

CREATE TABLE Railroad.Trip (
    id SERIAL PRIMARY KEY,
    arrival_station_id INT NOT NULL,
    departure_station_id INT NOT NULL,
    train_id INT NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrive_time TIMESTAMP NOT NULL,
    FOREIGN KEY (arrival_station_id) REFERENCES Railroad.Station(id),
    FOREIGN KEY (departure_station_id) REFERENCES Railroad.Station(id),
    FOREIGN KEY (train_id) REFERENCES Railroad.Train(id)
);

CREATE TABLE Railroad.Passenger (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    contacts VARCHAR(255) NOT NULL,
    trip_count INT NOT NULL,
    spent_money INT NOT NULL,
    pasport_number BIGINT NOT NULL
);

CREATE TABLE Railroad.Transaction (
    id SERIAL PRIMARY KEY,
    arrive_station_id INT NOT NULL,
    departure_station_id INT NOT NULL,
    trip_id INT NOT NULL,
    client_id INT NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrive_time TIMESTAMP NOT NULL,
    price INT NOT NULL,
    FOREIGN KEY (arrive_station_id) REFERENCES Railroad.Station(id),
    FOREIGN KEY (departure_station_id) REFERENCES Railroad.Station(id),
    FOREIGN KEY (trip_id) REFERENCES Railroad.Trip(id),
    FOREIGN KEY (client_id) REFERENCES Railroad.Passenger(id)
);

CREATE TABLE Railroad.Review (
    id SERIAL PRIMARY KEY,
    transaction_id INT NOT NULL,
    mark INT NOT NULL CHECK (mark >= 0 AND mark <= 5),
    content TEXT NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES Railroad.Transaction(id)
);

CREATE TABLE Railroad.trip_driver (
    trip_id INT NOT NULL,
    driver_id INT NOT NULL,
    role VARCHAR(255) NOT NULL,
    PRIMARY KEY (trip_id, driver_id),
    FOREIGN KEY (trip_id) REFERENCES Railroad.Trip(id),
    FOREIGN KEY (driver_id) REFERENCES Railroad.Driver(id)
);
