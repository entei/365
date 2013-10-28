# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  event_id   :string(255)
#  integer    :string(255)
#  guest_id   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Invitation do
  let(:owner) { FactorGirl.create(:user) }
  let(:guest) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }
  let(:invitation) { event.invitations.build(guest_id: guest.id) }
  
  subject { invitation }
  
  describe 'guests' do
    it { should respond_to (:guest) }
    it { should respond_to (:event) }
  end
  
  describe "when guest is not present" do
    before { invitation.guest_id = nil }
    it { should_not be_valid }
  end
  
  describe "when event is not present" do
    before { invitation.event_id = nil }
    it { should_not be_valid }
  end
end
