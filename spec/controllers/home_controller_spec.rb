require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    before { controller.stub(:authenticate_user!).and_return true }
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
