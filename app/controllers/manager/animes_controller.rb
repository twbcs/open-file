class Manager::AnimesController < Manager::ManagerController
  before_action :set_anime, only: [:show, :edit, :update, :destroy, :remove]

  def index
    all_tags = Gutentag::Tagging.where(taggable_type: 'Anime').group(:tag_id).pluck(:tag_id)
    @all_names = Gutentag::Tag.where(id: all_tags).pluck(:name)
    if params[:tag_name]
      @animes = Anime.tagged_with(names: params[:tag_name], :match => :any).with_attached_image
    else
      @animes = Anime.all.with_attached_image
    end
  end

  def show
  end

  def new
    @anime = Anime.new
  end

  def edit
  end

  def create
    tag_split
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
    tag_split
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

  def tag_split
    params[:anime][:tag_names] = params[:anime][:tag_names][0].split(' ') if params[:anime][:tag_names].any?
  end

  def tag_update
    # tags = Gutentag::Tag.all.pluck(:name)
    # params[:anime][:tag_names].each do |tag|
    #   Gutentag::Tag.new(name: tag).save unless tags.include? tag
    # end
  end
end
