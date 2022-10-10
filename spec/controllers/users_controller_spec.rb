require "rails_helper"
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  let(:user_1) { FactoryBot.create(:user) }

  describe "GET #show" do
    before {get :show, params: params}

    context "when found user" do
      let(:params){{id: user_1.id}}
      it "should check eq user" do
        expect(assigns(:user)).to eq user_1
      end
      it "should show user" do
        expect(response).to render_template :show
      end
    end

    context "when not found user" do
      let(:params){{id: -1}}
      it "should display flash danger" do
        expect(flash[:danger]).to eq I18n.t("users.show.user_invalid")
      end
      it "should redirect to home" do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #new" do
    before {get :new}

    it "should create new user" do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe "GET #create" do
    before {post :create, params: params}

    context "when user save successfully" do
      let(:params){{user: {name: "tuyen", email: "tuyen@example.com", password: "123456", password_confirmation: "123456"}}}
      it "should display flash success" do
        expect(flash[:info]).to eq I18n.t("users.create.signup_success")
      end
      it "should show user" do
        expect(response).to redirect_to User.last
      end
    end

    context "when user save fails" do
      let(:params){{user: {name: "", email: "@example.com", password: "", password_confirmation: ""}}}
      it "should display flash danger" do
        expect(flash[:danger]).to eq I18n.t("users.create.signup_fail")
      end
      it "should render new user" do
        expect(response).to render_template :new
      end
    end
  end
end
