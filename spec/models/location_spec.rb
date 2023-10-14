require 'rails_helper'

RSpec.describe Location, type: :model do
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

  it 'geocodes a location object' do
    location = Location.create(address: '1 Infinite Loop Cupertino, CA 95014')

    expect(location.latitude).to be_present
    expect(location.longitude).to be_present
    expect(location.postal_code).to be_present
  end
end
