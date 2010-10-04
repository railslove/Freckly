require "spec_helper"

describe Freckly::Entry do
  before do
    Freckly.token = "aaa"
    Freckly.subdomain = "test"
    stub_request(:any, /entries.xml/).to_return(:body => fixture("entries.xml"))
  end

  describe "Class methods" do
    describe "#find" do
      describe "the request" do
        before { Freckly::Entry.find_all_for_project(123) }
        subject { WebMock }

        it { should have_requested(:get, "http://test.letsfreckle.com/api/entries.xml").with(:headers => {"X-FreckleToken" => "aaa"}, :query => {:projects => "123"}) }
      end

      describe "the response" do
        before { @response = Freckly::Entry.find_all_for_project(123) }
        subject { @response }

        it { should be_a(Array) }

        specify { subject.first.should be_a(Freckly::Entry) }
      end
    end
  end

  describe "Initialization" do
    before(:all) { @entry = Freckly::Entry.find_all_for_project(123).first }
    subject { @entry }

    specify { subject.billable.should be_true }
    specify { subject.date.should_not be_nil }
    specify { subject.description.should == "freckle restful api test, bulk import" }
    specify { subject.id.should == 83601 }
    specify { subject.minutes.should == 120 }
  end
end