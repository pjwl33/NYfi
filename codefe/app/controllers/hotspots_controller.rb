class HotspotsController < ApplicationController

  before_action :authenticate, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :authorization, only: [:edit, :yelpsync]

  def index
    @hotspots = Hotspot.all.shuffle
    #.paginate(page: params[:page], per_page: 42).order(name: :asc)
    @show_link = true
    respond_to do |format|
      format.html
      format.json {render json: @hotspots.to_json}
    end
  end

  def show
    @hotspot = Hotspot.find params[:id]
    respond_to do |format|
      format.html
      format.json {render json: @hotspot.to_json}
    end
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
    if @hotspot.update hotspot_params
      redirect_to @hotspot
    else
      flash[:notice] = "You need to be an admin to do that!"
      redirect_to @hotspot
    end
  end
  #this will destroy all related comments as well
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
    #the searchform by different parameters
  end
  #search by different parameters

  #HOW would I dry this up some more for 4 separte form_tags, since they all have slightly different logic?
  def search
    @hotspots = Hotspot.search(params[:name_query], params[:location_query], params[:rating_query], params[:wifi_query])
  end


  #syncing (updating) yelp ratings and img_url
  def yelpsync
    Hotspot.yelpsync
    redirect_to user_path(current_user)
    flash[:notice] = "Updated with Yelp"
  end

  private
  def hotspot_params
    params.require(:hotspot).permit :name, :address, :yelp_rating, :biz_url, :img_url, :wifi_type, :phone
  end

end
