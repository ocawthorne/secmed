class RenameDrugColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :drugs, :contraurl, :contra_url
    rename_column :drugs, :interactionurl, :interaction_url
  end
end
