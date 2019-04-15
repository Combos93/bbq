class SenderCommentsJob < ApplicationJob
  queue_as :default

  def perform(event, comment, mail)
    # all_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq

    # all_emails -= [current_user.email] if user_signed_in?

    # all_emails.each do |mail|
      EventMailer.comment(event, comment, mail).deliver_now
    # end
  end
end
