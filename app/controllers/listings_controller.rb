class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_form_vars, only: [:new, :edit]

  def index
    @listings = Listing.all
  end

  def show

  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to @listing, notice: "You have successfully listed your food!"
    else
      set_form_vars
      render "new", alert: "something went wrong :( "
    end
  end

  def edit
  
  end

  def update
    @listing.update(listing_params)
    if @listing.save
      redirect_to @listing, notice: "Your food listing has now been updated"
    else
      set_form_vars
      render "edit", alert: "something went wrong :( "
    end
  end 

  def destory

  end

  private

  def listing_params
    params.require(:listing).permit(:title, :price, :category_id, :description)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def set_form_vars
    @categories = Category.all
  end

end

