module ApplicationHelper
  def bootstrap_class_for(name)
    {
        success: 'alert-success',
        error: 'alert-danger',
        danger: 'alert-danger',
        alert: 'alert-warning',
        notice: 'alert-info',
    }[name.to_sym] || name
  end

  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end
  #
  # def scraping_images(url)
  #   require 'upload_images'
  #   require 'open-uri'
  #
  #   document = Nokogiri::HTML(open(url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
  #   img = document.css("img")
  #   img.each do |link|
  #     AdminImage.create(:src => link.attributes["src"].value)
  #   end
  #
  # end
end
