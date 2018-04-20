class Manager::AnimesController < Manager::ManagerController
  before_action :set_anime, only: [:show, :edit, :update, :destroy, :remove]

  def index
    @all_names = Anime.tag_counts_on(:tags).pluck(:name)
    if params[:tag_name]
      @animes = Anime.tagged_with(params[:tag_name], any: true).with_attached_image
    else
      @animes = Anime.all.with_attached_image
    end
  end

  def show
  end

  def new
    @all_names = ActsAsTaggableOn::Tag.all
    @anime = Anime.new
  end

  def edit
    @all_names = ActsAsTaggableOn::Tag.all
  end

  def create
    # tag_split
    @anime = Anime.new(anime_params)
    if @anime.save
      redirect_to @anime, notice: "#{@anime.name}已新增"
    else
      render :new
    end
  end

  def remove # remove image
    if @anime.image.attached?
      @anime.image.purge
    end
    redirect_to edit_manager_anime_url(@anime)
  end

  def update
    if @anime.update(anime_params)
      redirect_to @anime, notice: "#{@anime.name}已更新"
    else
      render :edit
    end
  end

  def destroy
    @anime.destroy
    redirect_to authors_url, notice: "#{@anime.name}已刪除"
  end

  private
  def set_anime
    @anime = Anime.find(params[:id])
  end

  def anime_params
    params.require(:anime).permit(:name, :dir_name, :image, tag_names: [])
  end
end
