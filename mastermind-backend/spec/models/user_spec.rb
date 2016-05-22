require 'rails_helper'

describe User, type: :model do
  subject(:user) { FactoryGirl.create(:user) }

  before(:each) { DatabaseCleaner.start }
  after(:each) { DatabaseCleaner.clean }

  context 'when user name is duplicated' do
    before { user }

    it { expect { FactoryGirl.create(:user) }.to raise_error }
  end

  context 'when user is valid' do
    it { is_expected.to be_truthy }
    it { expect { user }.to change { User.count }.by(1) }
  end

end