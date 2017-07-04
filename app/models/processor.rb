# == Schema Information
#
# Table name: processors
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  source          :string
#  processor_class :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  file_present    :boolean          default(FALSE), not null
#  script_file     :string
#

class Processor < ApplicationRecord
  has_many :data_files, dependent: :destroy
  after_save :make_dirs

  def raw_dir
    file_dir + "raw_files/"
  end

  def processed_files
    file_dir + "processed_files/"
  end

  def replace_script(file)
    FileUtils.rm(script_location)
    update(script_file: file.original_filename)
    FileUtils.mv(file, script_location)
  end

  private

  def file_dir
    "./lib/data_files/#{name.delete("\s").tableize}/"
  end

  def make_dirs
    [file_dir, raw_dir, processed_files].each do |dir|
      Dir.mkdir(dir) unless Dir.exist?(dir)
    end
  end

  def script_location
    "lib/scripts/#{script_file}"
  end
end
