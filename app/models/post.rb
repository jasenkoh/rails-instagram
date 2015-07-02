class Post < ActiveRecord::Base
  validates_presence_of [:caption, :image]
  has_attached_file :image, styles: { medium: '640x' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
