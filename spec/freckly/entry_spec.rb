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

        it { should have_requested(:get, "https://test.letsfreckle.com/api/entries.xml").with(:headers => {"X-FreckleToken" => "aaa"},
                                                                                              :query => {:search => {
                                                                                              :projects => "123,192"}
                                                                                             }) }
      end

      describe "the request after changing the token and subdomain" do
        subject { WebMock::API }
        Freckly.token = "bbb"
        Freckly.subdomain = "api"

        it { should have_requested(:get, "https://api.letsfreckle.com/api/entries.xml").with(:headers => {"X-FreckleToken" => "bbb"},
                                                                                              :query => {:search => {
                                                                                              :projects => "123,192"}
                                                                                             }) }
      end

      context "when returning something" do
        describe "the response" do
          subject { @response }

          it { should be_a(Array) }

          its(:first) { should be_a(Freckly::Entry) }
        end
      end

      context "when returning nothing" do
        before { stub_request(:any, /entries/) }

        subject { Freckly::Entry.all(:projects => %w{123 192}) }

        it { should be_a(Array) }
        it { should be_empty }
      end
    end

    describe "#count" do
      before do
        @response = Freckly::Entry.count(:projects => %w{123 192})
      end

      describe "the request" do
        subject { WebMock::API }

        it { should have_requested(:get, "https://test.letsfreckle.com/api/entries.xml").with(:headers => {"X-FreckleToken" => "aaa"},
                                                                                              :query => {:search => {
                                                                                              :projects => "123,192"}
                                                                                             }) }
      end

      context "when returning something" do
        describe "the response" do
          subject { @response }

          it { should eql(2) }
        end
      end

      context "when returning nothing" do
        before { stub_request(:any, /entries/) }

        subject { Freckly::Entry.count(:projects => %w{123 192}) }

        it { should eql(0) }
      end
    end
  end

  describe "Initialization" do
    let(:entry) { Freckly::Entry.all(:projects => 123).first }
    subject { entry }

    its(:billable) { should be_true }
    its(:date) { should_not be_nil }
    its(:description) { should == "freckle restful api test, bulk import" }
    its(:id) { should == 83601 }
    its(:minutes) { should == 120 }
  end
end
