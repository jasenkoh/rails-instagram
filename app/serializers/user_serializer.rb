class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar, :following

  def avatar
    object.avatar.url(:thumb)
  end

  def following
    @options[:user].following?(object) if @options[:user]
  end

end
