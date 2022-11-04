# Tea Service Back End Repository

![ruby](https://img.shields.io/badge/Ruby-2.7.2-red)
![rails](https://img.shields.io/badge/Rails-5.2.8.1-red)
![rspec](https://img.shields.io/badge/RSpec-3.12.0-green)
![contributors](https://img.shields.io/badge/Contributors-1-yellow)

## Table of Contents
- [Tea Service Back End Repo](#tea-service-back-end-repository)
  - [Table of Contents](#table-of-contents)
  - [Background](#background)
  - [Schema](#schema)
  - [Endpoints](#endpoints)
  - [Installation](#installation)
  - [Contributors](#contributors)

## Background

The Tea Service back end repository was a Take Home project for Turing School of Software & Design. This project was completed over the course of eight hours to mock a take home assessment for job searching.

## Schema

![Schema](https://user-images.githubusercontent.com/47160926/200009875-31137988-4fa0-4792-b536-aafbe6343868.png)

## Endpoints

- Get all of a Customer's Subscriptions
```shell
GET http://localhost:3000/api/v1/customer/1/subscriptions

  "data": {
        "id": "1",
        "type": "customer_subscriptions",
        "attributes": {
            "subscriptions": [
                {
                    "id": 1,
                    "name": "Blake's first subscription",
                    "status": "cancelled",
                    "frequency": "trimonthly",
                    "customer_id": 1,
                    "created_at": "2022-11-04T15:22:32.790Z",
                    "updated_at": "2022-11-04T15:22:32.790Z"
                },
                {
                    "id": 2,
                    "name": "Blake's second subscription",
                    "status": "active",
                    "frequency": "annual",
                    "customer_id": 1,
                    "created_at": "2022-11-04T15:22:32.793Z",
                    "updated_at": "2022-11-04T15:22:32.793Z"
                }
            ]
        }
    }
```

- Create a new Subscription
```shell
input_body = {
    "customer_id": 1,
    "name": "Test Tea",
    "frequency": 1,
    "teas": [ 1 ]
}
```

```shell
POST http://localhost:3000/api/v1/customer/1/subscriptions

"data": {
        "id": "7",
        "type": "subscription",
        "attributes": {
            "name": "Test Tea",
            "status": "active",
            "frequency": "trimonthly",
            "customer": {
                "id": 1,
                "first_name": "blake",
                "last_name": "saylor",
                "email": "blakesaylor@gmail.com",
                "address": "123 Fake Street",
                "created_at": "2022-11-04T15:22:32.763Z",
                "updated_at": "2022-11-04T15:22:32.763Z"
            },
            "teas": [
                {
                    "id": 1,
                    "name": "green tea",
                    "description": "a tea that is green",
                    "temperature_c": 160,
                    "brew_time_sec": 120,
                    "price": 4.99,
                    "created_at": "2022-11-04T15:22:32.774Z",
                    "updated_at": "2022-11-04T15:22:32.774Z"
                }
            ]
        }
    }
```

- Cancel an existing Subscription
```shell
input_body = {
    "id": 7,
    "customer_id": 1,
    "change": "cancel"
}
```

```shell
PATCH http://localhost:3000/api/v1/customer/1/subscriptions/7

"data": {
        "id": "7",
        "type": "subscription",
        "attributes": {
            "name": "Test Tea",
            "status": "cancelled",
            "frequency": "trimonthly",
            "customer": {
                "id": 1,
                "first_name": "blake",
                "last_name": "saylor",
                "email": "blakesaylor@gmail.com",
                "address": "123 Fake Street",
                "created_at": "2022-11-04T15:22:32.763Z",
                "updated_at": "2022-11-04T15:22:32.763Z"
            },
            "teas": [
                {
                    "id": 1,
                    "name": "green tea",
                    "description": "a tea that is green",
                    "temperature_c": 160,
                    "brew_time_sec": 120,
                    "price": 4.99,
                    "created_at": "2022-11-04T15:22:32.774Z",
                    "updated_at": "2022-11-04T15:22:32.774Z"
                }
            ]
        }
    }
```

## Installation

1. Clone this repository: On your local machine, open a terminal session and enter the following commands for SSH or HTTPS to clone the repo.

- Using SSH key <br>
```shell
$ git clone git@github.com:blakesaylor/tea_service.git
```

- Using HTTPS <br>
```shell
$ git clone https://github.com/blakesaylor/tea_service.git
```

- Once cloned, you'll have a new local copy in the directory you ran the clone command in.

2. Change to the project directory: In terminal, use `$cd` to navigate to the project directory.
```shell
$ cd tea_service
```

3. Install required Gems utilizing Bundler: <br>
- In terminal, use Bundler to install any missing Gems. If Bundler is not installed, first run the following command.
```shell
$ gem install bundler
```

- If Bundler is already installed or after it has been installed, run the following command.
```shell
$ bundle install
```

4. Database Migration<br>
- Before using the web application you will need to setup your databases locally by running the following command
```shell
$ rails db:{drop,create,migrate,seed}
```

5. Startup and Access<br>
- Finally, in order to access JSON outputs you will have to start the server locally and query endpoints via browser or a service like Postman.

```shell
$ rails s
```

## Contributors
|  | |
| --- | --- |
| Blake Saylor | [GitHub](https://github.com/blakesaylor) &#124; [LinkedIn](https://www.linkedin.com/in/blake-saylor/) |
