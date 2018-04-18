class Manager::AuthorsController < Manager::ManagerController
  before_action :set_author, only: [:edit, :update, :destroy, :remove]

  def index
    @all_names = get_tags('Author')
    @all_item_names = get_tags('Archive')
    if params[:tag_name]
      @authors = Author.tagged_with(names: params[:tag_name], match: :any).with_attached_image
    else
      @authors = Author.all.with_attached_image
    end
  end

  def show
    @author = Author.includes(:archives).find(params[:id])
    all_tags = Gutentag::Tagging.where(taggable_type: 'Archive', taggable_id: @author.archives.ids).group(:tag_id).pluck(:tag_id)
    @all_names = Gutentag::Tag.where(id: all_tags).pluck(:name)
  end

  def new
    @author = Author.new
  end

  def edit
  end

  def create
    tag_split
    @author = Author.new(author_params)
    if @author.save
      redirect_to @author, notice: "#{@author.name}已新增"
    else
      render :new
    end
  end

  def remove # remove image
    if @author.image.attached?
      @author.image.purge
    end
    redirect_to edit_manager_author_url(@author)
  end

  def update
    tag_split
    if @author.update(author_params)
      redirect_to @author, notice: "#{@author.name}已更新"
    else
      render :edit
    end
  end

  def destroy
    @author.destroy
    redirect_to authors_url, notice: "#{@author.name}已刪除"
  end

  private
  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :dir_name, :image, tag_names: [])
  end

  def tag_split
    params[:author][:tag_names] = params[:author][:tag_names][0].split(' ') if params[:author][:tag_names].any?
  end

  def get_tags(type)
    all_tags = Gutentag::Tagging.where(taggable_type: type).group(:tag_id).pluck(:tag_id)
    Gutentag::Tag.where(id: all_tags).pluck(:name)
  end

  def tag_update
    # tags = Gutentag::Tag.all.pluck(:name)
    # params[:author][:tag_names].each do |tag|
    #   Gutentag::Tag.new(name: tag).save unless tags.include? tag
    # end
  end
end
