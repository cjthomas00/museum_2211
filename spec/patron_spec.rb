require 'rspec'
require './lib/patron'

RSpec describe Patron do
  let(:patron_1) do
    Patron.new("Bob", 20)
  end

  describe '#initialize' do 
    it "exists" do
      expect(patron_1).to be_instance_of(Patron)
    end
    
    expect(patron_1.name).to eq("Bob")
    expect(patron_1.spending_money).to eq(20)
    expect(patron_1.interests).to eq([])
  end
end