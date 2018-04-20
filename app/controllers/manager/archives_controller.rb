class Manager::ArchivesController < Manager::ManagerController
  def new
    @all_names = ActsAsTaggableOn::Tag.all
    @owner = Author.find(params[:author_id])
    @archive = @owner.archives.new(name: params[:file])
    @archive.save
  end

  def create
    archive = Author.find(params[:author_id]).yield_self {|owner| owner.archives.new(archive_params)}
    if archive.save
      redirect_to manager_author_path(owner.id)
    end
  end

  def edit
    @all_names = ActsAsTaggableOn::Tag.all
    @archive = Archive.find(params[:id])
  end

  def update
    archive = Archive.find(params[:id])
    set_tags(archive, archive_params)

    if archive.update(archive_params)
      Rails.cache.delete('archive_tags')
      redirect_to manager_author_path(archive.owner.id)
    end
  end

  def rating
    archive = Archive.find(params[:id])
    archive.update_column(:rating, params[:rating])
    render json: archive
  end

  private

  def archive_params
    params.require(:archive).permit(:owner_id, :owner_type, tag_list: [])
  end

end
