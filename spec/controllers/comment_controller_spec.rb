# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:category) { create :category }
  let(:image) { create :image, category: category }
  let(:user) { create :user }
  let(:comment) { create :comment, image_id: image.id, user_id: user.id }
  let(:comment1) { create :comment, image_id: image.id, user_id: user.id }
  let(:comment_attr) { attributes_for(:comment) }
  let!(:action) { Action.create(params) }
  let(:params) { { action_type: 'navigation' } }
  let!(:action_create) { Action.create(params_action_create) }
  let(:params_action_create) { { action_type: 'comments' } }
  context 'user sign_in' do
    login_user
    it 'should have a current_user' do
      expect(subject.current_user).to_not eq(nil)
    end
    it 'does not exist :index' do
      expect { get :index }.to raise_error(ActionController::UrlGenerationError)
    end
    it 'does not exist :show' do
      expect { get :show }.to raise_error(ActionController::UrlGenerationError)
    end
    it 'does not exist :edit' do
      expect { get :edit }.to raise_error(ActionController::UrlGenerationError)
    end
    it 'does not exist :update' do
      expect { put :update }.to raise_error(ActionController::UrlGenerationError)
    end
    it 'does not exist :destroy' do
      expect { delete :destroy }.to raise_error(ActionController::UrlGenerationError)
    end

    context '#all' do
      subject! { get :all }
      it 'returns a successful response to GET' do
        expect(response).to have_http_status(200)
      end
      it 'render template :all' do
        expect(response).to render_template :all
      end
      it 'assigns @comments with order' do
        expect(assigns(:comments)).to contain_exactly(comment1, comment)
      end
      context 'activity' do
        it 'action_type is "navigation"' do
          expect(LoggingUserAction.last.action.action_type).to eq('navigation')
        end
        it 'url is "http://test.host/categories"' do
          expect(LoggingUserAction.last.action_path).to eq('http://test.host/comments')
        end
        it 'record to db' do
          expect(LoggingUserAction.count).to eq(1)
        end
      end
    end
    context '#new' do
      subject! { get :new, params: { category_slug: category.slug, image_id: image.id } }
      let(:comment) { double(Comment) }

      before do
        allow(Comment).to receive(:new).and_return(comment)
      end
      it 'assigns @comment variable' do
        expect(assigns(:comment)).to be_a_new(Comment)
      end
      it 'returns a successful response to GET' do
        expect(response).to have_http_status(200)
      end
      it 'render template :new' do
        expect(response).to render_template :new
      end
    end
    context '#create' do
      let(:comment) { build(:comment) }

      context 'with valid attributes' do
        it 'create a comment' do
          expect(comment.save!).to be true
        end
      end
    end
  end
end
