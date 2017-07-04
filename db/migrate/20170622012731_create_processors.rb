class CreateProcessors < ActiveRecord::Migration[5.1]
  def change
    create_table :processors do |t|
      t.string :name, null: false
      t.string :source
      t.string :processor_class, null: false
      t.timestamps
    end
  end
end
