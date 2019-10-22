# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:category) { create :category }
  let(:image) { create :image, category: category }
  let(:user) { create :user }
  let!(:like) { create :like }
  let!(:action) { Action.create(params) }
  let(:params) { { action_type: 'navigation' } }
  let!(:action_create) { Action.create(params_action_create) }
  let(:params_action_create) { { action_type: 'likes' } }
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
      let(:like) { build(:like) }
      it 'create a like' do
        expect(like.save!).to be true
      end
      it 'redirects to category_path' do
        post :create, params: { category_slug: category.slug, image_id: image.id }
        expect(response).to redirect_to "http://test.host/categories/#{category.slug}/images/#{image.id}?locale=en"
      end
    end
  end
  # context '#destroy' do
  #   it "should have a current_user" do
  #     sign_in user
  #     allow(controller).to receive(:already_liked?).and_return like
  #     delete :destroy, params: { slug: category.slug, image_id: image.id, like_id: like.id, locale: 'en' }
  #   end
  #   it 'has a 302 status code' do
  #     expect(response).to have_http_status(302)
  #   end
  #   it 'should redirect to category_path' do
  #     expect(response).to redirect_to "http://test.host/categories/#{category.slug}/images/#{image.id}?locale=en"
  #   end
  #   it 'receive method :find_category and return category ' do
  #     expect(controller).to receive(:find_category)
  #     delete :destroy, params: { slug: category.slug, image_id: image.id }
  #   end
  # end
  context 'user sign_out' do
    context '#create' do
      before do
        post :create, params: { category_slug: category.slug, image_id: image.id }
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
