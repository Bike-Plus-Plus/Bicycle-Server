class BaseRouteSerializer < ActiveModel::Serializer
  attributes :id, :start_latitude, :start_longitude, :current_latitude, :current_longitude, :end_latitude, :end_longitude, :in_progress, :finished

  def start_longitude
    object.start_point.x
  end

  def start_latitude
    object.start_point.y
  end

  def end_longitude
    object.end_point.x
  end

  def end_latitude
    object.end_point.y
  end

  def current_longitude
    object.current.x
  end

  def current_latitude
    object.current.y
  end

end