class Manager::MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :remove]

  def index
    all_tags = Gutentag::Tagging.where(taggable_type: 'Movie').group(:tag_id).pluck(:tag_id)
    @all_names = Gutentag::Tag.where(id: all_tags).pluck(:name)
    if params[:tag_name]
      @movies = Movie.tagged_with(names: params[:tag_name], :match => :any).with_attached_image
    else
      @movies = Movie.all.with_attached_image
    end
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    tag_split
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "#{@movie.name}已新增"
    else
      render :new
    end
  end

  def remove # remove image
    if @movie.image.attached?
      @movie.image.purge
    end
    redirect_to edit_manager_movie_url(@movie)
  end

  def update
    tag_split
    if @movie.update(movie_params)
      redirect_to @movie, notice: "#{@movie.name}已更新"
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to authors_url, notice: "#{@movie.name}已刪除"
  end

  private
  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:name, :dir_name, :image, tag_names: [])
  end

  def tag_split
    params[:movie][:tag_names] = params[:movie][:tag_names][0].split(' ') if params[:movie][:tag_names].any?
  end

  def tag_update
    # tags = Gutentag::Tag.all.pluck(:name)
    # params[:movie][:tag_names].each do |tag|
    #   Gutentag::Tag.new(name: tag).save unless tags.include? tag
    # end
  end
end
