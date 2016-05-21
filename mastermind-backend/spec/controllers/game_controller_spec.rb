require 'rails_helper'

RSpec.describe GameController, type: :controller do
  render_views

  describe '#new_game' do
    before do
      post :new_game, name: name, format: :json
    end

    context 'when submitting a name' do
      subject { JSON.parse(response.body) }

      let(:name) { 'João das Neves' }

      it 'creates a new game and returns the game key' do
        expect(response.status).to eq(200)
        
        is_expected.to include('game_key')
        is_expected.not_to include('errors')
      end
    end

    context 'when name is not submitted' do
      subject { JSON.parse(response.body) }

      let(:name) { nil }

      it { is_expected.to include('errors') }
      it { is_expected.not_to include('game_key') }

      it 'responds with an error code' do
        expect(response.status).to eq(422)
        expect(subject['errors']).to eq('A player name is required')
      end
    end

    context 'when joining a game twice' do
      subject { JSON.parse(response.body)['game_key'] }

      let(:name) { 'Jean Niege' }
      let!(:first_game_key) { JSON.parse(response.body)['game_key'] }

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

    context 'when guessing in an invalid game' do
      subject { JSON.parse(response.body) }
      
      let(:code) { ['a', 'b'] }
      let(:game_key) { 'sbrubles' }

      it { is_expected.to include(:errors) }
      it { expect(subject['errors'].to eq('Invalid game key') }
    end

    context 'when submitting invalid code' do
      subject(:response) { JSON.parse(response.body) }
      
      let(:game_key) {  }
      let(:error_response) { 'Invalid code' }

      it { expect(subject['errors']).to eq(error_response) }
    end

    context 'when making a correct guess' do
    end

    context 'when making an incorrect guess' do
    end

    context 'when all guesses have been made' do
    end

    context 'when playing a multiplayer game' do
    end
  end  

end
