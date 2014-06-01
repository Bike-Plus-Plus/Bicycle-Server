require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = {
    :record => :once,
    :allow_playback_repeats => true,
    :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:apiKey) ]
  }
  c.default_cassette_options[:record] = :new_episodes
  c.ignore_localhost = true
  c.configure_rspec_metadata!
end
