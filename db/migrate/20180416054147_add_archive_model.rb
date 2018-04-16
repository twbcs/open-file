class AddArchiveModel < ActiveRecord::Migration[5.2]
  def change
    create_table :archives do |t|
      t.references :owner
      t.string :owner_type
      t.string :name
      t.index [:owner_id, :owner_type]
    end
  end
end
