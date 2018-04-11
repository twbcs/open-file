class Manager::AuthorsController < Manager::ManagerController
  before_action :set_author, only: [:show, :edit, :update, :destroy, :remove]

  def index
    if params[:tag_name]
      @authors = Author.tagged_with(names: params[:tag_name], :match => :any)
    else
      @authors = Author.all
    end
  end

  def show
  end

  def new
    @author = Author.new
  end

  def edit
  end

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
      @author.image.purge
    end
    redirect_to edit_author_url(@author)
  end

  def update
    tag_split
    tag_update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
    end
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

    def tag_update
      tags = Gutentag::Tag.all.pluck(:name)
      params[:author][:tag_names].each do |tag|
        Gutentag::Tag.new(name: tag).save unless tags.include? tag
      end
    end
end
