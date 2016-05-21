describe Match do
  describe '#generate_code' do
    subject(:generate_code) { Match.generate_code code_size}
    
    let(:code_size) { 4 }
    it 'generates a code with the appropriate size' do
      expect(subject.size).to eq(code_size) 
    end
  end

  describe '#parse_guess' do
    subject(:match) { Match.new(code_size).parse_guess(guess) }

    let(:code_size) { 4 }
    let(:code) { [:R, :R, :G, :B]}

    before { allow(Match.generate_code).to receive(code_size).and_return(code) }

    it "validates the correct guess" do 
      guess = [:R, :R, :G, :B]

      is_expected.to eq( {exact: 4, near: 0} )
    end

    it "shows near corrects" do 
      guess = [:R, :R, :B, :Y]

      is_expected.to eq( {exact: 2, near: 1} )
    end

    it "doesn't duplicate nears" do 
      guess = [:Y, :G, :Y, :G]

      is_expected.to eq( {exact: 0, near: 1} )
    end

    it "refuses wrong guesses" do 
      guess = [:Y, :Y, :Y, :Y]

      is_expected.to eq( {exact: 0, near: 0} )
    end

  end


end