require 'spec_helper'

describe "page_contents/edit" do
  before(:each) do
    @page_content = assign(:page_content, stub_model(PageContent,
      :name => "MyString"
    ))
  end

  it "renders the edit page_content form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", page_content_path(@page_content), "post" do
      assert_select "input#page_content_name[name=?]", "page_content[name]"
    end
  end
end
