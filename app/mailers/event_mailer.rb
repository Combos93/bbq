class EventMailer < ApplicationMailer

  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "Новый комментарий @ #{event.title}"
  end

  def new_photo(event, photo, email)
    if Rails.env.development?
      attachments.inline['image.jpg'] = File.read("#{Rails.root}/public#{photo.photo}")
    end

    @event = event
    @photo = photo

    mail to: email, subject: "Новая фотография в событии #{event.title}"
  end
end
