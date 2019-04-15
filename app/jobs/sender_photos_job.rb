class SenderPhotosJob < ApplicationJob
  queue_as :default

  def perform(event, photo, mail)
    # all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [photo.user.email]).uniq

    # all_emails.each do |mail|
      EventMailer.new_photo(event, photo, mail).deliver_now
    # end
  end
end
