class Category < ActiveRecord::Base
  validates :code,  :presence => true
  validates :description,  :presence => true
  has_many :courses, :dependent => :destroy
end
