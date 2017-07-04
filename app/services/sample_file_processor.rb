# frozen_string_literal: true
class SampleFileProcessor
  def self.process(file)
    binding.pry
    new_file = File.open("sample_processor_result.txt", "w")
    CSV.foreach(file, headers: true) do |row|
      row.to_hash.select! do |head, _|
        ["id","name", "group_number"].include? head
      end

      new_file.write row.to_csv
    end

    new_file.close
    new_file
  end
end