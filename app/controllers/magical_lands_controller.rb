class MagicalLandsController < ApplicationController
  def index
  end

  def new
    @magical_land = MagicalLand.new
  end

  def create
    @magical_land = MagicalLand.new(new_land_params)
    if @magical_land.save
      redirect_to magical_lands_path, notice: "New land successfully registered!"
    else
      redirect_to new_magical_land_path, notice: "Field can't be blank"
    end
  end

  def show
    @magical_land = MagicalLand.find(params[:id])
  end
  private

  def new_land_params
    params.require(:magical_land).permit(:name, :universe, :secret_code, :picture, :deadly)
  end
end
