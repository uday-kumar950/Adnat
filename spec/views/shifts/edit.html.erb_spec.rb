require 'rails_helper'

RSpec.describe "shifts/edit", type: :view do
  before(:each) do
    @shift = assign(:shift, Shift.create!(
      :user => nil,
      :start => "MyString",
      :finish => "MyString",
      :break => 1
    ))
  end

  it "renders the edit shift form" do
    render

    assert_select "form[action=?][method=?]", shift_path(@shift), "post" do

      assert_select "input[name=?]", "shift[user_id]"

      assert_select "input[name=?]", "shift[start]"

      assert_select "input[name=?]", "shift[finish]"

      assert_select "input[name=?]", "shift[break]"
    end
  end
end
