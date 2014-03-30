class HotspotsController < ApplicationController

  def index
    @hotspots = Hotspot.all.paginate(page: params[:page], per_page: 35).order(name: :asc)
    @show_link = true
  end

  def show
    @hotspot = Hotspot.find params[:id]
  end

  def new
    @hotspot = Hotspot.new
  end

  def create
    @hotspot = Hotspot.create hotspot_params
    redirect_to @hotspot
  end

  def edit
    @hotspot = Hotspot.find params[:id]
  end

  def update
    @hotspot = Hotspot.find params[:id]
    if current_user.admin?
      @hotspot.update hotspot_params
      redirect_to @hotspot
    else
      flash[:notice] = "You need to be an admin to do that!"
      redirect_to @hotspot
    end
  end

  def destroy
    @hotspot = Hotspot.find params[:id]
    if current_user.admin?
      @hotspot.destroy
      redirect_to hotspots_path
    else
      flash[:notice] = "You need to be an admin to do that!"
      redirect_to hotspots_path
    end
  end

  private
  def hotspot_params
    params.require(:hotspot).permit :name, :address, :cross_street, :hood, :biz_url, :img_url, :type, :power, :status, :dl_speed, :ul_speed, :yelp_rating, :noise_level, :good_for_kids
  end

end
