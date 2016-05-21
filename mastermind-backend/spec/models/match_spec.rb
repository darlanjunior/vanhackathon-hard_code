describe Match do
  describe '#generate_code' do
    subject(:generate_code) { Match.generate_code code_size}
    
    let(:code_size) { Game.code_size }
    it 'generates a code with the appropriate size' do
      expect(subject.size).to eq(code_size) 
    end
  end

  describe '#parse_guess' do
    subject(:match) { Match.new(code_size: code_size).parse_guess(guess) }

    # testing with just 4 to simplify, as the algorithm is the same for any size
    let(:code_size) { 4 }
    let(:code) { [:R, :R, :G, :B]}

    before { allow(Match).to receive(:generate_code).with(code_size).and_return(code) }

    context 'when guess is correct' do
      let(:guess) { [:R, :R, :G, :B] }
      it { is_expected.to eq( {exact: 4, near: 0} ) }
    end

    context 'when guess is off by one' do
      let(:guess) { [:R, :R, :B, :G] }
      it { is_expected.to eq( {exact: 2, near: 2} ) }
    end

    context 'when guess has two nears' do
      let(:guess) { [:Y, :G, :Y, :G] }
      it { is_expected.to eq( {exact: 0, near: 1} ) }
    end

    context 'when guess is incorrect' do
      let(:guess) { [:Y, :Y, :Y, :Y] }
      it { is_expected.to eq( {exact: 0, near: 0} ) }
    end
  end

end