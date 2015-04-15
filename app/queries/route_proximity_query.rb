class RouteProximityQuery
  def initialize(route)
    @route = route
  end

  attr_reader :route

  def start_point
    @start_point ||= route.current
  end

  def end_point
    @endpoint ||= route.end_point
  end

  def table
    @table ||= Route.arel_table
  end

  def angle

    @angle ||= Route.select(table[:current].st_azimuth(table[:end_point]).as('angle')).where(:id => route.id).first.angle
  end

  def distance_in_meters
    MAX_MILES * METERS_IN_A_MILE
  end

  def max_angle_diff
    MAX_ANGLE_DIFF
  end

  def angle_diff_attribute
    angle_diff.as('angle_diff')
  end

  def raw_angle_diff
    Arel::Nodes::Subtraction.new(angle,table[:current].st_azimuth(table[:end_point]))
  end

  def abs_angle_diff
    Arel::Nodes::NamedFunction.new 'ABS', [degrees_angle_diff]
  end

  def degrees_angle_diff
    Arel::Nodes::NamedFunction.new "DEGREES", [raw_angle_diff]
  end

  def angle_diff
    abs_angle_diff
  end

  def close_by
    table[:current].st_dwithin(start_point, distance_in_meters);
  end

  def on_same_direction
    Arel::Nodes::LessThanOrEqual.new(angle_diff, max_angle_diff)
  end

  def start_range
    Arel::Nodes::Division.new(distance_start, METERS_IN_A_MILE).as('start_range')
  end

  def distance_start
    table[:current].st_distance(start_point)
  end

  def end_range
    Arel::Nodes::Division.new(distance_end, METERS_IN_A_MILE).as('end_range')
  end

  def distance_end
    table[:end_point].st_distance(end_point)
  end

  def not_self
    table[:id].not_eq(route.id)
  end

  def select
    Route.select("*").select(start_range).select(end_range).select(angle_diff_attribute)
  end

  def select_where
    select.where(close_by).where(on_same_direction).where(not_self).where(:finished => false)
  end

  def routes
    select_where.order("end_range ASC")
  end

end