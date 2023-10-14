require 'rails_helper'

RSpec.describe Location, type: :model do
  it 'geocodes a location object and noramlizes address' do
    location = Location.create(inputted_address: '1 Infinite Loop Cupertino, CA 95014')

    expect(location.latitude).to be_present
    expect(location.longitude).to be_present
    expect(location.postal_code).to be_present
    expect(location.inputted_address).to be_present
    expect(location.normalized_address).to eq('Apple Infinite Loop, 1, Infinite Loop, Apple Campus, Cupertino, Santa Clara County, California, 95014, United States')
  end
end
