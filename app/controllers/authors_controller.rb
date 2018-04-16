class AuthorsController < ApplicationController

  def index
    all_tags = Gutentag::Tagging.where(taggable_type: 'Author').group(:tag_id).pluck(:tag_id)
    @all_names = Gutentag::Tag.where(id: all_tags).pluck(:name)
    if params[:tag_name]
      @authors = Author.tagged_with(names: params[:tag_name], :match => :any).with_attached_image
    else
      @authors = Author.all.with_attached_image
    end
  end

  def show
    @author = Author.find(params[:id])
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
