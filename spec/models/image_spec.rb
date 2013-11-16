require 'spec_helper'

describe Image do
  before { @image = Image.new }

  subject { @image }

  it { should respond_to (:image) }
  
end
