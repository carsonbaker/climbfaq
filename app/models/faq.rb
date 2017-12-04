class Faq < ApplicationRecord

  has_many :references
  has_many :comments

  acts_as_list scope: [:category]
  
  accepts_nested_attributes_for :references
  
  before_save :make_invisible
  
  extend FriendlyId
  friendly_id :title, :use => :slugged
  
  def make_invisible
    if body.blank?
      self[:hidden] = true
    end
  end
  
  def self.categories
    select(:id).order("id asc").select(:category).pluck(:category).uniq
  
    # self.uniq.select(:category).map(&:category)
    # select("distinct category").map(&:category)
  end
  
  def web_references
    references.where.not(:web_url => nil)
  end
  
  def youtube_references
    references.where.not(:youtube_url => nil)
  end
  
  def image_references
    references.where.not(:image => nil)
  end
  
end
