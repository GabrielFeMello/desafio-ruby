class TransationsController < ApplicationController
  before_action :set_transation, only: %i[ show edit update destroy ]

  # GET /transations or /transations.json
  def index
    @transations = Transation.all
  end

  # GET /transations/1 or /transations/1.json
  def show
  end

  # GET /transations/new
  def new
    @transation = Transation.new
  end

  # GET /transations/1/edit
  def edit
  end

  # POST /transations or /transations.json
  def create
    @transation = Transation.new(transation_params)

    respond_to do |format|
      if @transation.save
        format.html { redirect_to @transation, notice: "Transation was successfully created." }
        format.json { render :show, status: :created, location: @transation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transations/1 or /transations/1.json
  def update
    respond_to do |format|
      if @transation.update(transation_params)
        format.html { redirect_to @transation, notice: "Transation was successfully updated." }
        format.json { render :show, status: :ok, location: @transation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transations/1 or /transations/1.json
  def destroy
    @transation.destroy
    respond_to do |format|
      format.html { redirect_to transations_url, notice: "Transation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def cnab_upload
    @filename = params[:file]

    if @filename.respond_to?(:read)
      @lines = @filename.read.force_encoding("UTF-8")

      data = @lines.split(/\n/)
      raise data.inspect
    elsif @filename.respond_to?(:path)
      @lines = File.read(@filename.path)
      raise @lines.inspect
    else
      logger.error "Bad file_data: #{@filename.class.name}: #    
      {@filename.inspect}"
    end


    return @lines
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transation
      @transation = Transation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transation_params
      params.require(:transation).permit(:type, :date, :value, :representative_id, :store_id, :card, :time)
    end
end
