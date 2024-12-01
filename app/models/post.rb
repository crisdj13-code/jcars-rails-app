class Post < ApplicationRecord
  belongs_to :car
  validates_presence_of :title
  has_rich_text :content
  has_many_attached :images
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :car 
end
