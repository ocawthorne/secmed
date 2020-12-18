class AddUidToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :uid, :string
  end
end
