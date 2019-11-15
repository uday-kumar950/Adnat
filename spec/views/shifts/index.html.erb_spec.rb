require 'rails_helper'

RSpec.describe "shifts/index", type: :view do
  before(:each) do
    assign(:shifts, [
      Shift.create!(
        :user => nil,
        :start => "Start",
        :finish => "Finish",
        :break => 2
      ),
      Shift.create!(
        :user => nil,
        :start => "Start",
        :finish => "Finish",
        :break => 2
      )
    ])
  end

  it "renders a list of shifts" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Start".to_s, :count => 2
    assert_select "tr>td", :text => "Finish".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
