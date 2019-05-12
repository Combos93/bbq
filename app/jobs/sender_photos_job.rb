class SenderPhotosJob < ApplicationJob
  queue_as :default

  def perform(event, photo, mail)
    EventMailer.new_photo(event, photo, mail).deliver_now
  end
end
