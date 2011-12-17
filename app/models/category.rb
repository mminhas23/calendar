class Category < ActiveRecord::Base
  validates_presence_of :code, :description
  validates_uniqueness_of :code, :description
  has_many :courses, :dependent => :destroy
end
