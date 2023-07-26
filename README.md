# Tickets Manager

Welcome to the Tickets Manager! This application was built with Ruby 3.2.2, Rails 7.0.6, and PostgreSQL 15. The main function of this API is to accept HTTP POST requests containing specific JSON data, persist this data into a PostgreSQL database and display the data on HTML views.

## Table of Contents

- [Deployment](#deployment)
- [Tech Stack](#tech-stack)
- [API Endpoints](#api-endpoints)
- [Additional Improvements](#additional-improvements)
- [Evaluation Criteria](#evaluation-criteria)

## Deployment

This API is deployed on [render.com](https://www.render.com/), and can be accessed here: https://rails-bhdq.onrender.com

The render.yaml configuration file can be found [here](https://github.com/Mortle/tickets-manager/blob/main/render.yaml).

## Tech Stack

- Ruby 3.2.2
- Rails 7.0.6
- PostgreSQL 15
- [Leaflet.js](https://leafletjs.com/) for mapping
- [Bootstrap 5](https://getbootstrap.com/docs/5.0/getting-started/introduction/) for styling

## API Endpoints

- `POST https://rails-bhdq.onrender.com/api/v1/tickets`: This endpoint will accept a POST request containing a JSON string and persist the provided data into the database.

## TODO list

These are possible improvements which are not covered by the task description but which are important enough to mention here.

- Introduce CORS
- Add token authentication or more complex authentication mechanisms
- Add response builders or serializers
- Improve request data validation
