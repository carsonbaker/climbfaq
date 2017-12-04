class Comment < ActiveRecord::Base
  
  belongs_to :faq
  
  validates :body, :presence => true
  
end
