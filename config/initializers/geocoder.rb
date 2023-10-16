Geocoder.configure(
  http_headers: { 'User-Agent' => 'Weather Forecast' }
)

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

  Geocoder::Lookup::Test.add_stub(
    'zzzzzzzzzz', []
  )
end
