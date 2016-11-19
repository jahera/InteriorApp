class Image < ActiveRecord::Base
  
  mount_uploader :file, FileUploader
  
  belongs_to :user
  CATEGORIES= ["Bath Room", "Bed Room" , "Drawing room" , "Office" , "Kitchen", "Exterior" , "Kids Room"]
end
