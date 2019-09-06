class NewImageSendEmail
  @queue = :new_image_email

  def self.perform(id)
    UserMailer.new_image(id).deliver
  end
end