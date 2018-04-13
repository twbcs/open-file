class AuthorToCarrier < ActiveRecord::Migration[5.2]
  def change
    rename_table :authors, :carriers

    add_column :carriers, :type, :string

    Carrier.update_all(type: 'Author')
    ActiveStorage::Attachment.update_all(record_type: 'Carrier')
  end
end
