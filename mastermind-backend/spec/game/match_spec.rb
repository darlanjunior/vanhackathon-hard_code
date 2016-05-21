describe Match do
  subject(:match) { Match.new code_size }

  describe '#generate_code' do
    subject(:generate_code) { Match.generate_code code_size}
    
    let(:code_size) { 4 }
    it { expect(subject.size).to eq(code_size)  }
  end


end