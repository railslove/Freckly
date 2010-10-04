require "spec_helper"

describe Freckly::Project do
  before do
    Freckly.token = "aaa"
    Freckly.subdomain = "test"
    stub_request(:any, /projects.xml$/).to_return(:body => fixture("projects.xml"))
  end

  describe "Class methods" do
    describe "#all" do
      describe "the request" do
        before { Freckly::Project.all }
        subject { WebMock }

        it { should have_requested(:get, "http://test.letsfreckle.com/api/projects.xml").with(:headers => {"X-FreckleToken" => "aaa"}) }
      end

      describe "the response" do
        before { @response = Freckly::Project.all }
        subject { @response }

        it { should be_a(Array) }

        specify { subject.first.should be_a(Freckly::Project) }
      end
    end
  end

  describe "Initialization" do
    before(:all) { @project = Freckly::Project.all.first }
    subject { @project }

    specify { subject.name.should == "TestProject1" }
    specify { subject.id.should == 1343 }
  end

  describe "#entries" do
    before { Freckly::Entry.stub!(:find_all_for_project).and_return([mock]) }
    before(:all) { @project = Freckly::Project.all.first }

    subject { @project.entries }

    it { should be_a(Array) }
  end
end