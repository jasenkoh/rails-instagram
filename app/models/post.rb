class Post < ActiveRecord::Base
  validates_presence_of [:caption, :image]
  has_attached_file :image, styles: { medium: '640x', small: '320px', thumb: '300x200#' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :user
end
