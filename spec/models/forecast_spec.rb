require 'rails_helper'

RSpec.describe Forecast, type: :model do
  it 'returns errors for missing attributes' do
    forecast = Forecast.new
    expect(forecast.valid?).to be(false)
    expect(forecast.errors[:temperature]).to be_present
    expect(forecast.errors[:short]).to be_present
    expect(forecast.errors[:icon]).to be_present
    expect(forecast.errors[:number]).to be_present
    expect(forecast.errors[:temperature_unit]).to be_present
    expect(forecast.errors[:start_time]).to be_present
    expect(forecast.errors[:end_time]).to be_present
  end

  it 'finds recent forecasts for a given zip code' do
    location = FactoryBot.create(:location)
    FactoryBot.create(:forecast, location:, created_at: 45.minutes.ago)
    FactoryBot.create(:forecast, location:, created_at: 15.minutes.ago)
    FactoryBot.create(:forecast, location:)

    expect(Forecast.by_zip_from_last_half_hour(location.postal_code).length).to eq(2)
  end
end
