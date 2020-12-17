# README

## Prerequisites

* Rails - 6.0.3.4
* Ruby - 2.7.1
* Postgresql

## Installation Steps
* Clone this repo
* `cd` into the repo
* run `bundle install` to install dependencies
* Run `rails credentials:edit`
* Add a key  - `username` and a value representing your database username
* Add a key - `password` and a value representing your database password
* Save your new credentials
* Run  `rails db:create` to create the database
* Run `rails db:migrate` to create all the  necessary tables.
* Alternatively, you can run `rails schema:load`
* Start the app by running `rails s`

## Tests
* Run `rspec spec` to run all the tests

## Endpoints
* Add bearer - `POST http://localhost:3000/bearers`. Parameters - `{ name: string }`
* Add stock - `POST http://localhost:3000/stocks`. Parameters - `{ name: string, bearer_id: integer }`
* Update stock - `PATCH http://localhost:3000/stocks/:id`. Parameters - `{ name: string }`
* Delete stock - `DELETE http://localhost:3000/stocks/:id`
* Fetch all stocks - `GET http://localhost:3000/stocks`
* Fetch paginated stocks - `GET http://localhost:3000/stocks?page=`

