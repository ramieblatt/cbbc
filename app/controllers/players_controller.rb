class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :set_edition_id

  # GET /players
  # GET /players.json
  def index
    @q = Player.ransack(params[:q])
    result = @q.result(distinct: true)
    if @q.sorts.any?
      result = result.except(:order).order("#{@q.sorts.first.name} #{@q.sorts.first.dir} NULLS LAST")
    end
    @players = result.includes(:batting_stats).includes(:pitching_stats).includes(:fielding_stats).page(params[:page])
  end

  def prebuilt_search
    @q = Player.ransack(params[:q])
    @players = Player.apply_prebuilt_search(params[:query]).includes(:batting_stats).includes(:pitching_stats).includes(:fielding_stats).page(params[:page])
    render :index
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

    def set_edition_id
      @edition_id = params[:edition_id]
      @edition_id ||= params[:edition][:id] if params[:edition]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.fetch(:player, {})
    end
end
