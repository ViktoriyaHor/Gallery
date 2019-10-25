ActiveAdmin.register_page "Upload images" do
  menu priority: 10

  page_action :grab, method: :post do
    url = params['upload_images']['url']
    document = Nokogiri::HTML(open(url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
    img = document.css("img")
    img.each do |link|
      AdminImage.create(:src => link.attributes["src"].value)
    end
    redirect_to admin_admin_images_path
  end

  content do
    render partial: 'form'
  end
end