# # frozen_string_literal: true
#
# # send letter when adding images to the subscribed category
# class NewImageSendEmail
#   @queue = :new_image_email
#
#   def self.perform(id)
#     UserMailer.new_image(id).deliver
#   end
# end
