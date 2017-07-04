class AddScriptBooleanToProcessor < ActiveRecord::Migration[5.1]
  def change
    add_column :processors, :file_present, :boolean, default: false, null: false
    add_column :processors, :script_file, :string
  end
end
