# Game controller
class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    game = Game.find_by(id: params[:id])
    moves = game.moves
    game_over = game.finished?
    winner = game.winner

    render json: {
      game: game,
      game_over: game_over,
      winner: winner,
      moves: moves
    }
  end

  def create
    game = Game.create({})
    game.save

    render json: game, except: :updated_at
  end

  def update
    game = Game.find_by(id: params[:id])
    new_move = Move.new(x: params[:x], y: params[:y], game_id: game.id)

    begin
      new_move.save

      if new_move.errors.empty? then render json: {
        new_move: new_move
      }
        # Handle validation errors
      else render json: { errors: new_move.errors }
      end

    # Handle already played move exception
    rescue ActiveRecord::RecordNotUnique
      render json: { errors: { game: ['Move has already been played.'] } }
    end
  end
end
