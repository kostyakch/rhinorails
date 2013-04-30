require 'spec_helper'

describe "page_contents/index" do
  before(:each) do
    assign(:page_contents, [
      stub_model(PageContent,
        :name => "Name"
      ),
      stub_model(PageContent,
        :name => "Name"
      )
    ])
  end

  it "renders a list of page_contents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
