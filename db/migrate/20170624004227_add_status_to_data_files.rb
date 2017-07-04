class AddStatusToDataFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :data_files, :status, :integer, default: 0, null: false
    add_column :data_files, :errs, :string
  end
end
