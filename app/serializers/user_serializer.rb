class UserSerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :first_name, :last_name, :email

  has_one :current_route

end
