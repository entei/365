require 'spec_helper'
include Devise::TestHelpers

describe EventsController do
  describe 'show action' do
    it "render template if event is found" do
      user = FactoryGirl.create(:user)
      sign_in user
      event = FactoryGirl.create(:event, user: user)

    end
  end
    
  describe 'create action' do
    before do
      user = FactoryGirl.create(:user)
      sign_in user
    end
        
    it 'redirect to calendar if event has been created' do
      post :create, event: {name: 'Event', start_at: Time.current, end_at: Time.current}, guests: {email: ""}
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
    let(:user){ FactoryGirl.create(:user) }
    let(:event){ FactoryGirl.create(:event, user: user) }
        
    before do
      sign_in user
    end
  
    it 'redirect to calendar path if successfully updated' do
      put :update, id: event.id, event: {name: "valid_name"}, guests: {email: ""}
      expect(response).to redirect_to calendar_path
    end
        
    it 'render edit if event not pass validation' do
      put :update, id: event.id, event: {name: nil}
      expect(response).to render_template('edit')
    end
        
    it "should pass params to menu item" do
      put :create, id: event.id, event: {name: 'Event123' }
      expect(assigns[:event].name).to eq('Event123')
    end
        
  end
end