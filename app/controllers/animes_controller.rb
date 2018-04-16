class AnimesController < ApplicationController
  def index
    all_tags = Gutentag::Tagging.where(taggable_type: 'Anime').group(:tag_id).pluck(:tag_id)
    @all_names = Gutentag::Tag.where(id: all_tags).pluck(:name)
    if params[:tag_name]
      @animes = Anime.tagged_with(names: params[:tag_name], :match => :any).with_attached_image
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
