class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,6})\z/,
            unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id },
            unless: Proc.new { |a| a.present? }

  validate :just_subscriber
  # validate :check_all_emails

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def check_all_emails
    # subscribers = User.pluck(:email)
    subscribers = Event.find([:event_id]).subscriptions.pluck(:email)

    subscribers.each do |email|
      if user_email == email
        errors.add(:user_email, :invalid)
      end
    end

    # if subscribers.include?(user_email)
    # if user_email == user.all.pluck(:email) #(event.user.email || User.email)
    #   errors.add(:user_email, :invalid)
    # end
    # Event.find(5).subscriptions.pluck(:user_email) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  end

  def just_subscriber
    if user == event.user
      errors.add(:user, :invalid)
    end
  end
end
