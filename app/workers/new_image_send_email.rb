class NewImageSendEmail
  @queue = :new_image_email

  def self.perform(image_id)
    UserMailer.new_image(image_id).deliver
  end
end