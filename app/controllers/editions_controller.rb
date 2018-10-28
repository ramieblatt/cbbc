class EditionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_edition, only: [:show, :edit, :update, :mint, :destroy, :create_cards, :remove_all_cards, :mint, :mint_five_pack_of_cards]

  # GET /editions
  # GET /editions.json
  def index
    @editions = Edition.all
  end

  # GET /editions/1
  # GET /editions/1.json
  def show
  end

  # GET /editions/new
  def new
    @edition = Edition.new
  end

  # GET /editions/1/edit
  def edit
  end

  # POST /editions
  # POST /editions.json
  def create
    @edition = Edition.new(edition_params)
    respond_to do |format|
      if @edition.save
        format.html { redirect_to @edition, notice: 'Edition was successfully created.' }
        format.json { render :show, status: :created, location: @edition }
      else
        format.html { render :new }
        format.json { render json: @edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /editions/1
  # PATCH/PUT /editions/1.json
  def update
    respond_to do |format|
      if @edition.update(edition_params)
        format.html { redirect_to @edition, notice: 'Edition was successfully updated.' }
        format.json { render :show, status: :ok, location: @edition }
      else
        format.html { render :edit }
        format.json { render json: @edition.errors, status: :unprocessable_entity }
      end
    end
  end

  def mint
    if @edition.is_published? or (@edition.number.present? and ETHEREUM_CONTRACT.call.check_edition_exists(@edition.number))
      redirect_to @edition, error: 'Edition cannot be minted because it is published or minted on the blockchain!'
    else
      res = @edition.mint
      if res[:success]
        flash[:notice] = "Edition was successfully minted on the blockchain! #{res[:message]}"
      else
        flash[:error] = "Could not mint edition on the blockchain! #{res[:message]}"
      end
      redirect_to @edition
    end

  end

  def mint_five_pack_of_cards
    unless (@edition.is_published? and @edition.number.present? and ETHEREUM_CONTRACT.call.check_edition_exists(@edition.number))
      redirect_to @edition, error: 'Five pack of cards cannot be minted because edition is not published and minted on the blockchain!'
    else
      res = @edition.mint_five_pack_of_cards
      if res[:success]
        flash[:notice] = "Five pack of cards was successfully minted on the blockchain! #{res[:message]}"
      else
        flash[:error] = "Could not mint five pack of cards on the blockchain! #{res[:message]}"
      end
      redirect_to @edition
    end

  end

  # DELETE /editions/1
  def destroy
    if @edition.is_published? or ETHEREUM_CONTRACT.call.check_edition_exists(@edition.number)
      redirect_to @edition, error: 'Edition cannot be deleted because it is published or minted on the blockchain!'
    else
      @edition.destroy
      respond_to do |format|
        format.html { redirect_to editions_url, notice: 'Edition was successfully destroyed.' }
      end
    end
  end

  def create_cards
    if res = @edition.create_cards({total_cards: 1000})
      redirect_to @edition, notice: "Edition card set of #{res} was successfully created."
    else
      redirect_to @edition, error: "Edition card set could not be created."
    end
  end

  def create_cards_from_players
    @edition = Edition.find(params[:edition].delete(:id))
    @return_path = params[:return_path]
    if res = @edition.create_cards_from_players(params[:edition])
      redirect_to ("#{@return_path || @edition}?edition_id=#{@edition.id}"), notice: "Edition card set of #{res} was successfully created."
    else
      redirect_to @edition, error: "Edition card set could not be created."
    end
  end

  def remove_all_cards
    if (@edition.is_published != true or ETHEREUM_CONTRACT.call.check_edition_exists(@edition.number)) and @edition.remove_all_cards!
      redirect_to players_url, notice: "Edition card set was successfully destroyed."
    else
      redirect_to @edition, error: "Edition card set could not be destroyed."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_edition
      @edition = Edition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def edition_params
      params.fetch(:edition, {})
    end
end
