Loyalty API

This API is designed to handle customer transactions, point calculations, and reward evaluations for a loyalty program.

Ruby version
Ruby 3.1.2 (or compatible)

System dependencies
SQLite3
Rails 7.x
Configuration

Set up your database.
Database creation

rails db:create
rails db:migrate
Database initialization

Run rails db:seed to populate the database with initial data if necessary.

How to run the test suite

rails test
Services

Job queues: Background tasks handled by ActiveJob
Caching: ActiveRecord caching used for efficient querying
Deployment instructions

Dockerize the app using the provided Dockerfile for easy deployment.