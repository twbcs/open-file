class AuthorsController < ApplicationController

  def index
    if params[:tag_name]
      @authors = Author.tagged_with(names: params[:tag_name], :match => :any).with_attached_image
    else
      @authors = Author.all.with_attached_image
    end
  end

  def show
    @author = Author.find(params[:id])
  end

  private
end
