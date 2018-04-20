class Manager::AuthorsController < Manager::ManagerController
  before_action :set_author, only: [:edit, :update, :destroy, :remove]

  def index
    @all_names = Author.cache_tags
    @all_item_names = Archive.cache_tags

    if params[:tag_name]
      @authors = Author.tagged_with(params[:tag_name], any: true).with_attached_image
    else
      @authors = Author.all.with_attached_image
    end
  end

  def show
    @author = Author.includes(:archives).find(params[:id])
    @all_names = Author.tag_counts_on(:tags).pluck(:name)
  end

  def new
    @all_names = ActsAsTaggableOn::Tag.all
    @author = Author.new
  end

  def edit
    @all_names = ActsAsTaggableOn::Tag.all
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      Rails.cache.delete('author_tags')
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
    set_tags(@author, author_params)
    if @author.update(author_params)
      Rails.cache.delete('author_tags')
      redirect_to @author, notice: "#{@author.name}已更新"
    else
      render :edit
    end
  end

  def destroy
    @author.destroy
    Rails.cache.delete('author_tags')
    redirect_to authors_url, notice: "#{@author.name}已刪除"
  end

  private
  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :dir_name, :image, tag_list: [])
  end
end
