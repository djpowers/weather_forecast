class Location < ApplicationRecord
  geocoded_by :address do |obj, results|
    if (geo = results.first)
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
      obj.postal_code = geo.postal_code
    end
  end
  after_validation :geocode
end
