class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,6})\z/,
            unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id },
            unless: Proc.new { |a| a.present? }

  validate :just_subscriber
  validate :check_all_emails

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
    if User.find_by email: user_email
      errors.add(:user_email, "isn't valid! Entered email belongs to registered user!")
    end
  end

  def just_subscriber
    if user == event.user
      errors.add(:user, :invalid)
    end
  end
end
