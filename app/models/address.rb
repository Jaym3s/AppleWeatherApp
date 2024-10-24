class Address
  include ActiveModel::API

  attr_accessor :address_string
  attr_accessor :parsed_address

  delegate :postal_code, to: :parsed_address

  def parsed_address
    @parsed_address ||= StreetAddress::US.parse(address_string)
  end

  def postal_code
    parsed_address.try(:postal_code)
  end

  # This is a basic level validation to conform to active record's patterns.
  # Eventually we'll want a 3rd party address lookup to validate and correct
  # any entered address here.
  def valid?
    postal_code.present?
  end
end
