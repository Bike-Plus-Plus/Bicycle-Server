class RouteProximityQuery
  def initialize(route)
    @route = route
  end

  attr_reader :route

  def start
    @start ||= route.current
  end

  def end
    @end ||= route.end
  end

  def angle
    @angle ||= Route.select('ST_Azimuth(routes.current, routes.end) AS angle').where(:id => route.id).first.angle
  end

  def distance_in_meters
    MAX_MILES * METERS_IN_A_MILE
  end

  def max_angle_diff
    MAX_ANGLE_DIFF
  end

  def angle_diff
    %{ ABS ( DEGREES ( %s - ST_Azimuth(routes.current, routes.end))) AS angle_diff } % [ angle ]
  end

  def close_by
    %{
      ST_DWithin(
        ST_GeographyFromText(
          'SRID=4326;' || ST_AsText(routes.current)
        ),
        ST_GeographyFromText('SRID=4326;%s'),
        %d
      )
    } % [start, distance_in_meters]
  end

  def on_same_direction
    %{ angle_diff <= %s } % [ max_angle ]
  end

  def start_range
    %{ %s / %s AS start_range} % [distance_start, METERS_IN_A_MILE]
  end

  def distance_start
    %{
      ST_Distance(routes.current, ST_GeographyFromText('SRID=4326;%s'))
    } % self.current
  end

  def end_range
    %{ %s / %s AS end_range} % [distance_end, METERS_IN_A_MILE]
  end

  def distance_end
    %{
      ST_Distance(routes.end, ST_GeographyFromText('SRID=4326;%s'))
    } % self.end
  end

  def select
    Route.select("*").select(start_range).select(end_range).select(angle_diff)
  end

  def select_where
    select.where(close_by).where(on_same_direction)
  end

  def routes
    select_where.order_by("end_range ASC")
  end

end