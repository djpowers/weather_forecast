Geocoder.configure
# Geocoding options
# timeout: 3,                 # geocoding service timeout (secs)
# lookup: :nominatim,         # name of geocoding service (symbol)
# ip_lookup: :ipinfo_io,      # name of IP address geocoding service (symbol)
# language: :en,              # ISO-639 language code
# use_https: false,           # use HTTPS for lookup requests? (if supported)
# http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
# https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
# api_key: nil,               # API key for geocoding service
# cache: nil,                 # cache object (must respond to #[], #[]=, and #del)

# Exceptions that should not be rescued by default
# (if you want to implement custom error handling);
# supports SocketError and Timeout::Error
# always_raise: [],

# Calculation options
# units: :mi,                 # :km for kilometers or :mi for miles
# distances: :linear          # :spherical or :linear

# Cache configuration
# cache_options: {
#   expiration: 2.days,
#   prefix: 'geocoder:'
# }

if Rails.env.test?
  Geocoder.configure(lookup: :test)

  Geocoder::Lookup::Test.add_stub(
    '1 Infinite Loop Cupertino, CA 95014', [
      {
        'coordinates' => [37.331405, -122.0304185],
        'address' => 'Apple Infinite Loop, 1, Infinite Loop, Apple Campus, Cupertino, Santa Clara County, California, 95014, United States',
        'state' => 'California',
        'state_code' => 'California',
        'country' => 'United States',
        'country_code' => 'us',
        'postal_code' => '95014'
      }
    ]
  )
end
