class NewImageSendEmail
  @queue = :new_image_email

  def self.perform(id, locale)
    UserMailer.new_image(id, locale).deliver
  end
end