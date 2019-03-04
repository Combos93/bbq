class SubscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_subscription, only: [:destroy]

  def create
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    pack_usersemails = User.connection.select_values(User.select("email").to_sql)
    pack_subscriptionsemails = Subscription.connection.select_values(Subscription.select("user_email").to_sql)

    if pack_usersemails.include?(@new_subscription.user_email) || pack_subscriptionsemails.include?(@new_subscription.user_email)
      redirect_to @event, alert: I18n.t('controllers.subscriptions.error')
    else
      @new_subscription.save
      redirect_to @event, notice: I18n.t('controllers.subscriptions.created')
    end
  end

  def destroy
    message = { notice: I18n.t('controllers.subscriptions.destroyed') }

    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = { alert: I18n.t('controllers.subscriptions.error') }
    end

    redirect_to @event, message
  end

  private

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
