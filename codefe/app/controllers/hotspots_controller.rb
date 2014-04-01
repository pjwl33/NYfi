class HotspotsController < ApplicationController

  before_action :authenticate, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :authorization, only: [:edit, :destroy]

  def index
    @hotspots = Hotspot.all.paginate(page: params[:page], per_page: 25).order(name: :asc)
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
    if admin?
      @hotspot = Hotspot.find params[:id]
    else
      flash[:notice] = "You need to be an admin to do that!"
      redirect_to root_path
    end
  end

  def update
    @hotspot = Hotspot.find params[:id]
    if admin?
      @hotspot.update hotspot_params
      redirect_to @hotspot
    else
      flash[:notice] = "You need to be an admin to do that!"
      redirect_to @hotspot
    end
  end

  def destroy
    @hotspot = Hotspot.find params[:id]
    if admin?
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
      @hotspots = Hotspot.all conditions: ['name LIKE ?', "#{params[:name_query].capitalize}%"]
    elsif params[:location_query]
      @hotspots = Hotspot.all conditions: ['address LIKE ?', "%#{params[:location_query]}%"]
    elsif params[:rating_query]
      @hotspots = Hotspot.all conditions: {yelp_rating: params[:rating_query]}
    elsif params[:wifi_query]
      @hotspots = Hotspot.all conditions: {wifi_type: params[:wifi_query]}
    else
      flash[:notice] = "My bad - couldn't find that Hotspot!"
      redirect_to hotspots_path
    end
  end

  def yelpsync
    if admin?
      Hotspot.all.each do |hs|
        if hs.yelp_rating == nil && hs.img_url == nil
          hs.update({
          yelp_rating: hs.yelp_search[0],
          img_url: hs.yelp_search[1]
          })
        end
      end
    end
  end

  private
  def hotspot_params
    params.require(:hotspot).permit :name, :address, :yelp_rating, :biz_url, :img_url, :wifi_type, :phone
  end

end
