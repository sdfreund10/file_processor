# == Schema Information
#
# Table name: data_files
#
#  id             :integer          not null, primary key
#  original_file  :string           not null
#  processed_file :string
#  processor_id   :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :integer          default("unprocessed"), not null
#  errs           :string
#

class DataFile < ApplicationRecord
  belongs_to :processor
  enum status: [:unprocessed, :failure, :success]

  def original_file_location
    processor.raw_dir + original_file
  end

  def processed_file_location
    processor.processed_dir + processed_file
  end

  def replace_original(file)
    FileUtils.rm(original_file_location) unless Dir[original_file_location].empty?
    update(original_file: file.original_filename)
    FileUtils.mv(file.tempfile, original_file_location)
  end
end
