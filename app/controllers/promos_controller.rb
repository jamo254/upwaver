class PromosController < ApplicationController
  protect_from_forgery except: [:upload_photo]
  before_action  :authenticate_user!, except: [:show]
  before_action  :set_promo, except: [:new, :create]
  #this should come first
  before_action  :is_authorized, only: [:edit, :update, :upload_photo, :delete_photo]
  before_action  :set_step, only: [:update, :edit]

  # Show all promos categories
  def show
     @categories = Category.all
  end

  def new
    @promo = current_user.promos.build
    @categories = Category.all
  end

  # Create new Promo
  def create
    @promo = current_user.promos.build(promo_params)

    if @promo.save
      @promo.pricings.create(Pricing.pricing_types.values.map{ |x| {pricing_type: x}})
      redirect_to edit_promo_path(@promo), notice: "Saving..."
    else
      redirect_to request.referrer, flash: {error:@promo.errors.full_messages}
    end
  end

  # Editing Promo
  def edit
     @categories = Category.all
     @step = params[:step].to_i
  end

  # Updating the Promos

  def update
    if @step == 2
      promo_params[:pricings_attributes].each do |index, pricing|
        if @promo.has_single_pricing && pricing[:pricing_type] != Pricing.pricing_types.key(0)
          next;
        else
          if pricing[:title].blank? || pricing[:description].blank? || pricing[:delivery_time].blank? || pricing[:price].blank?
             return redirect_to request.referrer, flash: {error: "Invalid pricing"}
          end
        end
      end
    end
    if @step == 3 && promo_params[:description].blank?
       return redirect_to request.referrer, flash: {error: "Description cannot be blank"}
    end
  # Step 4 Update
    if @step == 4 && @promo.photos.blank?
       return redirect_to request.referrer, flash: {error: "You  don't have any photos"}
    end

    if @step == 5
       @promo.pricings.each do |pricing|
         if @promo.has_single_pricing && pricing.basic?
           next;
         else
           if pricing[:title].blank? || pricing[:description].blank? || pricing[:deliverey_time].blank? || pricing[:price].blank?
             return redirect_to edit_promo_path(@promo, step: 2), flash: {error: "Invalid pricing"}
           end
         end
        end
       if @promo.description.blank?
         return redirect_to  edit_promo_path(@promo, step: 3), flash: {error: "The Description cannot be blank"}
       elsif @promo.photos.blank?
         return redirect_to  edit_promo_path(@promo, step: 4), flash: {error: "You don't have any photos"}
       end
    end

    if @promo.update(promo_params)
      flash[:notice] = "Saved..."

    else
      return redirect_to  request.referrer, flash: {error: @promo.errors.full_messages}
    end

    if @step < 5
      redirect_to edit_promo_path(@promo, step: @step + 1)
    else
      redirect_to dashboard_path
    end
  end

  # Uploading photos
  def upload_photo
    @promo.photos.attach(params[:file])
    render json: { success: true}
  end

  # Delete photos
  def delete_photo
    @image = ActiveStorage::Attachment.find(params[:photo_id])
    @image.purge
    redirect_to edit_promo_path(@promo, step: 4)
  end

  private

  def set_step
    @step = params[:step].to_i > 0 ? params[:step].to_i : 1
    if @step > 5
       @step = 5
    end
  end
  #Editing the Promo
  # Promo's params
  def set_promo
    @promo = Promo.find(params[:id])
  end
  # Restricting certain users
  def is_authorized
     redirect_to root_path, alert: "You are not alloweed to view this page" unless current_user.id == @promo.user_id
  end
  # Promos required params
  def promo_params
     #params.require(:promo).permit(:title, :video, :active, :category_id, :has_single_pricing, pricings_attribute: (:id, :title, :deliverey_time, :price, :price_type))
     params.require(:promo).permit(:title, :video, :description,  :active, :category_id, :has_single_pricing, pricings_attributes: [:id, :title, :description, :delivery_time, :price, :price_type])
  end
  
end
