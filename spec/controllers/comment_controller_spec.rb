require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:category) {create :category}
  let(:image) {create :image, category: category}
  let(:user) { create :user }
  let(:comment) { create :comment, image_id: image.id, user_id: user.id }
  context 'user sign_in' do
    login_user
    let!(:action) { Action.create(params) }
    let(:params) { { action_type: 'navigation' } }

    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end
    it "does not exist :index" do
      expect{get :index}.to raise_error(ActionController::UrlGenerationError)
    end
    it "does not exist :show" do
      expect{get :show}.to raise_error(ActionController::UrlGenerationError)
    end
    it "does not exist :edit" do
      expect{get :edit}.to raise_error(ActionController::UrlGenerationError)
    end
    it "does not exist :update" do
      expect{put :update}.to raise_error(ActionController::UrlGenerationError)
    end
    it "does not exist :destroy" do
      expect{put :destroy}.to raise_error(ActionController::UrlGenerationError)
    end

    context '#all' do
      subject! { get :all }
      it 'returns a successful response to GET' do
        expect(response).to have_http_status(200)
      end
      it 'render template :all' do
        expect(response).to render_template :all
      end
      it 'assigns @comments with order images by likes_count' do
        expect(assigns(:comments)).to eq([comment])
      end
    end
  end
end
