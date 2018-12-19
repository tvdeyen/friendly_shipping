require 'spec_helper'

RSpec.describe FriendlyShipping::Label do
  it { is_expected.to respond_to(:service_code) }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:shipment_id) }
  it { is_expected.to respond_to(:tracking_number) }
  it { is_expected.to respond_to(:label_href) }
  it { is_expected.to respond_to(:data) }
end