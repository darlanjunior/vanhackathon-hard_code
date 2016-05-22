require 'rails_helper'

RSpec.describe MatchController, type: :controller do
  render_views

  before(:each) { DatabaseCleaner.start }
  after(:each) { DatabaseCleaner.clean }

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
    before(:each) { DatabaseCleaner.start }
    after(:each) { DatabaseCleaner.clean }
    before(:each) do
      @match = create(:match) do |match|
        create(:user, match: match)
        create(:user2, match: match)
      end

      allow_any_instance_of(Match).to receive(:code).and_return(['R', 'R', 'R', 'R', 'R', 'R', 'R', 'R'])


      post :guess, { name: 'Toninho do Diabo', code: code, game_key: game_key }, format: :json
    end

    subject(:json_response) { json response }

    let(:game_key) { 777 }
    let(:code) { ['R', 'R', 'R', 'R', 'R', 'R', 'R', 'R'] }

    context 'when guessing in an invalid game' do
      let(:game_key) { 'sbrubles' }

      it { expect(response.status).to eq(404) }
      it { is_expected.to match(error: {code: 404, message: a_string_including('Couldn\'t find Match')}) }
    end

    context 'when submitting invalid code' do
      let(:code) { ['a', 'b'] }

      it { expect(response.status).to eq(400) }
      it { is_expected.to match(error: {code: 400, message: {colors: [a_string_including('Invalid color')] } }) }
    end

    context 'when making a correct guess' do
      let(:correct_response) { 
        a_hash_including({ 
          result: 'You win!',
          solved: true,
          user: 'Toninho do Diabo'
         })
      }

      it { is_expected.to match(correct_response) }
    end

    context 'when making incorrect guesses' do
      let(:code) { [['G', 'R', 'R', 'R', 'R', 'R', 'R', 'R'], ['R', 'R', 'R', 'R', 'R', 'G', 'R', 'R'], ['R', 'R', 'R', 'R', 'R', 'R', 'G', 'G']] }
      let(:correct_response) { 
        a_hash_including(:past_results)
      }

      before do
        3.times do |i|
          post :guess, { name: 'Toninho do Diabo', code: code[i], game_key: game_key }, format: :json
        end
      end

      it do

        expect(response.status).to eq(200)
        is_expected.to match(correct_response)
      end

    end

    context 'when playing a multiplayer game' do
    end
  end  

end
