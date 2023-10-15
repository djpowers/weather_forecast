class Location < ApplicationRecord
  validates_presence_of :inputted_address
  validates_uniqueness_of :inputted_address

  geocoded_by :inputted_address do |obj, results|
    if (geo = results.first)
      obj.normalized_address = geo.address
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
      obj.postal_code = geo.postal_code
    end
  end

  after_validation :geocode, if: ->(obj) { obj.inputted_address.present? and obj.inputted_address_changed? }

  def to_param
    postal_code
  end
end
