class AnimesController < ApplicationController
  def index
    @all_names = Anime.cache_tags
    if params[:tag_name]
      @animes = Anime.tagged_with(params[:tag_name], any: true).with_attached_image
    else
      @animes = Anime.all.with_attached_image
    end
  end

  def show
    @anime = Anime.find(params[:id])
  end

  def run
    @anime = Anime.find(params[:id])
    if params[:file]
      player(ANIME_DIR, @anime, params[:file])
    else
      finder(ANIME_DIR, @anime)
    end
  end

  private
end
