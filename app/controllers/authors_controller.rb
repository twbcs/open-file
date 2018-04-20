class AuthorsController < ApplicationController

  def index
    @all_names = Author.cache_tags
    @all_item_names = Archive.cache_tags

    if params[:tag_name]
      @archives = Archive.tagged_with(params[:tag_name], any: true)
      @authorsx = Author.where(id: @archives.pluck(:owner_id)).with_attached_image
      @authors = Author.tagged_with(params[:tag_name], any: true).with_attached_image
    else
      @archives = Archive.none
      @authorsx = Author.none
      @authors = Author.all.with_attached_image
    end
  end

  def show
    @author = Author.includes(:archives).find(params[:id])
    @all_names = Author.cache_tags
  end

  def run
    @author = Author.find(params[:id])
    if params[:file]
      look(AUTHOR_DIR, @author, params[:file])
    else
      finder(AUTHOR_DIR, @author)
    end
  end

  private

end
