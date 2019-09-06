class WelcomeSendEmail
  @queue = :welcome_email

  def self.perform(params)
    UserMailer.welcome_send(params).deliver
  end
end