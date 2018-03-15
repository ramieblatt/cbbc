class EditionsController < ApplicationController
  before_action :set_edition, only: [:show, :edit, :update, :destroy, :create_cards, :remove_all_cards]

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
    @edition.number = Edition.next_edition_number
  end

  # GET /editions/1/edit
  def edit
  end

  # POST /editions
  # POST /editions.json
  def create
    @edition = Edition.new(edition_params)
    @edition.number = Edition.next_edition_number
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

  # DELETE /editions/1
  # DELETE /editions/1.json
  def destroy
    @edition.destroy
    respond_to do |format|
      format.html { redirect_to edition_url, notice: 'Edition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_cards
    if res = @edition.create_cards({total_cards: 1000})
      redirect_to @edition, notice: "Edition card set of #{res} was successfully created."
    else
      redirect_to @edition, notice: "Edition card set could not be created."
    end
  end

  def create_cards_from_players
    @edition = Edition.find(params[:edition].delete(:id))
    @return_path = params[:return_path]
    if res = @edition.create_cards_from_players(params[:edition])
      redirect_to (@return_path || @edition), notice: "Edition card set of #{res} was successfully created."
    else
      redirect_to @edition, notice: "Edition card set could not be created."
    end
  end

  def remove_all_cards
    if @edition.is_published != true and res = @edition.remove_all_cards!
      redirect_to players_url, notice: "Edition card set was successfully destroyed."
    else
      redirect_to @edition, notice: "Edition card set could not be destroyed."
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
