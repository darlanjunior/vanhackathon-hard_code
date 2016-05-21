require 'rails_helper'

describe Guess, type: :model do
  subject(:guess_model) { Guess.new(guess: guess, exact: exact, near: near) }
  let(:guess) { [:R, :B, :Y, :G, :R, :B, :Y, :G] }
  let(:exact) { 5 }
  let(:near) { 5 }
  
  context 'when guess has invalid contents' do
    let(:guess) { (1..Game.code_size).to_a }
    let!(:save) { guess_model.save }

    it { expect(save).to be_falsy }
    it { expect(guess_model.errors.messages).to match(guess: [a_string_including('Invalid content format')])}
  end

  context 'when guess size is smaller than required' do
    let(:guess) { (Game.code_size-1).times.map { Match.colors.sample } }
    let!(:save) { guess_model.save }

    it { expect(save).to be_falsy }
    it { expect(guess_model.errors.messages).to match(guess: [a_string_including('is the wrong length')])}
  end

  context 'when guess is empty' do
    let(:guess) { nil }
    let!(:save) { guess_model.save }

    it { expect(save).to be_falsy }
    it { expect(guess_model.errors.messages).to match(guess: [a_string_including('be blank'), a_string_including('wrong length')])}
  end

  context 'when guess is valid' do
    subject { -> { guess_model.save } }

    it { is_expected.to be_truthy }
    it { is_expected.to change { Guess.count }.by(1) }
  end

end