class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy, :remove]

  # GET /authors
  # GET /authors.json
  def index
    if params[:tag_name]
      @authors = Author.tagged_with(names: params[:tag_name], :match => :any)
    else
      @authors = Author.all
    end
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors
  # POST /authors.json
  def create
    tag_split
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'Author was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def remove # remove image
    if @author.image.attached?
      @author.image.delete
    end
    redirect_to edit_author_url(@author)
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    tag_split
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:author).permit(:name, :dir_name, :image, tag_names: [])
    end

    def tag_split
      params[:author][:tag_names] = params[:author][:tag_names][0].split(' ') if params[:author][:tag_names].any?
    end
end
