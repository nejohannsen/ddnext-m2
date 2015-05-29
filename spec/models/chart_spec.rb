require 'rails_helper'

RSpec.describe Chart, :type => :model do
  it "should conver level to experince" do
     result = Chart.convert_experince(3, 'level')
     expect(result).to eql(900)
  end

  it "should conver experince to level" do
     result = Chart.convert_experince(900, 'exp')
     expect(result).to eql(3)
  end
end
