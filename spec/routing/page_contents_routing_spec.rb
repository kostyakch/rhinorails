require "spec_helper"

describe PageContentsController do
  describe "routing" do

    it "routes to #index" do
      get("/page_contents").should route_to("page_contents#index")
    end

    it "routes to #new" do
      get("/page_contents/new").should route_to("page_contents#new")
    end

    it "routes to #show" do
      get("/page_contents/1").should route_to("page_contents#show", :id => "1")
    end

    it "routes to #edit" do
      get("/page_contents/1/edit").should route_to("page_contents#edit", :id => "1")
    end

    it "routes to #create" do
      post("/page_contents").should route_to("page_contents#create")
    end

    it "routes to #update" do
      put("/page_contents/1").should route_to("page_contents#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/page_contents/1").should route_to("page_contents#destroy", :id => "1")
    end

  end
end
