class MoviesController < ApplicationController
  def index
    all_tags = Gutentag::Tagging.where(taggable_type: 'Movie').group(:tag_id).pluck(:tag_id)
    @all_names = Gutentag::Tag.where(id: all_tags).pluck(:name)
    if params[:tag_name]
      @movies = Movie.tagged_with(names: params[:tag_name], :match => :any).with_attached_image
    else
      @movies = Movie.all.with_attached_image
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def run
    @movie = Movie.find(params[:id])
    if params[:file]
      player(MOVIE_DIR, @movie, params[:file])
    else
      finder(MOVIE_DIR, @movie)
    end
  end

  private
end
