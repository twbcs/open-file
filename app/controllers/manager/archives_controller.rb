class Manager::ArchivesController < Manager::ManagerController
  def new
    @owner = Author.find(params[:author_id])
    @archive = @owner.archives.new(name: params[:file])
  end

  def create
    tag_split
    owner = Author.find(params[:author_id])
    archive = owner.archives.new(archive_params)
    if archive.save
      redirect_to manager_author_path(owner.id)
    end
  end

  def edit
    @archive = Archive.find(params[:id])
  end

  def update
    tag_split
    archive = Archive.find(params[:id])
    if archive.update(archive_params)
      redirect_to manager_author_path(archive.owner.id)
    end
  end

  def rating
    archive = Archive.find(params[:id])
    archive.update_column(rating: params[:rating])
    render json: archive
  end

  private
  def archive_params
    params.require(:archive).permit(:name, :owner_id, :owner_type, tag_names: [])
  end

  def tag_split
    params[:archive][:tag_names] = params[:archive][:tag_names][0].split(' ') if params[:archive][:tag_names].any?
  end
end
