# README

This Ruby on Rails application retrieves forecast data for a provided address. Forecast data provided by the [National Weather Service API](https://www.weather.gov/documentation/services-web-api).

## Setup

Ensure the following are installed on your system:
- Ruby 3.2.2
- PostgreSQL 16.0

Install dependencies with `bundle install`.

Create the database with `rails db:create`.

Start the server with `rails server`.

## Tests

Run the full test suite with `rspec spec`.

Please note that external HTTP requests are stubbed.

## Schema

The application uses the following table structure:

```mermaid
erDiagram
  l[Location] {
    string inputted_address
    float latitude
    float longitude
    string postal_code
    string normalized_address
  }

  f[Forecast] {
    text detailed
    integer temperature
    string short
    string icon
    integer number
    string temperature_unit
    date generated_at
    date start_time
    date end_time
    string name
  }

  l ||--o| f : has
```