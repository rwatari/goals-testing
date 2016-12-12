require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the new page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's usernaame and password" do
        post :create, user: { username: "Munchkin", password: ""}
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end
    context "with valid params" do
      it "validates the presence of the user's usernaame and password" do
        post :create, user: { username: "Munchkin", password: "password"}
        expect(response).to redirect_to(user_url(User.find_by_credentials("Munchkin", "password")))
      end
    end
  end
end
