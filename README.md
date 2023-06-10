# Tic Tac Toe REST API Endpoint

This repo consists of an API endpoint that allows end-users to play a game of tic-tac-toe:
Provided functionality includes:

* API Users can create game board.
* API Users can post turns within the created game board.
* The API returns the prev turn and the next turn identifier.
* The API returns data in the JSON format.

### **Installing**

A step by step series of examples that tell you how to get a development env running

Clone the repo and change directory to it

    $ git clone git@github.com:mujtaba-saboor/tic-tac-toe-api.git && cd $_

Install the dependencies

    $ bundle install

Setup the database

    $ rails db:setup

Run the server on port 3000

    $ rails s -p 3000

## Running Tests

    $ bundle exec rspec -fd
