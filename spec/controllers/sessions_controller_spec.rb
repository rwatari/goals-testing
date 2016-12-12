require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { User.create!(username: "Munchkin", password: "password") }

  describe "GET #new" do
    it "renders the new page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's username and password" do
        post :create, user: { username: "Munchkin", password: ""}
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "validates the presence of the user's username and password" do
        post :create, user: { username: "Munchkin", password: "password" }
        expect(response).to redirect_to(user_url(user))
      end
    end
  end

  describe "POST #destroy" do
    before(:each) do
      post :create, user: { username: "Munchkin", password: "password" }
    end

    it "redirects to the new session page" do
      post :destroy
      expect(response).to redirect_to(new_session_url)
    end

    it "resets the session token" do
      user = User.find_by_credentials("Munchkin", "password")
      old_token = user.session_token
      post :destroy
      user = User.find_by_credentials("Munchkin", "password")
      expect(user.session_token).not_to eq(old_token)
      expect(session[:session_token]).to be nil
    end
  end
end
