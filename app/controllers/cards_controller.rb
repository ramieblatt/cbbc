class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.page(params[:page])
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @card, status: 200 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.fetch(:card, {})
    end
end
