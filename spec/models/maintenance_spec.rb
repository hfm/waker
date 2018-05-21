require 'rails_helper'

RSpec.describe Maintenance, type: :model do
  let(:topic) { create(:topic) }

  describe 'scope' do
    let(:maintenance) { create(:maintenance, start_time: Time.now, end_time: Time.now + 1) }

    describe 'active' do
      subject { Maintenance.active }
      it { is_expected.to include maintenance }
    end

    describe 'not_expired' do
      subject { Maintenance.not_expired }
      it { is_expected.to include maintenance }
    end

    describe 'expired' do
      subject { Maintenance.expired }
      it { is_expected.not_to include maintenance }
    end
  end
end
