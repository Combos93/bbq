class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  validates :user_name, presence: true, unless: Proc.new { |a| a.present? }
  validates :user_email, presence: true,format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/,
            unless: Proc.new { |a| a.present? }

  validates :user_name, uniqueness: { scope: :event_id }, if: Proc.new { |a| a.present? } ##### user -> user_name
  validates :user_email, uniqueness: { scope: :event_id },
            unless: Proc.new { |a| a.present? }

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
end
