class HotspotsController < ApplicationController

  def index
    @hotspots = Hotspot.all.paginate(page: params[:page], per_page: 35).order(name: :asc)
    @show_link = true
  end

  def show
    @hotspot = Hotspot.find params[:id]
    @comment = Comment.new params[:comment]
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

  def searchform
  end

  def search
    if params[:name_query]
      @hotspots = Hotspot.all conditions: ['name LIKE ?', params[:name_query].capitalize]
    elsif params[:location_query]
      @hotspots = Hotspot.all conditions: ['address LIKE ?', params[:location_query]]
    elsif params[:rating_query]
      @hotspots = Hotspot.all conditions: {yelp_rating: params[:rating_query]}
    elsif params[:wifi_query]
      @hotspots = Hotspot.all conditions: {wifi_type: params[:wifi_query]}
    else
      flash[:notice] = "My bad - couldn't find that Hotspot!"
      redirect_to hotspots_path
    end
    @hotspots.paginate(page: params[:page], per_page: 15).order(name: :asc)
  end

  private
  def hotspot_params
    params.require(:hotspot).permit :name, :address, :cross_street, :hood, :biz_url, :img_url, :type, :power, :status, :dl_speed, :ul_speed, :yelp_rating, :noise_level, :good_for_kids
  end

end
