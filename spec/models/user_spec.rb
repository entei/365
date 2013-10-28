# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  nickname               :string(255)
#  provider               :string(255)
#  url                    :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  timezone               :string(255)
#

require 'spec_helper'

describe User do
  let(:user){ FactoryGirl.create(:user) }

    it "has events" do
        expect(user).to respond_to(:events)
        expect(user).to respond_to(:invitations)
        expect(user).to respond_to(:shared_events)
    end
    
    it "email should be valid" do
        user.email = 'user@foo,com'
        expect(user).to_not be_valid
        user.email = 'user_at_foo.org'
        expect(user).to_not be_valid
        user.email = 'example.user@foo.'
        expect(user).to_not be_valid
        user.email = 'foo@bar_baz.com'
        expect(user).to_not be_valid
        user.email = 'foo@bar+baz.com'
        expect(user).to_not be_valid
    end
       
    describe "event associations" do
        let(:user){ FactoryGirl.create(:user) }
        
        it "upcoming events orders by start date" do
            event1 = FactoryGirl.create(:event, user: user, start_at: 10.days.from_now, end_at: 11.days.from_now ) 
            event2 = FactoryGirl.create(:event, user: user, start_at: 5.days.from_now, end_at: 6.days.from_now ) 
            event3 = FactoryGirl.create(:event, user: user, start_at: 4.days.from_now, end_at: 5.days.from_now ) 
            expect(user.upcmng_e).to  eq([event3, event2, event1])
        end
        
        it "today_events should contain today events" do
            event2 = FactoryGirl.create(:event, user: user, start_at: 5.days.from_now, end_at: 6.days.from_now ) 
            event4 = FactoryGirl.create(:event, user: user, start_at: Time.current, end_at: 5.days.from_now ) 
            expect(user.today_events).to eq([event4])
        end
        
        it "upcoming events" do
            event1 = FactoryGirl.create(:event, user: user, start_at: 10.days.from_now, end_at: 11.days.from_now ) 
            event2 = FactoryGirl.create(:event, user: user, start_at: 5.days.from_now, end_at: 6.days.from_now ) 
            event3 = FactoryGirl.create(:event, user: user, start_at: 4.days.from_now, end_at: 5.days.from_now ) 
            event4 = FactoryGirl.create(:event, user: user, start_at: 10.days.from_now, end_at: 11.days.from_now ) 
            event5 = FactoryGirl.create(:event, user: user, start_at: 5.days.from_now, end_at: 6.days.from_now ) 
            event6 = FactoryGirl.create(:event, user: user, start_at: 4.days.from_now, end_at: 5.days.from_now )
            event7 = FactoryGirl.create(:event, user: user, start_at: 4.days.from_now, end_at: 5.days.from_now )
            expect(user.upcmng_e.count).to eq(3)
        end
        
        it "today left events are not today_events" do
            event = FactoryGirl.create(:event, user: user, start_at: Time.current - 2.hour, end_at: Time.current - 1.hour) 
            expect(user.today_events).not_to eq([event])
        end
        
        it "left events should contain left events" do
            event = FactoryGirl.create(:event, user: user, start_at: Time.current + 3.days, end_at: Time.current + 3.day) 
            event2 = FactoryGirl.create(:event, user: user, start_at: Time.current + 2.day, end_at: Time.current + 2.day) 
            event3 = FactoryGirl.create(:event, user: user, start_at: Time.current + 1.day, end_at: Time.current + 1.day) 
      
            expect(user.events_left).to eq([event, event2, event3])
        end
 
        it "today_events should contain events that will be today" do
            event = FactoryGirl.create(:event, user: user, start_at: Time.current + 2.hour, end_at: Time.current + 10.hour) 
    
            expect(user.events).to eq([event])
        end
        
        it "left events should not contain past events" do
            event1 = FactoryGirl.create(:event, user: user, start_at: Time.current - 3.days, end_at: Time.current - 3.day) 
            event2 = FactoryGirl.create(:event, user: user, start_at: Time.current - 3.days, end_at: Time.current - 3.day) 
        
            expect(user.events_left).not_to eq([event1, event2])
        end   
    
    end
 
end
