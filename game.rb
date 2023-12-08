class Gameboard
  def initialize
    # current_number = 0
    # @grid = Array.new(3) { Array.new(3) { current_number += 1 } }
    @grid = Array.new(3) { Array.new(3, ' ') }
  end

  def display
    # Display the board
    # @grid.each_with_index do |row, index|
    #  puts row.map { |num| num.to_s.rjust(2) }.join(' | ')
    #  puts '----' * 3 unless index == @grid.size - 1
    # end
    puts "\n"
    @grid.each_with_index do |row, index|
      puts row.join(' | ')
      puts '---------' unless index == @grid.size - 1
    end
  end

  def place_symbol(row, col, symbol)
    # Place 'X' or 'O' on the board
    if cell_empty?(row, col)
      @grid[row][col] = symbol
    else
      print "Cell taken! Please choose another cell!"
    end
  end

  def cell_empty?(row, col)
    if (@grid[row][col] = "")
      true
    else
      false
    end
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
  # Initialize players or other game settings
  def initialize
    @board = Gameboard.new
    @current_player = "X"
    @game_over = false
  end

  def play
    until @game_over
      @board.display
      player_turn(@current_player)
      @game_over = game_over?
      switch_player unless @game_over
      if (@game_over)
        conclude_game
      end
    end
  end

  private

  def player_turn(player)
    valid_move = false
    until valid_move
      puts "#{player}, enter your move (row, col):"
      input = gets.chomp.split(',').map(&:strip).map(&:to_i)

      if input.size == 2 && input.all? { |num| num.is_a?(Integer) }
        row, col = input
        if valid_move?(row, col)
          @board.place_symbol(row, col, player)
          valid_move = true
        else
          puts "Invalid move. Please try again."
        end
      else
        puts "Please enter a valid move in the format 'row,col'."
      end
    end
  end

  def valid_move?(row, col)
    # Check if the move is within the board and the cell is empty
    row.between?(0, 2) && col.between?(0, 2) && @board.cell_empty?(row, col)
  end

  def game_over?
    # Check if the game is over
    @board.check_winner == "X" || @board.check_winner == "O" || @board.check_winner == "Draw"
  end

  def switch_player
    @current_player = @current_player == "X" ? "O" : "X"
  end

  def conclude_game
    winner = @board.check_winner
    if winner == "Draw"
      puts "Game is a draw!"
    else
      puts "#{winner} wins the game!"
    end
  end
end

game = Game.new
game.play
