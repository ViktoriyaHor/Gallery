require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  let(:category) {create :category}
  let(:image_params) { FactoryBot.attributes_for(:image).stringify_keys.merge(category_id: category.id) }
  let(:image) { FactoryBot.build_stubbed(:image)  }
  let(:user) { FactoryBot.create(:user) }
  context "#extended_create" do
    context 'without ability to update' do
      before do
        post :extended_create, params: {image: image_params}
      end
      it 'redirects to root page' do
        expect(response).to redirect_to("http://test.host/users/sign_in?locale=en")
      end
      it 'sends notice' do
        expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
      end
    end
    context 'with valid attributes' do
      before do
        sign_in user
        # allow(image).to receive(:create_common).and_return true
        allow(controller).to receive(:current_user).and_return user
        # post :extended_create, params: {image: image_params}
      end
      it 'assigns @image' do
        # byebug
        post :extended_create, params: {image: image_params}
        expect(response).to redirect_to Category.first
        # expect(assigns(:image)).to be_nil

      end
      it 'receives create for @image' do
        # byebug
        expect_any_instance_of(ApplicationController::ImagesController).to receive(:extended_create).and_return(image)


        # expect(image).to receive(:create_common).with(image_params)
        post :extended_create, params: image_params
      end
    end

  end
end

# RSpec.describe ImagesController, type: :controller do
#   let(:category) {create :category}
#   let(:image) {create :image, category: category}
#   let(:user) { create :user }
#   let(:like) { create :like, image_id: image.id, user_id: user.id }
#   let!(:action) { Action.create(params) }
#   let(:params) { { action_type: 'navigation' } }
#   context 'user sign_in' do
#     login_user
#
#     it "should have a current_user" do
#       expect(subject.current_user).to_not eq(nil)
#       # allow(controller).to receive(:current_user).and_return user
#     end
#     it "does not exist :edit" do
#       expect{get :edit}.to raise_error(ActionController::UrlGenerationError)
#     end
#     it "does not exist :update" do
#       expect{put :update}.to raise_error(ActionController::UrlGenerationError)
#     end
#     it "does not exist :destroy" do
#       expect{put :destroy}.to raise_error(ActionController::UrlGenerationError)
#     end
#     context '#index' do
#       subject! { get :index }
#       let(:image_with_likes)  { create :image_with_like, likes_count: 5, category: category}
#       it 'returns a successful response to GET' do
#         expect(response).to have_http_status(200)
#       end
#       it 'render template :index' do
#         expect(response).to render_template :index
#       end
#       it 'assigns @images with order images by likes_count' do
#         expect(assigns(:images)).to eq([image_with_likes, image])
#       end
#
#       context 'activity' do
#         it 'action_type is "navigation"' do
#           expect(LoggingUserAction.last.action.action_type).to eq('navigation')
#         end
#
#         it 'url is "http://test.host/images"' do
#           expect(LoggingUserAction.last.action_path).to eq("http://test.host/images")
#         end
#
#         it 'record to db' do
#           expect(LoggingUserAction.count).to eq(1)
#         end
#       end
#     end
#     context '#show' do
#       subject! { get :show, params: { category_slug: category.slug, id: image.id } }
#
#       it "returns success responce" do
#         expect(response).to have_http_status(200)
#       end
#
#       it 'render template :show' do
#         expect(response).to render_template :show
#       end
#       it 'receive method :find_category and return category ' do
#         expect(controller).to receive(:find_category)
#         get :show, params: { category_slug: category.slug, id: image.id }
#       end
#       it "requires the slug parameter" do
#         expect { get :show }.to raise_error(ActionController::UrlGenerationError)
#       end
#       it "assigns @image" do
#         expect(assigns(:image)).to eq(image)
#       end
#       it "assigns @pre_like" do
#         expect(assigns(:pre_like)).to eq(user.likes.first)
#       end
#
#       context 'activity' do
#         it 'action_type is "navigation"' do
#           expect(LoggingUserAction.last.action.action_type).to eq('navigation')
#         end
#
#         it 'url is http://test.host/categories/category_slug/images/id' do
#           expect(LoggingUserAction.last.action_path).to eq("http://test.host/categories/#{category.slug}/images/#{image.id}")
#         end
#
#         it 'record to db' do
#           expect(LoggingUserAction.count).to eq(1)
#         end
#       end
#     end
#     context '#new' do
#       subject! { get :new, params: { category_slug: category.slug} }
#       let(:image) { double(Image) }
#
#       before do
#         allow(Image).to receive(:new).and_return(image)
#       end
#       it 'assigns @image variable' do
#         expect(assigns(:image)).to be_a_new(Image)
#       end
#       it 'returns a successful response to GET' do
#         expect(response).to have_http_status(200)
#       end
#       it 'render template :new' do
#         expect(response).to render_template :new
#       end
#     end
#     context '#extended_new' do
#       subject! { get :extended_new }
#       let(:image) { double(Image) }
#
#       before do
#         allow(Image).to receive(:new).and_return(image)
#
#       end
#       it 'assigns @image variable' do
#         expect(assigns(:image)).to be_a_new(Image)
#       end
#       it 'returns a successful response to GET' do
#         expect(response).to have_http_status(200)
#       end
#       it 'render template :extended_new' do
#         expect(response).to render_template :extended_new
#         allow(controller).to receive(:find_category_all).and_return category
#         expect(assigns(:category_all)).to eq([category])
#         # expect(controller).to should_receive(:find_category_all)
#       end
#     end
#     context "#create" do
#       let(:image) { build(:image) }
#
#       context "with valid attributes" do
#         it "create an image" do
#           expect(image.save!).to be true
#         end
#         it "redirects to category_path" do
#           post :create, params: { category_slug: category.slug }
#           expect(response).to redirect_to "http://test.host/categories/#{category.slug}?locale=en"
#         end
#       end
#       context "with image: nil" do
#         before do
#           post :create, params: { category_slug: category.slug, image: nil }
#         end
#         it "sends flash error" do
#           expect(flash[:danger]).to eq 'Image didn\'t save! Please select a file'
#         end
#         it 'should be render new template after error' do
#           expect(response).to redirect_to "http://test.host/categories/#{category.slug}?locale=en"
#         end
#         it 'don\'t create a new image' do
#           expect(Image.count).to eq(0)
#         end
#       end
#     end
#   end
#   # context '#show user - owner image and like' do
#   #   it "assigns @pre_like" do
#   #     sign_in user
#   #     like = create :like, user: user, image: image
#   #     get :show, params: { category_slug: category.slug, id: image.id }
#   #     expect(controller.current_user).to eq(user)
#   #     expect(assigns(:image)).to eq(image)
#   #     expect(assigns(:pre_like)).to eq(like)
#   #   end
#   # end
#   context "#extended_create" do
#     let(:image_params) { FactoryBot.attributes_for(:image).stringify_keys }
#     let(:image) { FactoryBot.build_stubbed(:image, category_id: category.id) }
#     let(:user) { FactoryBot.create(:user) }
#     context 'without ability to update' do
#       before do
#         allow(user).to receive_message_chain(:images, :find).and_return nil
#         allow(controller).to receive(:current_user).and_return user
#         post :extended_create, params: image_params
#       end
#
#       it 'redirects to root page' do
#         expect(response).to redirect_to("http://test.host/users/sign_in?locale=en")
#       end
#
#       it 'sends notice' do
#         expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
#       end
#     end
#     context 'with valid attributes' do
#       before do
#         allow(image).to receive(:create_common).and_return true
#         allow(user).to receive_message_chain(:images, :find).and_return image
#         allow(controller).to receive(:current_user).and_return user
#       end
#
#       it 'receives extended_create for @image' do
#         # expect(image).to receive(:create).with(image_params)
#         post :extended_create, params: image_params
#       end
#
#       # it 'sends success notice' do
#       #   put :update, id: post.id, post: post_params
#       #   expect(flash[:notice]).to eq 'Post was successfully updated.'
#       # end
#       #
#       # it 'redirects to post page' do
#       #   put :update, id: post.id, post: post_params
#       #   expect(response).to redirect_to post
#       # end
#     end
#
#     # context 'with forbidden attributes' do
#     #   before do
#     #     allow(post).to receive(:update).and_return true
#     #     allow(user).to receive_message_chain(:posts, :find).and_return post
#     #     allow(controller).to receive(:current_user).and_return user
#     #   end
#     #
#     #   it 'generates ParameterMissing error without post params' do
#     #     expect { put :update, id: post.id }.to raise_error(ActionController::ParameterMissing)
#     #   end
#     #
#     #   it 'filters forbidden params' do
#     #     expect(post).to receive(:update).with(post_params)
#     #     put :update, id: post.id, post: post_params.merge(user_id: 1)
#     #   end
#     # end
#     #
#     # context 'with invalid attributes' do
#     #   before do
#     #     allow(post).to receive(:update).and_return false
#     #     allow(user).to receive_message_chain(:posts, :find).and_return post
#     #     allow(controller).to receive(:current_user).and_return user
#     #   end
#     #
#     #   it 'sends error flash' do
#     #     put :update, id: post.id, post: post_params
#     #     expect(flash[:error]).to eq 'Could not save post.'
#     #   end
#     #
#     #   it 'renders :edit template' do
#     #     put :update, id: post.id, post: post_params
#     #     expect(response).to render_template :edit
#     #   end
#     # end
#   end
#   context 'user log_out' do
#     context 'success status and render index page' do
#       subject! { get :index }
#       it 'returns a successful response to GET' do
#         expect(response).to have_http_status(200)
#       end
#       it 'render template :index' do
#         expect(response).to render_template :index
#       end
#     end
#     context '#extended_new' do
#       subject! { get :extended_new }
#       it 'returns a status code 302' do
#         expect(response).to have_http_status(302)
#       end
#       it 'render template :new' do
#         expect(response).to redirect_to('http://test.host/users/sign_in?locale=en')
#       end
#       it 'sends notice' do
#         expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
#       end
#     end
#   end
# end
