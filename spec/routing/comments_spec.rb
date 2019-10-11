require 'rails_helper'

describe "routing to comments" do
  let!(:category) {create :category}
  let!(:image) {create :image_with_comment, category: category}

  it 'routes get /comments to comments#all' do
     expect(get: '/comments').to route_to(
                                      controller: 'comments',
                                      action: 'all'
                                  )
  end
  it "does not exist /categories/:category_slug/images/:image_id/comments to comments#index" do
    expect(get: "/categories/#{category.slug}/images/#{category.images.first.id}/comments").not_to be_routable
  end
  # it 'routes /categories/:category_slug/images/:id to images#show' do
  #   expect(get: "/categories/#{category.slug}/images/#{category.images.first.id}").to route_to(
  #                                        controller: 'images',
  #                                        action: 'show',
  #                                        category_slug: category.slug,
  #                                        id: category.images.first.id.to_s
  #                                    )
  # end
  # it 'routes get categories/:category_slug/images/new to images#new' do
  #   expect(get: "categories/#{category.slug}/images/new").to route_to(
  #                                      controller: 'images',
  #                                      action: 'new',
  #                                      category_slug: category.slug,
  #                                      )
  # end
  # it 'routes post /categories/:category_slug/images to images#create' do
  #   expect(post: "/categories/#{category.slug}/images").to route_to(
  #                                     controller: 'images',
  #                                     action: 'create',
  #                                     category_slug: category.slug
  #                                     )
  # end
  # it "does not exist /categories/:category.slug/images/:id/edit to images#edit" do
  #   expect(get: "/categories/#{category.slug}/images/#{category.images.first.id}/edit").not_to be_routable
  # end
  # it "does not exist /categories/:category.slug/images to images#update" do
  #   expect(put: "/categories/#{category.slug}/images").not_to be_routable
  # end
  # it 'routes /categories/:slug to categories#destroy for slug' do
  #   expect(delete: "/categories/#{category.slug}/images/#{category.images.first.id}").to route_to(
  #                                      controller: 'images',
  #                                      action: 'destroy',
  #                                      category_slug: category.slug,
  #                                      id: category.images.first.id.to_s
  #                                      )

end