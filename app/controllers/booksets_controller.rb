class BooksetsController < ApplicationController
  # GET /booksets
  # GET /booksets.json
  def index
    @booksets = Bookset.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @booksets }
    end
  end

  # GET /booksets/1
  # GET /booksets/1.json
  def show
    @bookset = Bookset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookset }
    end
  end

  # GET /booksets/new
  # GET /booksets/new.json
  def new
    @bookset = Bookset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookset }
    end
  end

  # GET /booksets/1/edit
  def edit
    @bookset = Bookset.find(params[:id])
  end

  # POST /booksets
  # POST /booksets.json
  def create
    @bookset = Bookset.new(params[:bookset])

    respond_to do |format|
      if @bookset.save
        format.html { redirect_to @bookset, notice: 'Bookset was successfully created.' }
        format.json { render json: @bookset, status: :created, location: @bookset }
      else
        format.html { render action: "new" }
        format.json { render json: @bookset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /booksets/1
  # PUT /booksets/1.json
  def update
    @bookset = Bookset.find(params[:id])

    respond_to do |format|
      if @bookset.update_attributes(params[:bookset])
        format.html { redirect_to @bookset, notice: 'Bookset was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bookset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /booksets/1
  # DELETE /booksets/1.json
  def destroy
    @bookset = Bookset.find(params[:id])
    @bookset.destroy

    respond_to do |format|
      format.html { redirect_to booksets_url }
      format.json { head :ok }
    end
  end
end
