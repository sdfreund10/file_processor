class RemoveProcessedFile2FromDataFile < ActiveRecord::Migration[5.1]
  def change
    rename_column :data_files, :processed_file_1, :processed_file
    remove_column :data_files, :processed_file_2
  end
end
