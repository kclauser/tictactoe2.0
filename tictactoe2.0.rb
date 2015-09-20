require "sinatra"
require "json"

class Board
  attr_accessor :positions

  @winning_combos = [1,2,3],
                    [4,5,6],
                    [7,8,9],
                    [1,4,7],
                    [2,5,8],
                    [3,6,9],
                    [3,5,7],
                    [1,5,9]
  @count = 0

  def initialize
    self.positions = [" ", " ", " ",
                      " ", " ", " ",
                      " ", " ", " "]
  end

  def move(player, position)
    self.positions[position] = player
  end

  def status(player)
    if @winning_combos.any?{ |win|
    win.all? { |position| self.positions[position] == player}}
    "Player Wins"
    elsif @count == 9
    "Tie Game"
    else
    "playing"
    end
  end
end

configure do
  set :board, Board.new
end

post "/game" do
  board = Board.new

  settings.board = board

  response = {
    "status" => "ok",
    "board" => {
      "status" => "playing",
      "position" => {
        "0": board.positions[0],
        "1": board.positions[1],
        "2": board.positions[2],
        "3": board.positions[3],
        "4": board.positions[4],
        "5": board.positions[5],
        "6": board.positions[6],
        "7": board.positions[7],
        "8": board.positions[8]
      }
    }
  }
  response.to_json

end

post "/move" do
  player = params["player"]
  position = params["position"].to_i

  board = settings.board

  board.move(player, position)
# NOTE if/else to test if valid or else invalid 409
  response = {
    "status" => "ok",
    "board" => {
      "state" => board.status(player,position),
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

  response.to_json
end
