class CarriersAddRating < ActiveRecord::Migration[5.2]
  def change
    add_column :carriers, :rating, :integer, default: 0
  end
end
