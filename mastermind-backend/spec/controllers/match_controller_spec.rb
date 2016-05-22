require 'rails_helper'

RSpec.describe MatchController, type: :controller do
  render_views

  describe '#new_game' do
    before do
      post :new_game, name: name, format: :json
    end

    context 'when submitting a name' do
      subject { json response }

      let(:name) { 'João das Neves' }

      it { expect(response.status).to eq(200) }
      
      it { is_expected.to include('game_key') }
      it { is_expected.not_to include('error') }
    end

    context 'when name is not submitted' do
      subject { json response }

      let(:name) { nil }
      
      it { expect(response.status).to eq(422) }

      it { is_expected.to match(error: {code: 422, message: a_string_including('Parameter missing')}) }
      it { is_expected.not_to include('game_key') }
    end

    context 'when joining a game twice' do
      subject { json(response)['game_key'] }

      let(:name) { 'Jean Niege' }
      let!(:first_game_key) { json(response)['game_key'] }

      before do
        post :new_game, name: name, format: :json
      end
      
      it 'creates two different games' do
        is_expected.not_to eq(first_game_key)
      end
    end
  end

  describe '#join_game' do
    before do
      post :join_game, name: name, game_key: game_key, format: :json
    end

    context 'when joining a valid game' do

    end

    context 'when joining an invalid game' do

    end
  end

  describe '#guess' do
    before do
      #factory_girl stuff

      post :guess, code: code, game_key: game_key, format: :json
    end

    subject(:json_response) { json response }

    context 'when guessing in an invalid game' do
      let(:code) { ['a', 'b'] }
      let(:game_key) { 'sbrubles' }

      it { is_expected.to include(:errors) }
      it { expect(json_response).to eq(error_response) }
    end

    context 'when submitting invalid code' do
      let(:game_key) { 'game_key' }
      let(:error_response) { 'Invalid code' }

      it { expect(json_response['errors']).to eq(error_response) }
    end

    context 'when making a correct guess' do
      let(:code) { ['a', 'b'] }
      let(:game_key) { 'sbrubles' }
      let(:result) { { result: { exact: 8, near: 0 } } }
      let(:solved) { true }

      it { expect(json_response['result']).to eq(error_response) }
    end

    context 'when making an incorrect guess' do
    end

    context 'when all guesses have been made' do
    end

    context 'when playing a multiplayer game' do
    end
  end  

end
