require 'rails_helper'

RSpec.describe Guess, type: :model do
  context 'when colors are invalid' do
    subject(:guess) { FactoryGirl.build(:invalid_colors_guess) }

    let!(:save) { guess.save }

    it { expect(save).to be_falsy }
    it { expect(guess.errors.messages).to match(colors: ['Invalid color value']) }
  end

  context 'when exact or near are non numerals' do
    subject(:guess) { FactoryGirl.build(:non_numeral_guess) }

    let!(:save) { guess.save }

    it { expect(save).to be_falsy }
    it { expect(guess.errors.messages).to match({exact: ['must be an integer'], near: ['is not a number']}) }
  end

  context 'when everything is ok' do
    subject(:guess) { FactoryGirl.build(:guess) }

    let!(:save) { guess.save }

    it { expect(save).to be_truthy }
    it { expect(guess.errors).to be_empty }
  end
end
