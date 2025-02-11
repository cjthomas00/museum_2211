require './lib/museum'
require './lib/patron'
require './lib/exhibit'

RSpec.describe Museum do
  let(:dmns) { Museum.new("Denver Museum of Nature and Science") }
  let(:gems_and_minerals) { Exhibit.new({name: "Gems and Minerals", cost: 0}) }
  let(:dead_sea_scrolls) { Exhibit.new({name: "Dead Sea Scrolls", cost: 10}) }
  let(:imax) { Exhibit.new({name: "IMAX",cost: 15}) }
  let(:patron_1) { Patron.new("Bob", 20) }
  let(:patron_2) { Patron.new("Sally", 20) }
  let(:patron_3) { Patron.new("Johnny", 5) }

  describe "#initialize" do
    it "exists" do 
      expect(dmns).to be_instance_of(Museum)
    end
    
    it "has attributes" do
      expect(dmns.name).to eq("Denver Museum of Nature and Science")
      expect(dmns.exhibits).to eq([])
    end
  end

  describe "#add_exhibit" do
    it "can add exhibits" do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)

      expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])
    end
  end

  describe "#recommend_exhibits" do
    it "can recommend exhibits" do 
      patron_1.add_interest("Dead Sea Scrolls")
      patron_1.add_interest("Gems and Minerals")
      patron_2.add_interest("Imax")

      expect(dmns.recommend_exhibits(patron_1)).to eq(["Dead Sea Scrolls", "Gems and Minerals"])
      expect(dmns.recommend_exhibits(patron_2)).to eq(["Imax"])
    end
  end


  describe "#patrons" do
    before do 
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)
      patron_1.add_interest("Gems and Minerals")
      patron_1.add_interest("Dead Sea Scrolls")
      patron_2.add_interest("Dead Sea Scrolls")
      patron_3.add_interest("Dead Sea Scrolls")
    end

    it "can hold patrons" do 
      expect(dmns.patrons).to eq([])
    end
  end

  describe '#admit' do 
    before do 
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)
      patron_1.add_interest("Gems and Minerals")
      patron_1.add_interest("Dead Sea Scrolls")
      patron_2.add_interest("Dead Sea Scrolls")
      patron_3.add_interest("Dead Sea Scrolls")
    end

    it 'can admit patrons' do
      dmns.admit(patron_1)
      dmns.admit(patron_2)
      dmns.admit(patron_3)

      expect(dmns.patrons).to eq([patron_1, patron_2, patron_3])
    end
  end

  describe "#patrons_by_exhibit_interest" do 
    before do 
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)
      dmns.admit(patron_1)
      dmns.admit(patron_2)
      dmns.admit(patron_3)
      patron_1.add_interest("Gems and Minerals")
      patron_1.add_interest("Dead Sea Scrolls")
      patron_2.add_interest("Dead Sea Scrolls")
      patron_3.add_interest("Dead Sea Scrolls")
    end

    it 'can show exhibits with patrons intersted in them' do 
      expected_hash = {
      "Gems and Minerals" => [patron_1],
      "Dead Sea Scrolls" => [patron_1, patron_2, patron_3],
      "Imax" => []}
# require 'pry'; binding.pry
      expect(dmns.patrons_by_exhibit_interest).to eq(expected_hash)
    end
  end

  describe '#ticket_lottery_contestants' do
    it 'can display lottery ticket patrons' do
      expect(dmns.ticket_lottery_contestants(dead_sea_scrolls)).to eq([patron_1, patron_2, patron_3])
    end
  end
end