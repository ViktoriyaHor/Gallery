# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Action, type: :model do
  subject! { create :action }
  let(:user) { create :user }

  context 'validation' do
    it 'check don\'t dependent destroy from user' do
      expect { user.destroy }.to change { Action.count }.by(0)
    end
  end
end
