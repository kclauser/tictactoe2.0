require 'sinatra'
require 'json'
​
# gem install sinatra-contrib
require 'sinatra/reloader' if development?
​
# You will have your own Board/Game class
class Board
  attr_accessor :positions
​
  def initialize
    self.positions = [" ", " ", " ",
                      " ", " ", " ",
                      " ", " ", " "]
  end
​
  def move(player, position)
    self.positions[position] = player
  end
​
  def status
    # Eventually have this compute if the board is won by X,
    # won by O, or tied
    "playing"
  end
end
​
# We need a "setting" to store the board state between requests
configure do
  set :board, Board.new
end
​
post '/game' do
  # Create a new board
  board = Board.new
​
  # Save away the board in our settings
  settings.board = board
​
  # Create a response that isn't hard coded
  response = {
    "status" => "ok",
    "board" => {
      "status" => board.status,
      "position" => {
        "0": board.positions[0],
        "1": board.positions[1],
        "2": board.positions[2],
        "3": board.positions[3],
        "4": board.positions[4],
        "5": board.positions[5],
        "6": board.positions[6],
        "7": board.positions[7],
        "8": board.positions[8],
      }
    }
  }
​
  response.to_json
end
​
post '/move' do
  player = params["player"]
  position = params["position"].to_i
​
  # Get the board back from the settings
  board = settings.board
​
  # Update the board
  board.move(player, position)
​
  # Generate a response
  response = {
    "status" => "ok",
    "board" => {
      "state" => board.status,
      "position" => {
        "0": board.positions[0],
        "1": board.positions[1],
        "2": board.positions[2],
        "3": board.positions[3],
        "4": board.positions[4],
        "5": board.positions[5],
        "6": board.positions[6],
        "7": board.positions[7],
        "8": board.positions[8],
      }
    }
  }
​
  # Don't forget that if this is an *INVALID* move we need a *different*
  # response, so there will be an *if* statement somewhere above.
​
  # Also this is verbose, maybe the long list of "0": board.postions[0] and such
  # could be replaced with the use of *map* ? ;)
​
  response.to_json
end
