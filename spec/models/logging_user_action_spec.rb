require 'rails_helper'

RSpec.describe LoggingUserAction, type: :model do
  subject! { create :logging_user_action, user_id: user.id, action_id: action.id}
  let(:action) { create :action }
  let(:user) { create :user }

  context 'validation' do
    it 'check dependent destroy from user' do
      expect { user.destroy }.to change { LoggingUserAction.count }.by(-1)
    end
    it 'check dependent destroy from action' do
      expect { action.destroy }.to change { LoggingUserAction.count }.by(-1)
    end
  end
end
