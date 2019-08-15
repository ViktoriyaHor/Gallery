# class AdminImage < ActiveRecord::Base
# end

ActiveAdmin.register AdminImage do
  config.comments = false
  config.clear_action_items!
  before_action do @skip_sidebar = true end

  controller do
    def index
      # scraping_images("https://marvel.com.ru")
    end
    private_methods
    def scraping_images(url)
      require 'nokogiri'
      require 'open-uri'
      document = Nokogiri::HTML(open(url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
      img = document.css("img")
      img.each do |link|
        AdminImage.create(:src => link.attributes["src"].value)
      end
    end
  end

  index do
    column("Image") { |image| image_tag("#{image.src}")}
    column :src
    column :created_at
    # column("Link") {link_to('Add', admin_images_path, method: post)}
    actions
  end


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
