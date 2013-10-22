require 'spec_helper'
include Devise::TestHelpers

describe EventsController do
    describe 'show action' do
        it "render template if event is found" do
            user = FactoryGirl.create(:user)
            sign_in user
            event = FactoryGirl.create(:event)
            user.events << event
            get :show, id: event.id
            expect(response).to render_template('show') 
        end
    end
    
    describe 'create action' do
        before do
          user = FactoryGirl.create(:user)
          sign_in user
        end
        
        it 'redirect to calendar if event has been created' do
        #   event = FactoryGirl.create(:event)
            post :create, event: {name: 'Event', start_at: Time.current, end_at: Time.current}
            expect(response).to redirect_to calendar_path
        end
        
        it 'render new event if event not valid' do
            post :create, event: {name: nil, start_at: Time.current, end_at: Time.current}
            expect(response).to render_template('new')
        end
        
        it "should pass params" do
            post :create, event: {name: 'Event123' }
            expect(assigns[:event].name).to eq('Event123')
        end
    end
    
    describe 'new action' do
        it 'render new event page' do 
            user = FactoryGirl.create(:user)
            sign_in user
            get :new
            expect(response).to render_template('new')
        end
    
    end
    
    describe 'update action' do
        before do
          @event = FactoryGirl.create(:event)
          user = FactoryGirl.create(:user)
          sign_in user
          user.events << @event
        end
  
        it 'redirect to calendar path if successfully updated' do
            put :update, id: @event.id, event: {name: "valid_name"}
            expect(response).to redirect_to calendar_path
        end
        
        it 'render edit if event not pass validation' do
            put :update, id: @event.id, event: {name: nil}
            expect(response).to render_template('edit')
        end
        
        it "should pass params to menu item" do
            put :create, id: @event.id, event: {name: 'Event123' }
            expect(assigns[:event].name).to eq('Event123')
        end
        
    end
end