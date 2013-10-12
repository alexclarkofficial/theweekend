require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'The Weekend'" do
      visit root_path
      expect(page).to have_content('The Weekend')
    end


    it "should have the title 'The Weekend'" do
      visit root_path
      expect(page).to have_title("The Weekend")
    end
  end
end