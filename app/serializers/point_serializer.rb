class PointSerializer < ActiveModel::Serializer

  embed :ids
  attributes :latitude, :longitude

  has_one :route
  has_one :user

  def latitude
    object.point.y
  end

  def longitude
    object.point.x
  end

end