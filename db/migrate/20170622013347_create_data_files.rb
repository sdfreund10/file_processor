class CreateDataFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :data_files do |t|
      t.string :original_file, null: false
      t.string :processed_file_1
      t.string :processed_file_2
      t.integer :processor_id, null: false, references: [:processors, :id]

      t.timestamps
    end
  end
end
