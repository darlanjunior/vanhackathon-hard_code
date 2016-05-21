describe Match do
  describe '#generate_code' do
    subject(:generate_code) { Match.generate_code code_size}
    
    let(:code_size) { 4 }
    it 'generates a code with the appropriate size' do
      expect(subject.size).to eq(code_size) 
    end
  end

  describe '#parse_guess' do
    subject(:match) { Match.new(code_size: code_size).parse_guess(guess) }

    let(:code_size) { 4 }
    let(:code) { [:R, :R, :G, :B]}

    before { allow(Match).to receive(:generate_code).with(code_size).and_return(code) }

    let(:guess) { [:R, :R, :G, :B] }
    it "validates the correct guess" do 
      is_expected.to eq( {exact: 4, near: 0} )
    end

    let(:guess) { [:R, :R, :B, :Y] }
    it "shows near corrects" do 
      is_expected.to eq( {exact: 2, near: 1} )
    end

    let(:guess) { [:Y, :G, :Y, :G] }
    it "doesn't duplicate nears" do 
      is_expected.to eq( {exact: 0, near: 1} )
    end

    let(:guess) { [:Y, :Y, :Y, :Y] }
    it "refuses wrong guesses" do 
      is_expected.to eq( {exact: 0, near: 0} )
    end

  end


end