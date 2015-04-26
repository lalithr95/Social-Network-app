class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(:created_at , :desc) } # a stabby lambda which gets called as a proc when displaying post in reseverse order of date
  validates :user_id,presence: true
  validates :content,presence: true,length: {maximum: 140}
end
