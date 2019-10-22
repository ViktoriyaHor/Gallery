# frozen_string_literal: true

require 'rails_helper'

describe 'routing to comments' do
  let!(:category) { create :category }
  let!(:image) { create :image_with_comment, category: category }

  it 'routes get /comments to comments#all' do
    expect(get: '/comments').to route_to(
                                      controller: 'comments',
                                      action: 'all'
                                    )
  end
  it 'routes get categories/:category_slug/images/new to comments#new' do
    expect(get: "/categories/#{category.slug}/images/#{category.images.first.id}/comments/new").to route_to(
                                       controller: 'comments',
                                       action: 'new',
                                       category_slug: category.slug,
                                       image_id: category.images.first.id.to_s
                                     )
  end
  it 'routes post /categories/:category_slug/images/:image_id/comments to comments#create' do
    expect(post: "/categories/#{category.slug}/images/#{category.images.first.id}/comments").to route_to(
                                      controller: 'comments',
                                      action: 'create',
                                      category_slug: category.slug,
                                      image_id: category.images.first.id.to_s
                                    )
  end
  it 'does not exist /categories/:category_slug/images/:image_id/comments to comments#index' do
    expect(get: "/categories/#{category.slug}/images/#{category.images.first.id}/comments").not_to be_routable
  end
end
