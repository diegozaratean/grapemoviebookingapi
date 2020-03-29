# grapemoviebookingapi

Grapemoviebookingapi is a Rest Api build with grape , sequel and  integration test, that help you create, list and book a reservation for a movie.

## Installation

1. Download the code

2. Install Gems

```bash
bundle install
```

3. Create .env file on the main folder and insert authentication variables
```python
# ENVIRONMENT VARIABLES #
#########################
# DATABASE #
############
POSTGRESQL_PORT=5432
POSTGRESQL_TIMEOUT=5
POSTGRESQL_USERNAME=''
POSTGRESQL_PASSWORD=''
POSTGRESQL_HOST=''
POSTGRESQL_DATABASE=''
```

4. Run Sequel migration, update the fields host and database, before running the migration make sure you create the database

```bash
sequel -m db/migrate postgres://host/database
```
## Run Test
To run the test execute
```bash
rake
```
## Run server
To run the server execute
```bash
rackup config.ru
```
___
## Available Endpoints


There are tow main entities movies and booking

## Movie Enpoints


## POST /movies
`server` [/movies/]


**Parameters**

|          Name | Required |  Type   | Description                                                                                                                                                           |
| -------------:|:--------:|:-------:| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `name ` | required | string  | movie name                                                                     |
|     `description ` | optional | string  | The movie description or sumary                                                                     |
|     `imageurl ` | optional | string  | The movie description or sumary                                                                     |
|     `begindate ` | optional | string  | The Begin Date of projection of the movie in format yyyy-mm-dd                                                |
|     `enddate ` | optional | string  | The End Date of projection of the movie in format yyyy-mm-dd 
|

**Response**

```
// Create movie
{
    "movie": {
        "id": 66,
        "name": "avengers",
        "description": "a beautiful adventure of a castaway..",
        "imageurl": "https://img.co.poster_rgb.jpg",
        "begindate": "2019-09-10",
        "enddate": "2019-11-10"
    }
}
```

## GET /movies
`server` [/movies/]

There are 3 posible response for this service depending on the parameters you send

1. If you don't send any parameter the service will get all the movies on the database


2. If you send the parameter date it will get all the available movies projecting on that date

**Parameters**

|          Name | Required |  Type   | Description                                                                                                                                                           |
| -------------:|:--------:|:-------:| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `date ` | optional | string  | projecting date in format yyyy-mm-dd                                                                      |

3. If you send the parameter weekday it will get all the available movies projecting on that weekday from today to next week, for example if you send weekday 2 (Tuesday) and its Saturday it will show the movies projecting on the next Tuesday

**Parameters**

|          Name | Required |  Type   | Description                                                                                                                                                           |
| -------------:|:--------:|:-------:| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `weekday ` | optional | integer  | weekday from 1(Monday) to 7(Sunday)|

**Response**

```
// List movie
[
    {
        "movie": {
            "id": 2,
            "name": "life of pi",
            "description": "a beautiful adventure of a castaway..",
            "imageurl": "https://img.co.poster_rgb.jpg",
            "begindate": "2019-09-10",
            "enddate": "2019-11-10"
        }
    },
    {
        "movie": {
            "id": 66,
            "name": "avengers",
            "description": "a beautiful adventure of a castaway..",
            "imageurl": "https://img.co.poster_rgb.jpg",
            "begindate": "2019-09-10",
            "enddate": "2019-11-10"
        }
    }
]
```

## GET /movies/:id
`server` [/movies/:id]

This service will get a single movie

```
// Show movie
{
    "movie": {
        "id": 2,
        "name": "life of pi",
        "description": "a beautiful adventure of a castaway..",
        "imageurl": "https://img.co.poster_rgb.jpg",
        "begindate": "2019-09-10",
        "enddate": "2019-11-10"
    }
}
```

## Booking Enpoints


## POST /bookings
`server` [/bookings/]

This service validates that the movie doens't have more than 10 bookings on the same day

**Parameters**

|          Name | Required |  Type   | Description                                                                                                                                                           |
| -------------:|:--------:|:-------:| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `name ` | optional | string  | reservation holder name                                                                     |
|     `movieid ` | required | Integer  | The movie id to book               |
|     `date ` | optional | string  | The reservation date in format yyyy-mm-dd |


**Response**

```
// Create booking
if the booking was succesfull
{
    "movie": {
        "id": 66,
        "name": "avengers",
        "description": "a beautiful adventure of a castaway..",
        "imageurl": "https://img.co.poster_rgb.jpg",
        "begindate": "2019-09-10",
        "enddate": "2019-11-10"
    }
}
if the movie isn't available
{
    "error_msg": "Can't make reservation the movie you want is full on that date"
}
```

## GET /bookings
`server` [/bookings/]

There are 3 posible response for this service depending on the parameters you send

1. If you don't send any parameter the service will get all the bookings on the database


2. If you send the parameter date it will get all the available bookings projecting on that date

**Parameters**

|          Name | Required |  Type   | Description                                                                                                                                                           |
| -------------:|:--------:|:-------:| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `date ` | optional | string  | projecting date  in format yyyy-mm-dd                                                                      |

3. If you send the parameter begindate and enddate it will get all the available bookings projecting on that range of dates

**Parameters**

|          Name | Required |  Type   | Description                                                                                                                                                           |
| -------------:|:--------:|:-------:| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `begindate ` | optional | string  | The reservation Begin Date range in format yyyy-mm-dd |
|     `enddate ` | optional | string  | The reservation End Date range in format yyyy-mm-dd|

**Response**

```
// List bookings
[
    {
        "booking": {
            "id": 2,
            "name": "Diego Zarate",
            "movieid": 1,
            "date": "2019-09-10"
        }
    },
    {
        "booking": {
            "id": 3,
            "name": "Pedor Perez",
            "movieid": 1,
            "date": "2019-09-10"
        }
    }
]
```
## GET /bookings/:id
`server` [/bookings/:id]

This service will get a single booking

```
// Show booking
{
    "booking": {
        "id": 2,
        "name": "Diego Zarate",
        "movieid": 1,
        "date": "2019-09-11"
    }
}
```



