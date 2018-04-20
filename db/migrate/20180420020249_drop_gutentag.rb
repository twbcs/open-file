class DropGutentag < ActiveRecord::Migration[5.2]
  def change
    drop_table :gutentag_tags
    drop_table :gutentag_taggings
  end
end
