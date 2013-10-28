# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  start_at    :datetime
#  end_at      :datetime
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  color       :string(255)
#  place       :string(255)
#  important   :boolean          default(FALSE)
#  notice      :string(255)
#

require 'spec_helper'

describe Event do

    let(:event) { FactoryGirl.create(:event) }
    
    it 'should have a color' do
        expect(event.color).to_not be_nil
    end
    
    it 'important should be false by default' do
        expect(event.important).to eq(false)
    end
    
    it 'should have a user' do
        expect(event.user).to_not be_nil
    end
    
    it 'end_at should be less then start_at' do
        event = FactoryGirl.build(:event, start_at: Date.current, end_at: Date.current - 1.day)
        event.valid?
        expect(event.errors.full_messages).to include("Start at must be less then end date")
    end
    
    it 'should respond to invitations' do
        expect(event).to respond_to(:invitations)
    end
    
end
