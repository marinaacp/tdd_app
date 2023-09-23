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
      render :new
    end
  end

  private

  def new_land_params
    params.require(:magical_land).permit(:name, :universe, :secret_code, :avatar, :deadly)
  end
end
