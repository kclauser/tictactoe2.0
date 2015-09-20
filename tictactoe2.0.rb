require 'sinatra'
require 'json'

# require 'sinara/reloader' if development?

class Board
  attr_accessor :positions

  def initialize
    self.positions = [" ", " ", " ",
                      " ", " ", " ",
                      " ", " ", " "]
  end

  def move(player, position)
    self.positions[position] = player
  end

  def status

  "playing"
  end
end

configure do
  set :board, Board.new
end

post '/game' do
  board = Board.new

  settings.board = Board

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

post "/move" do
  player = params["player"]
  position = params["position"].to_i

  board = settings.board

  board.move(player, position)

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

  respons.to_json
end
