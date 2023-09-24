class MagicalLandsController < ApplicationController
  before_action :set_magical_land, only: [:edit, :update, :show, :destroy]

  def index
    @magical_lands = MagicalLand.all
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
    #
  end

  def edit
    #
  end

  def update
    if @magical_land.update!(new_land_params)
      redirect_to magical_land_path(@magical_land.id), notice: "New land updated with success"
    else
      redirect_to edit_magical_land_path(@magical_land.id), notice: "Error updating the magical land"
    end
  end

  def destroy
    if @magical_land.destroy
      redirect_to magical_lands_path, notice: "Magical land deleted successfully"
    else
      redirect_to magical_land_path(@magical_land.id), notice: "Unable to deleted magical land"
    end
  end

  private

  def set_magical_land
    @magical_land = MagicalLand.find(params[:id])
  end

  def new_land_params
    params.require(:magical_land).permit(:name, :universe, :secret_code, :picture, :deadly)
  end
end
