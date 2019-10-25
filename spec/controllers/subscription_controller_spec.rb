# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:category) {create :category, user: user}
  let(:user) { create :user }
  let(:subscription) { create :subscription, user: user, category: category }
  let!(:action) { Action.create(params) }
  let(:params) { { action_type: 'navigation' } }
  context 'user sign_in' do
    login_user
    it 'should have a current_user' do
      expect(subject.current_user).to_not eq(nil)
    end
    it 'does not exist :index' do
      expect { get :index }.to raise_error(ActionController::UrlGenerationError)
    end
    it 'does not exist :edit' do
      expect { get :edit }.to raise_error(ActionController::UrlGenerationError)
    end
    it 'does not exist :update' do
      expect { put :update }.to raise_error(ActionController::UrlGenerationError)
    end
    it 'does not exist :show' do
      expect { get :show }.to raise_error(ActionController::UrlGenerationError)
    end
    it 'does not exist :new' do
      expect { get :new }.to raise_error(ActionController::UrlGenerationError)
    end
    context '#create' do
      it 'create a subscription' do
        expect(subscription.save!).to be true
      end
      it 'redirects to category_path' do
        post :create, params: { category_slug: category.slug }
        expect(response).to redirect_to "http://test.host/categories/#{category.slug}?locale=en"
      end
    end
  end
  context 'user sign_out' do
    context '#create' do
      before do
        post :create, params: { category_slug: category.slug }
      end
      it 'should have not a current_user' do
        expect(subject.current_user).to eq(nil)
      end
      it 'returns a status code 302' do
        expect(response).to have_http_status(302)
      end
      it 'render sign_in' do
        expect(response).to redirect_to('http://test.host/users/sign_in?locale=en')
      end
      it 'sends notice' do
        expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
      end
    end
  end
end
