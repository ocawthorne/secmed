class AddEmailToDoctors < ActiveRecord::Migration[6.0]
  def change
    add_column :doctors, :email, :string
  end
end
