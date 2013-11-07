require 'spec_helper'

describe Week do
  before do
    @week = Week.new(date: Date.new(2013,11,01))
  end

  subject { @week }

  it { should respond_to(:date) }
  
end
