require 'spec_helper'

RSpec.describe FriendlyShipping::Services::ShipEngine do
  subject(:service) { described_class.new(token: ENV['SHIPENGINE_API_KEY']) }

  it { is_expected.to respond_to(:carriers) }

  describe 'initialization' do
    it { is_expected.not_to respond_to :token }
  end

  describe 'carriers' do
    subject { service.carriers }

    context 'with a successful request', vcr: { cassette_name: 'shipengine/carriers/success.yml' } do
      it { is_expected.to be_a Dry::Monads::Result }
    end
  end
end