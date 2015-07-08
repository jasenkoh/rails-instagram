class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #
  validates_presence_of :username
  validates_uniqueness_of :username

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: 'https://s3-us-west-2.amazonaws.com/assets.paperclip/missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :posts, foreign_key: 'user_id'

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # follow a user
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  # unfollow user
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  # returns true if currently following the user
  def following?(user)
    following.include?(user)
  end
end
