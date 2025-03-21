# Физическая модель

---

Таблица `Train`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `id`         | Идентификатор      | `INTEGER`      | `PRIMARY KEY` |
| `model_id`       | Идентификатор модели    | `INTEGER` | `FOREIGN KEY`    |
| `issue_year`     | Год выпуска        | `DATE` | `NOT NULL`    |
| `last_maintenance`       | Последнее техобслуживание      | `DATE` | `NOT NULL`    |
| `carriage_count`       | Количество вагонов    | `INTEGER`      | `NOT NULL`    |


---
Таблица `Driver`:

| Название             | Описание                                         | Тип данных     | Ограничение   |
|----------------------|--------------------------------------------------|----------------|---------------|
| `id`              | Идентификатор                                    | `INTEGER`      | `PRIMARY KEY` |
| `full_name`               | ФИО                                              | `VARCHAR(255)` | `NOT NULL`    |
| `freight`         | Водит ли грузовой  поезд             | `BOOLEAN`      | `NOT NULL`    |
| `grade`          | Должность/ранг               | `VARCHAR(255)`      | `NOT NULL`    |
| `work_experience`      | Стаж работы           | `INTEGER`      | `NOT NULL`    |
| `date_inspire` | Дата истечения | `DATE`      | `NOT NULL`    |

---
Таблица `Station`:
| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `id`    | Идентификатор             | `INTEGER`   | `PRIMARY KEY` |
| `name`     | Название станции      | `VARCHAR(255)`   | `NOT NULL` |
| `town`     | Город           | `VARCHAR(255)`   | `NOT NULL` |

---
Таблица `TrainModel`:

| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `id`    | Идентификатор             | `INTEGER`   | `PRIMARY KEY` |
| `name`     | Название модели           | `VARCHAR(255)`   | `NOT NULL` |
| `freight`     | Грузовой/Пассажирский             | `BOOLEAN`   | `NOT NULL` |
| `max_speed` | Максимальная скорость                   | `INTEGER` | `NOT NULL`    |
| `max_power`     | Максимальная мощность | `INTEGER`   | `NOT NULL`    |
| `total_mass`     | Вес поезда | `INTEGER`   | `NOT NULL`    |
| `engine_type`     | Тип двигателя | `VARCHAR(255)`   | `NOT NULL`    |


---
Таблица `Review`:

| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `id`    | Идентификатор             | `INTEGER`   | `PRIMARY KEY` |
| `client_id`     | Идентификатор клиента           | `INTEGER`   | `FOREIGN KEY` |
| `trip_id`     | Идентификатор рейса             | `INTEGER`   | `FOREIGN KEY` |
| `mark` | Оценка                    | `INTEGER` | `NOT NULL`    |
| `content`     | Текст отзыва | `TEXT`   | `NOT NULL` | 

---
Таблица `Trip`:
| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `id`    | Идентификатор             | `INTEGER`   | `PRIMARY KEY` |
| `train_id`     | Идентификатор поезда           | `INTEGER`   | `FOREIGN KEY` |
| `arrive_station_id`     | Идентификатор станции прибытия             | `INTEGER`   | `FOREIGN KEY` |
| `departure_station_id` | Идентификатор станции отправления  | `INTEGER` | `FOREIGN KEY`    |
| `first_driver_id`     | Идентификатор главного машиниста | `INTEGER`   | `FOREIGN KEY`    |
| `second_driver_id`     | Идентификатор помощника машиниста | `INTEGER`   | `FOREIGN KEY`    |
| `departure_time`     | Время отправления | `TIMESTAMP`   | `NOT NULL`    |
| `arrive_time`     | Время прибытия | `TIMESTAMP`   | `NOT NULL`    |

---
Таблица `Transaction`:
| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `id`    | Идентификатор             | `INTEGER`   | `PRIMARY KEY` |
| `client_id`     | Идентификатор клиента           | `INTEGER`   | `FOREIGN KEY` |
| `trip_id`     | Идентификатор рейса             | `INTEGER`   | `FOREIGN KEY` |
| `arrive_station_id`     | Идентификатор станции прибытия             | `INTEGER`   | `FOREIGN KEY` |
| `departure_station_id` | Идентификатор станции отправления  | `INTEGER` | `FOREIGN KEY`    |
| `departure_time`     | Время посадки пассажира | `TIMESTAMP`   | `NOT NULL`    |
| `arrive_time`     | Время прибытия пасажира | `TIMESTAMP`   | `NOT NULL`    |
| `price`     | стоимость рейса | `INTEGER`   | `NOT NULL`    |

---
Таблица `Passenger`:

| Название    | Описание                        | Тип данных  | Ограничение   |
|-------------|---------------------------------|-------------|---------------|
| `id`    | Идентификатор             | `INTEGER`   | `PRIMARY KEY` |
| `full_name`     | ФИО         | `VARCHAR(255)`   | `FOREIGN KEY` |
| `contacts`     |   Контакты пассажира   | `VARCHAR(255)`   | `FOREIGN KEY` |
| `trip_count` | Количество поездок  | `INTEGER` | `NOT NULL`    |
| `spent_money`     | Количество потраченных денег  | `INTEGER`   | `NOT NULL`    |
| `passport_number`     | Номер паспорта | `BIGINT`   | `NOT NULL`    |

