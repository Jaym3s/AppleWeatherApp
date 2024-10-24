
![image](https://github.com/user-attachments/assets/e83721ae-49bd-467a-8dd1-eb82a2a546d5)

# README

Welcome!

This is a very basic Weather App. It is missing a number of things, completely lacks style, however my focus was on API interaction, scalability, reliability (eventually at least), functionality, and testability.

A number of the files and tests are extremely simple, I look forward to explaining my rational on designing the code the way I did in future conversations. The short answer is for ease of scalability and reliability improvements.

## SETUP

### External API Key

This application uses Open Weather and requires an API key to be setup.
To do so:
 * Visit: https://openweathermap.org and create a free account.
 * After signing in, visit: https://home.openweathermap.org/api_keys and generate a key.
 * Copy `.env.example` to `.env`.
 * Add the key to `.env` to it's appropriate location.

### Caching

By default, rails doesn't cache in development. To toggle caching, run `rails dev:cache`

## LAUNCH

This is a very basic rails app, it does not use a database (yet), instead relying on Memory Caching for persistance. No db:create or migrations are required. After setup above, simply bundle and start the server!

# ATTRIBUTIONS

Thanks to https://openweathermap.org and the gems provided by the open source community which can be found in the Gemfile.
