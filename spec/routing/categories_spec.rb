# frozen_string_literal: true

require 'rails_helper'

describe 'routing to categories' do
  let(:category) { create :category }
  it 'routes get /categories to categories#index ' do
    expect(get: '/categories').to route_to(
                                      controller: 'categories',
                                      action: 'index'
                                    )
  end
  it 'routes /categories/:slug to categories#show for slug' do
    expect(get: "/categories/#{category.slug}").to route_to(
                                         controller: 'categories',
                                         action: 'show',
                                         slug: category.slug
                                       )
  end
  it 'routes get /categories/new to categories#new' do
    expect(get: '/categories/new').to route_to(
                                       controller: 'categories',
                                       action: 'new'
                                     )
  end
  it 'routes post /categories to categories#create' do
    expect(post: '/categories').to route_to(
                                      controller: 'categories',
                                      action: 'create'
                                    )
  end
  it 'does not exist :edit' do
    expect(get: "/categories/#{category.slug}/edit").to_not route_to(
                                                                controller: 'categories',
                                                                action: 'edit'
                                                              )
  end
  it 'does not exist :update' do
    expect(put: "/categories/#{category.slug}").not_to be_routable
  end
  it 'routes /categories/:slug to categories#destroy for slug' do
    expect(delete: "/categories/#{category.slug}").to route_to(
                                       controller: 'categories',
                                       action: 'destroy',
                                       slug: category.slug
                                     )
  end
end
