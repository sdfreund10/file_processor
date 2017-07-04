# frozen_string_literal: true
class FileProcessorService
  require 'csv'
  def process_file(data_file, processor)
    processed_file = processor.processor_class.constantize.process(
      data_file.original_file_location
    )
    binding.pry
    data_file.update(processed_file: File.basename(processed_file.path))
    FileUtils.mv(processed_file.path, processor.processed_files)
  rescue NameError
    "Processor Class not registered"
  end
end
