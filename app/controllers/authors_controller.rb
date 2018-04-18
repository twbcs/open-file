class AuthorsController < ApplicationController

  def index
    @all_names = get_tags('Author')
    @all_item_names = get_tags('Archive')
    if params[:tag_name]
      author_ids = Archive.tagged_with(names: params[:tag_name], match: :any).pluck(:owner_id)
      @authorsx = Author.where(id: author_ids).with_attached_image
      @authors = Author.tagged_with(names: params[:tag_name], match: :any).with_attached_image
    else
      @authorsx = Archive.none
      @authors = Author.all.with_attached_image
    end
  end

  def show
    @author = Author.includes(:archives).find(params[:id])
    all_tags = Gutentag::Tagging.where(taggable_type: 'Archive', taggable_id: @author.archives.ids).group(:tag_id).pluck(:tag_id)
    @all_names = Gutentag::Tag.where(id: all_tags).pluck(:name)
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

  def get_tags(type)
    all_tags = Gutentag::Tagging.where(taggable_type: type).group(:tag_id).pluck(:tag_id)
    Gutentag::Tag.where(id: all_tags).pluck(:name)
  end
end
