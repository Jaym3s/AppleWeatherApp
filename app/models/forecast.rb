class Forecast
  include ActiveModel::API
  include ActiveModel::Attributes

  attr_accessor :address

  attribute :current_temp, :string
  attribute :feels_like, :string
  attribute :today_low, :string
  attribute :today_high, :string

  def self.find(id)
    Rails.cache.read(id)
  end

  # TODO: replace with reasonable NullAddress
  def address
    @address ||= Address.new
  end

  def save
    Rails.cache.write(id, self)
  end

  def id
    address.postal_code
  end
end

