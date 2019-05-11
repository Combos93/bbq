require 'rails_helper'

RSpec.describe EventPolicy do
  let(:user) { User.new }

  subject { EventPolicy }

  permissions :create? do
    it { is_expected.to permit(user, Event.new) }
    it { is_expected.not_to permit(nil, Event.new) }
  end

  permissions :show?, :edit?, :update?, :destroy? do
    it { is_expected.not_to permit(user, Event.new) }
  end

  context 'when user in an owner of event' do
    let(:event) {
      Event.create(title: 'Шашлыки', address: 'Москва, Битцевский парк',
                   datetime: '01 июн., 12:00', description: 'Будет круто!', user: user)
    }

    permissions :show?, :edit?, :update?, :destroy? do
      it { is_expected.to permit(user, event) }
    end

    context 'when user in not an owner of event' do
      let(:event) {
        Event.create(title: 'Шашлыки', address: 'Москва, Битцевский парк',
                     datetime: '01 июн., 12:00', description: 'Будет круто!')
      }

      permissions :create? do
        it { is_expected.not_to permit(nil, Event.new) }
      end

      permissions :show?, :edit?, :update?, :destroy? do
        it { is_expected.not_to permit(nil, event) }
      end
    end
  end
end