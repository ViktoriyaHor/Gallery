require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create :user }
  let(:category) {create :category_with_image, user: user}
  let!(:action) { Action.create(params) }
  let(:params) { { action_type: 'navigation' } }
  context 'user sign_in' do
    login_user
    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end
    it "does not exist :edit" do
      expect{get :edit}.to raise_error(ActionController::UrlGenerationError)
    end
    it "does not exist :update" do
      expect{put :update}.to raise_error(ActionController::UrlGenerationError)
    end
    context '#index' do
      subject! { get :index }

      it 'returns a successful response to GET' do
        expect(response).to have_http_status(200)
      end
      it 'render template :index' do
        expect(response).to render_template :index
      end
      it "assigns @categories" do
        expect(assigns(:categories)).to eq([category])
      end
      context 'activity' do
        it 'action_type is "navigation"' do
          expect(LoggingUserAction.last.action.action_type).to eq('navigation')
        end

        it 'url is "http://test.host/categories"' do
          expect(LoggingUserAction.last.action_path).to eq('http://test.host/categories')
        end

        it 'record to db' do
          expect(LoggingUserAction.count).to eq(1)
        end
      end
    end

    context '#show' do
      subject! { get :show, params: { slug: category.slug } }

      it "returns success responce" do
        expect(response).to have_http_status(200)
      end
      it 'render template :show' do
        expect(response).to render_template :show
      end
      it 'receive method :find_category and return category ' do
        expect(controller).to receive(:find_category)
        get :show, params: { slug: category.slug }
      end
      it "requires the slug parameter" do
        expect { get :show }.to raise_error(ActionController::UrlGenerationError)
      end
      it "assigns @images" do
        expect(assigns(:images)).to eq([category.images.first])
      end
      context 'activity' do
        it 'action_type is "navigation"' do
          expect(LoggingUserAction.last.action.action_type).to eq('navigation')
        end

        it 'url is "http://test.host/categories/category"' do
          expect(LoggingUserAction.last.action_path).to eq("http://test.host/categories/#{category.slug}")
        end

        it 'record to db' do
          expect(LoggingUserAction.count).to eq(1)
        end
      end
    end

    context '#new' do
      subject! { get :new }
      let(:category) { double(Category) }

      before do
        allow(Category).to receive(:new).and_return(category)
      end
      it 'assigns @category variable' do
        expect(assigns(:category)).not_to be_nil
      end
      it "assigns @category" do
        expect(assigns(:category)).to be_a_new(Category)
      end
      it 'returns a successful response to GET' do
        expect(response).to have_http_status(200)
      end
      it 'render template :new' do
        expect(response).to render_template :new
      end
    end

    context "#create" do
      let(:category) { build(:category) }

      context "with valid attributes" do
        it "create a category" do
          expect(category.save!).to be true
        end
        it "redirects to the new category and sends success flash" do
          post :create, params: { category: { title: category.title } }
          expect(response).to redirect_to Category.last
        end
        it "sends success flash" do
          post :create, params: { category: { title: category.title } }
          expect(flash[:success]).to eq "Category created"
        end
      end
      context "with invalid attributes" do
        before do
          post :create, params: { category: { title: nil } }
        end
        it 'should be render new template after error' do
          expect(response).to render_template(:new)
        end
        it 'don\'t create a new category' do
          expect(Category.count).to eq(0)
        end
      end
    end

    context '#destroy' do
      context 'total response' do
        before do
          delete :destroy, params: { slug: category.slug }
        end
        it 'has a 302 status code' do
          expect(response).to have_http_status(302)
        end
        it 'should redirect to profile after remove category' do
          expect(response).to redirect_to(profile_path)
        end
        it 'receive method :find_category and return category ' do
          expect(controller).to receive(:find_category)
          delete :destroy, params: { slug: category.slug }
        end
      end
      context 'current user - owner category' do
        it 'sends success flash' do
          user = create(:user)
          category = create(:category, user: user)
          sign_in user
          delete :destroy, params: { slug: category.slug }
          expect(flash[:success]).to eq "Category removed"
        end
      end
      context 'current user isn\'t owner category' do
        it 'sends danger flash' do
          delete :destroy, params: { slug: category.slug }
          expect(flash[:danger]).to eq "Category didn't remove. This category not yours"
        end
      end
    end
  end
  context '#show user - owner category and subscription' do
    it "assigns @pre_subscribe" do
      sign_in user
      subscription = create :subscription, user: user, category: category
      get :show, params: { slug: category.slug }
      expect(controller.current_user).to eq(user)
      expect(assigns(:category)).to eq(category)
      expect(assigns(:pre_subscribe)).to eq(subscription)
    end
  end
  context 'user log_out' do
    context 'success status and render index page' do
      subject! { get :index }

      it 'returns a successful response to GET' do
        expect(response).to have_http_status(200)
      end
      it 'render template :index' do
        expect(response).to render_template :index
      end
      it "assigns @categories" do
        expect(assigns(:categories)).to eq([category])
      end
    end
    context 'success status and render show page' do
      subject! { get :show, params: { slug: "#{category.slug}"} }
      it 'returns a successful response to GET' do
        expect(response).to have_http_status(200)
      end
      it 'render template :show' do
        expect(response).to render_template :show
      end
    end
    context '#new' do
      subject! { get :new }
      it 'returns a status code 302' do
        expect(response).to have_http_status(302)
      end
      it 'render template :new' do
        expect(response).to redirect_to('http://test.host/users/sign_in?locale=en')
      end
      it 'sends notice' do
        expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
      end
    end
  end
end
