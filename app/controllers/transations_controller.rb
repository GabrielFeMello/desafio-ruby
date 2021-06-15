class TransationsController < ApplicationController
  before_action :set_transation, only: %i[ show edit update destroy ]

  # GET /transations or /transations.json
  def index
    @transations = Transation.all.joins("left join stores on stores.id = transations.store_id").joins("left join representatives on representatives.id = transations.representative_id").select("transations.id,transations.transation_type, transations.date, transations.card, transations.time, transations.value,representatives.name as representative_name, stores.name as store_name, stores.id as store_id, representatives.id as representative_id, representatives.document as representative_document")
  end

  # GET /transations/1 or /transations/1.json
  def show
  end

  # GET /transations/new
  def new
    @transation = Transation.new
    @stores = Store.all
    @representatives = Representative.all
  end

  # GET /transations/1/edit
  def edit
  end

  # POST /transations or /transations.json
  def create
    @transation = Transation.new(transation_params)
    @stores = Store.all
    @representatives = Representative.all


    respond_to do |format|
      if @transation.save
        format.html { redirect_to action: "index", notice: "Transation was successfully created." }
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

  def break_cnab data_line
    content = {}
    content["transation"] = {}
    content["representative"] = {}
    content["store"] = {}

    content["transation"]["transation_type"] = data_line[0].to_i
    content["transation"]["date"] = data_line[1..8]
    content["transation"]["card"] = data_line[30..41]
    content["transation"]["time"] = Time.at(data_line[42..47].to_i)
    content["transation"]["value"] = data_line[9..18].to_i/100

    content["representative"]["name"] = data_line[48..61]
    content["representative"]["document"] = data_line[19..29]

    content["store"]["name"] = data_line[62..80]

    return content
  end


  def fill_database dataLines
    if dataLines.first.length > 70 && dataLines.first.length < 90
      dataLines.each do |data_line|
        @content = break_cnab(data_line)

        @store = Store.find_by(name: @content["store"]["name"])
        @representative = Representative.find_by(name: @content["representative"]["name"])

        unless @store
          @store = Store.new(@content['store'])
          @store.save
        end
        unless @representative
          @representative = Representative.new(@content["representative"])
          @representative.store_id = @store.id
          @representative.save
        end

        @transation = Transation.where(store_id: @store.id, representative_id: @representative.id, transation_type: @content["transation"]["transation_type"], time: @content["transation"]["time"], value: @content["transation"]["value"], date: @content["transation"]["date"])

        unless @transation.first
          @transation = Transation.new()
          @transation.transation_type = @content["transation"]["transation_type"]
          @transation.date = @content["transation"]["date"]
          @transation.card = @content["transation"]["card"]
          @transation.time = @content["transation"]["time"]
          @transation.value = @content["transation"]["value"]

          @transation.store_id = @store.id
          @transation.representative_id = @representative.id
          @transation.save
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to action: "index", notice: "Transations could not be uploaded. Line lengths not accepted"  }
        format.json { render json: {errors: ["Line lengths not accepted"]}, status: :unprocessable_entity }
      end
    end
  end

  def cnab_upload
    @filename = params[:file]

    if @filename.respond_to?(:read)
      @lines = @filename.read.force_encoding("UTF-8")
    elsif @filename.respond_to?(:path)
      @lines = File.read(@filename.path)
    else
      logger.error "Bad file_data: #{@filename.class.name}: #    
      {@filename.inspect}"
      
      format.json { render json: logger.error, status: :unprocessable_entity }
    end

    @dataLines = @lines.split(/\n/)
    fill_database(@dataLines)

    @transations = Transation.all.joins("left join stores on stores.id = transations.store_id").joins("left join representatives on representatives.id = transations.representative_id").select("transations.id,transations.transation_type, transations.date, transations.card, transations.time, transations.value,representatives.name as representative_name, stores.name as store_name")

    respond_to do |format|
      format.html { redirect_to action: "index", notice: "Transations were successfully uploaded."  }
      format.json { render :index, status: :ok, location: @transations }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transation
      @transation = Transation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transation_params
      
      if params['transation']['date(1i)']

        new_date = params["transation"]["date(2i)"]+"/"+params["transation"]["date(3i)"]+"/"+params["transation"]["date(1i)"]
        new_time = Time.at(DateTime.new(params["transation"]["date(1i)"].to_i, params["transation"]["date(2i)"].to_i, params["transation"]["date(3i)"].to_i,params["transation"]["date(4i)"].to_i,params["transation"]["date(5i)"].to_i, 0, "-3"))
        params["transation"]["date"] = new_date
        params["transation"]["time"] = new_time
      end


      params.require(:transation).permit(:transation_type, :date, :value, :representative_id, :store_id, :card, :time)
    end
end
