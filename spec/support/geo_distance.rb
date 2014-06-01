RSpec::Matchers.define :be_within_geographic do |_delta_|
  chain :of do |_lat_, _lon_|
    @_expected = RGeo::WKRep::WKTParser.new(RGeo::Geographic.spherical_factory,
      :support_ewkt => true).parse("POINT(#{_lon_} #{_lat_})")
  end

  match do |actual|
    unless defined?(@_expected)
      raise ArgumentError.new("You must set an expected value using #of: be_within_geographic(#{_delta_}).of(expected_value)")
    end
    unless actual.is_a?(RGeo::Feature::Point) and @_expected.is_a?(RGeo::Feature::Point)
      raise ArgumentError.new("You must provide RGeo::Feature::Point objects.")
    end
    (actual.distance(@_expected)) < _delta_
  end

  failure_message_for_should do |actual|
    "expected #{actual} to #{description}"
  end

  failure_message_for_should_not do |actual|
    "expected #{actual} not to #{description}"
  end

  description do
    "be within #{_delta_} meters of #{@_expected}"
  end
end