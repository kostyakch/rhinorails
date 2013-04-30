require 'spec_helper'

describe "page_contents/new" do
  before(:each) do
    assign(:page_content, stub_model(PageContent,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new page_content form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", page_contents_path, "post" do
      assert_select "input#page_content_name[name=?]", "page_content[name]"
    end
  end
end
