class Reference < ApplicationRecord
  belongs_to :faq
  
  mount_uploader :image, ReferenceUploader

end
