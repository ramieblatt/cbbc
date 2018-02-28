class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    @q = Player.ransack(params[:q])
    @players = @q.result.includes(:batting_stats).includes(:pitching_stats).includes(:fielding_stats).page(params[:page])
  end

  # GET /players/1
  # GET /players/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @player, status: 200 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.fetch(:player, {})
    end
end
