require 'rails_helper'

RSpec.describe Character, :type => :model do

  it "set intial statuses to false and step = name" do
    char = Character.new()
    char.initalize_status_and_step
    char.status.each do |key, value|
      expect(value).to eql(false)
    end
    expect(char.next_step).to eql('name')
  end

  it "set status if name is filled out to name true" do
    char = Character.new(name: "Data")
    char.status = {name: false, proficiency: false}
    char.set_status
    expect(char.status[:name]).to eql(true)
  end

  it "set next step after name set should set to" do
    char = Character.new(name: "Data")
    char.status = {name: true, proficiency: false}
    char.set_next_step
    expect(char.next_step).to eql("proficiency")
  end

  it "should increase the level by one" do
    char = Character.new
    char.level = 1
    char.increase_level
    expect(char.level).to eql(2)
  end

  it "should decrease the level by one" do
    char = Character.new
    char.level = 2
    char.decrease_level
    expect(char.level).to eql(1)
  end

  it "should validate level between 1 and 20" do
    char = Character.new
    char.level = 21
    expect(char.valid?).to be_falsey
    char.level = 0
    expect(char.valid?).to be_falsey
  end

  it "should callback before save and set level if experince changed" do
    char = Character.create()
    char.level = 2
    char.save
    char = Character.first
    expect(char.experince).to_not eql(0)
  end

  it "should callback before save and set level if experince changed" do
    char = Character.create()
    char.experince = 900
    char.save
    char = Character.first
    expect(char.level).to_not eql(1)
  end


end
