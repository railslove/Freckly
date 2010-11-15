require "spec_helper"

describe Freckly::Entry do
  before do
    Freckly.token = "aaa"
    Freckly.subdomain = "test"
    stub_request(:any, /entries/).to_return(:body => fixture("entries.xml"))
  end

  describe "Class methods" do
    describe "#all" do
      before do
        @response = Freckly::Entry.all(:projects => %w{123 192})
      end

      describe "the request" do
        subject { WebMock::API }

        it { should have_requested(:get, "http://test.letsfreckle.com/api/entries.xml").with(:headers => {"X-FreckleToken" => "aaa"}, :query => {:projects => "123,192"}) }
      end

      describe "the response" do
        subject { @response }

        it { should be_a(Array) }

        its(:first) { should be_a(Freckly::Entry) }
      end
    end
  end

  describe "Initialization" do
    let(:entry) { Freckly::Entry.find_all_for_project(123).first }
    subject { entry }

    its(:billable) { should be_true }
    its(:date) { should_not be_nil }
    its(:description) { should == "freckle restful api test, bulk import" }
    its(:id) { should == 83601 }
    its(:minutes) { should == 120 }
  end
end