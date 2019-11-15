require 'rails_helper'

RSpec.describe "shifts/show", type: :view do
  before(:each) do
    @shift = assign(:shift, Shift.create!(
      :user => nil,
      :start => "Start",
      :finish => "Finish",
      :break => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Start/)
    expect(rendered).to match(/Finish/)
    expect(rendered).to match(/2/)
  end
end
