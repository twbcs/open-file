class MoviesController < ApplicationController
  def index
    @all_names = Movie.tag_counts_on(:tags).pluck(:name)
    if params[:tag_name]
      @movies = Movie.tagged_with(params[:tag_name], any: true).with_attached_image
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
