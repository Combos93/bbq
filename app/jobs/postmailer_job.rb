class PostmailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
