class DataFilesController < ApplicationController
  def new
    @data_file = DataFile.new
  end

  def create
    if attachment
      @data_file = DataFile.new(
        data_file_params.merge(original_file: attachment.original_filename)
      )
      if @data_file.save
        FileUtils.mv(attachment.tempfile, "./lib/#{attachment.original_filename}")
        @data_file.update(data_file_params.merge(original_file: attachment.original_filename))
        redirect_to :data_files
      else
        flash[:alert] = "Please upload a file"
        render :new
      end
    end
  end

  def edit
    @data_file = DataFile.find(params[:id])
  end

  def update
    @data_file = DataFile.find(params[:id])

    if @data_file.update(data_file_params)
      @data_file.replace_original(attachment) if attachment
      redirect_to :data_files
    else
      render :edit
    end
  end

  def process_file
    render :edit
  end

  def index
    @data_files = DataFile.all
  end

  def destroy
    @data_file = DataFile.find(params[:id])
    @data_file.destroy
    redirect_to :data_files
  end

  def download_original
    @data_file = DataFile.find(params[:id])
    respond_to do |format|
      format.html { redirect_to edit_data_file_path}
      format.csv do
        send_file(
          @data_file.original_file_location,
          filename: @data_file.original_file,
        )
      end
    end
  end

  def download_processed
    @data_file = DataFile.find(params[:id])
    respond_to do |format|
      format.html { redirect_to edit_data_file_path}
      format.csv do
        send_file(
          @data_file.original_file_location,
          filename: @data_file.original_file,
        )
      end
    end
  end

  def process_file
    @data_file = DataFile.find(params[:id])
    notice = FileProcessorService.new.
              process_file(@data_file, @data_file.processor)
    redirect_to edit_data_file_path, notice: notice
  end

  private

  def data_file_params
    params.require(:data_file).permit(:processor_id)
  end

  def attachment
    params.require(:data_file)[:attachment]
  end
end
