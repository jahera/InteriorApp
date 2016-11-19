class HomeController < ApplicationController
  
  #  layout :application
  
  def index
    @images = Image.all.group("category")
  end
  
  #open new video view page
  def new_file
    @image = Image.new(params[:image])
  end
  
  #save new video
  def filecreate
    begin
      @video = current_user.images.create!(params_image)
      flash[:notic] = "Image upload has been save successfully."
    rescue Exception => e
      p "Image upload is not save successfully.Please try again! Error -> #{e.message}"
      flash[:alert] = "Image upload is not save successfully.Please try again! Error -> #{e.message}"
    end
    redirect_to new_file_home_index_path
  end
  
  def details
    @images = Image.where(:category=> params[:category])
  end
  
  def contact_us
    
    if request.post?
      @contact= ContactU.new(contact_params)
      begin
        @contact.save!
        if @contact.present?
          name = params[:contact_us][:name]
          email = params[:contact_us][:email]
          phone = params[:contact_us][:phone]
          info = params[:contact_us][:info]
#          PerentsMailer.email_us(@contact).deliver_now
        end
        flash[:notice] = "Thank you for giving us your time. We will contact you very soon."
      rescue Exception => e
        flash[:alert] = "Contact email cannot be sent.Please try again! Error -> #{e.message}"
        p "--------------------------------   #{e.message}"
        
      end
      redirect_to contact_us_home_index_path
    end
    if current_user.present?
      @contacts= ContactU.all      
    end
    
  end
  
  def about
    
  end
  
  private
  
  def params_image
    params.require(:image).permit!
  end

  def contact_params
    params.require(:contact_us).permit(:name,:email,:phone,:info)
  end
  
end
