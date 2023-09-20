# Tic Tac Toe

## Setup

### Requirements

- docker & docker-compose
- nodejs
- ember-cli

### Backend Setup (Rails)

- git clone git@github.com:shaliko/tic-tac-toe.git
- cd tic-tac-toe/game_api
- docker-compose up


API app will be started on port 3000 (http://localhost:3000/)


### Frontend Setup (EmberJS)

- Project already cloned on previous steps
- cd tictactoe
- npm install
- ember s

Frontend app will be started on port 4200 (http://localhost:4200/)

## API Documentation

### Games

1. Create a New Game

Endpoint: /api/games
Method: POST
Payload: {}
Response:

```
{
  "game": {
    "id": 1,
    "state": {},
    "current_symbol": "value",
    ...
  }
}
```

2. Retrieve a Game
Endpoint: /api/games/:id
Method: GET
Response:
```
{
  "game": {
    "id": 1,
    "state": {},
    "current_symbol": "value",
    ...
  }
}
```

### Moves within a Game

1. Create a New Move for a Game
Endpoint: /api/games/:game_id/moves
Method: POST
Payload:
```
{
  "row": "0",
  "col": "1"
  "player_token": "xxxxxxxxxxxx"
}
```

Response:
```
{
  "game": {
    "id": 1,
    "state": {},
    "current_symbol": "value",
    ...
  }
}
```