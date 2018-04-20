class Manager::ManagerController < ApplicationController

  private

  def set_tags(model, strong_params)
    new_tags = strong_params['tag_list'].to_a.reject { |c| c.empty? }
    old_tags = model.tags.map(&:name)
    return if new_tags == old_tags
    (old_tags - new_tags).map {|e| model.tag_list.remove(e)}
    (new_tags - old_tags ).map {|e| model.tag_list.add e}
  end
end
