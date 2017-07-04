class ProcessorsController < ApplicationController
  def index
    @processors = Processor.all
  end

  def new
    @processor = Processor.new
  end

  def create
    Processor.create(processor_params)
    redirect_to :processors
  end

  def edit
    @processor = Processor.find(params[:id])
  end

  def update
    @processor = Processor.find(params[:id])
    if @processor.update(processor_params)
      redirect_to :processors
    else
      render :edit
    end
  end

  def destroy
    @processor = Processor.find(params[:id])
    @processor.destroy
    redirect_to :processors
  end

  private

  def processor_params
    params.require(:processor).permit(:name, :source, :processor_class)
  end
end
