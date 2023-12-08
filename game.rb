# TODO Create Game Class
# Game class is responsible for logic:
# - Checking for win and tie
# - Switching between players
# - Resetting the game
# - Validating user input
# - Making calls to update the game board
# TODO Create Gameboard class

class Gameboard
  def initialize
    current_number = 0
    @grid = Array.new(3) { Array.new(3) { current_number += 1 } }
  end

  def display
    # Display the board
    @grid.each_with_index do |row, index|
      puts row.map { |num| num.to_s.rjust(2) }.join(' | ')
      puts '----' * 3 unless index == @grid.size - 1
    end
  end

  def place_symbol(row, col, symbol)
    # Place 'X' or 'O' on the board
    @grid[row][col] = symbol
  end

  def check_winner
    # Check for a winning condition
    # Check horizontal and vertical lines
    3.times do |i|
      return @grid[i][0] if @grid[i][0] == @grid[i][1] && @grid[i][1] == @grid[i][2] && @grid[i][0] != ' '
      return @grid[0][i] if @grid[0][i] == @grid[1][i] && @grid[1][i] == @grid[2][i] && @grid[0][i] != ' '
    end

    # Check diagonal lines
    return @grid[0][0] if @grid[0][0] == @grid[1][1] && @grid[1][1] == @grid[2][2] && @grid[0][0] != ' '
    return @grid[0][2] if @grid[0][2] == @grid[1][1] && @grid[1][1] == @grid[2][0] && @grid[0][2] != ' '

    # Check for draw
    return 'Draw' if @grid.all? { |row| row.none?(' ') }

    # No winner or draw
    nil
  end
end

class Game
  def initialize
    @board = Gameboard.new
    # Initialize players or other game settings
  end

  def play
    # Main game loop
    # - Prompt players for moves
    # - Update board
    # - Check for game end conditions
  end

  private

  def player_turn(player)
    # Handle a player's turn
  end

  def game_over?
    # Check if the game is ov    #
  end
end

game = Gameboard.new
game.display
puts "\n"
game.place_symbol(0, 0, "X")
game.place_symbol(0, 1, "X")
game.place_symbol(0, 2, "X")
# game.place_symbol(1, 1, "O")
game.display
p game.check_winner
