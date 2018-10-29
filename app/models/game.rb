# games model
class Game < ApplicationRecord
  has_many :moves, dependent: :destroy

  def board_take
    board = Array.new(3) { Array.new(3, ' ') }

    moves.each_with_index do |move, i|
      board[move.y][ move.x ] = i.even? ? 'X' : 'O'
    end

    board
  end

  def finished?
    if !winner.nil? || (moves.count == 9)
      true
    else
      false
    end
  end

  def winner
    board = board_take

    # Three horizontal
    board.each do |row|
      next if row[0] == ' '
      return row.uniq.first if row.uniq.length == 1
    end

    # Three vertical
    board.transpose.each do |col|
      next if col[0] == ' '
      return col.uniq.first if col.uniq.length == 1
    end

    # Three diagonal
    if (board[0][0] != ' ') &&
       (board[0][0] == board[1][1]) &&
       (board[1][1] == board[2][2])
      return board[0][0]
    end

    if (board[2][0] != ' ') &&
       (board[2][0] == board[1][1]) &&
       (board[1][1] == board[0][2])
      return board[2][0]
    end

    nil
  end
end
