# # frozen_string_literal: true
# #
# # send letter when user confirmed
# class WelcomeSendEmail
#   @queue = :welcome_email
#
#   def self.perform(params)
#     UserMailer.welcome_send(params).deliver
#   end
# end
