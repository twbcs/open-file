class Manager::MoviesController < Manager::ManagerController
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :remove]

  def index
    @all_names = Movie.cache_tags
    if params[:tag_name]
      @movies = Movie.tagged_with(params[:tag_name], any: true).with_attached_image
    else
      @movies = Movie.all.with_attached_image
    end
  end

  def show
  end

  def new
    @all_names = ActsAsTaggableOn::Tag.all
    @movie = Movie.new
  end

  def edit
    @all_names = ActsAsTaggableOn::Tag.all
  end

  def create
    # tag_split
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
    if @movie.update(movie_params)
      Rails.cache.delete('movie_tags')
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
    params.require(:movie).permit(:name, :dir_name, :image, tag_list: [])
  end
end
