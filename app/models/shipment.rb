class Shipment < ActiveRecord::Base
  belongs_to :order

  VALID_CARRIERS = %w(fedex usps ups).freeze

  validates :shipping_carrier, inclusion: {
    in: VALID_CARRIERS,
    message: "%{value} is not a valid shipping carrier"
  }

  def tracking_url
    case shipping_carrier.to_sym
    when :ups
      "https://wwwapps.ups.com/WebTracking/track?track=yes&trackNums=#{tracking_number}&loc=en_us"
    when :usps
      "https://tools.usps.com/go/TrackConfirmAction.action?tRef=fullpage&tLc=1&text28777=&tLabels=#{tracking_number}"
    when :fedex
      "https://www.fedex.com/apps/fedextrack/?tracknumbers=#{tracking_number}"
    end
  end
end
