# frozen_string_literal: true

require 'json'

module FriendlyShipping
  module Services
    class ShipEngine
      class ParseCarrierResponse
        def initialize(response:)
          @response = response
        end

        def call
          parsed_json = JSON.parse(@response.body)
          parsed_json['carriers'].map do |carrier_data|
            carrier = FriendlyShipping::Carrier.new(
              id: carrier_data['carrier_id'],
              name: carrier_data['friendly_name'],
              code: carrier_data['carrier_code'],
              balance: carrier_data['balance'],
              data: carrier_data
            )

            carrier_data['services'].each do |method_hash|
              shipping_method = parse_shipping_method(carrier, method_hash)
              carrier.shipping_methods << shipping_method
            end

            carrier
          end
        end

        private

        def parse_shipping_method(carrier, shipping_method_data)
          FriendlyShipping::ShippingMethod.new(
            carrier: carrier,
            name: shipping_method_data["name"],
            service_code: shipping_method_data["service_code"],
            domestic: shipping_method_data["domestic"],
            international: shipping_method_data["international"],
            multi_package: shipping_method_data["is_multi_package_supported"]
          )
        end
      end
    end
  end
end
