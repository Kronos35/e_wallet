require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock # or :fakeweb
  config.allow_http_connections_when_no_cassette = true
  config.ignore_hosts(
    'localhost',
    '127.0.0.1',
    '0.0.0.0',
    'example.com',
  )
end

WebMock.disable_net_connect!(allow: [
  'example.com',
])