class AuthorsController < ApplicationController
  before_action :set_author, only: [:show]

  # GET /authors
  # GET /authors.json
  def index
    if params[:tag_name]
      @authors = Author.tagged_with(names: params[:tag_name], :match => :any).with_attached_image
    else
      @authors = Author.all.with_attached_image
    end
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end
end
