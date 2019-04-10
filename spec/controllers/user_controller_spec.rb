require "rails_helper"

RSpec.describe UsersController, type: :controller do
  context "when current user is admin" do
    login_admin
    it "should have a current_user" do
      expect(subject.current_user).to_not eq nil
    end

    describe "PUT users#update" do
      let(:user){FactoryBot.attributes_for :user}
      before {@user = FactoryBot.create :user, name: "Nhattien", email: "nhattien2307@gmail.com", password:"123456", role: "user"}

      it "located the requested @user" do
        put :update, params: {id: @user.id}, format: :js
        expect(assigns(:user)).to eq(@user)
      end
      it "changes @user attributes" do
        put :update, params: {id: @user,
          user: FactoryBot.attributes_for(:user, role: "admin")}, format: :js
        @user.reload
        @user.role.should eq("admin")
      end
      it "redirects to admin_users_path" do
        put :update, params: {id: @user,
          user: FactoryBot.attributes_for(:user, role: "admin")}, format: :js
        expect(response).to redirect_to request.referrer
      end
    end

    describe "DELETE users#destroy" do
      let!(:user){FactoryBot.create :user}

       context "valid attributes" do
        it "deletes the user" do
          expect{delete :destroy, params: {id: user}}
          .to change(User, :count).by -1
        end

        it "flash success message" do
          delete :destroy, params: {id: user}
          expect(flash[:success]).to match(I18n.t "user.deleted")
        end

        it "redirect to users_path" do
          delete :destroy, params: {id: user}
          expect(response).to redirect_to users_path
        end
      end
    end
  end

  context "when current user is user" do
    login_user
    it "should have a current_user" do
      expect(subject.current_user).to_not eq nil
    end

    describe "GET #index" do
      let(:user){FactoryBot.create :user}

      it "populates an array of users" do
        get :index
        expect(assigns(:users)).to include(user)
      end

      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end

    describe "GET #show" do
      let(:user){FactoryBot.create :user}

      it "assigns the requested user to @user" do
        get :show, params: {id: user}
        assigns(:user).should eq(user)
      end

      it "renders the #show view" do
        get :show, params: {id: user}
        response.should render_template :show
      end
    end
  end
end
