require 'rails_helper'

RSpec.describe "shifts/new", type: :view do
  before(:each) do
    assign(:shift, Shift.new(
      :user => nil,
      :start => "MyString",
      :finish => "MyString",
      :break => 1
    ))
  end

  it "renders new shift form" do
    render

    assert_select "form[action=?][method=?]", shifts_path, "post" do

      assert_select "input[name=?]", "shift[user_id]"

      assert_select "input[name=?]", "shift[start]"

      assert_select "input[name=?]", "shift[finish]"

      assert_select "input[name=?]", "shift[break]"
    end
  end
end
