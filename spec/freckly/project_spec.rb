require "spec_helper"

describe Freckly::Project do
  before do
    Freckly.token = "aaa"
    Freckly.subdomain = "test"
    stub_request(:any, /projects.xml/).to_return(:body => fixture("projects.xml"))
  end

  describe "Class methods" do
    describe "#all" do
      describe "the request" do
        before { Freckly::Project.all }
        subject { WebMock }

        it { should have_requested(:get, "https://test.letsfreckle.com/api/projects.xml").with(:headers => {"X-FreckleToken" => "aaa"}) }
      end

      describe "the response" do
        before { @response = Freckly::Project.all }
        subject { @response }

        it { should be_a(Array) }

        specify { subject.first.should be_a(Freckly::Project) }
      end
    end

    describe "#count" do
      describe "the request" do
        before { Freckly::Project.count }
        subject { WebMock }

        it { should have_requested(:get, "https://test.letsfreckle.com/api/projects.xml").with(:headers => {"X-FreckleToken" => "aaa"}) }
      end

      describe "the response" do
        before { @response = Freckly::Project.count }
        subject { @response }

        it { should eql(2) }
      end
    end
  end

  describe "Initialization" do
    let(:project) { Freckly::Project.all.first }
    subject { project }

    specify { subject.name.should == "TestProject1" }
    specify { subject.id.should == 1343 }
  end

  describe "#entries" do
    before do
      stub_request(:any, /entries/).to_return(:body => fixture("entries.xml"))
      Freckly::Entry.stub!(:find_all_for_project).and_return([mock])
    end

    let(:project) { Freckly::Project.all.first }

    subject { project.entries }

    it { should be_a(Array) }
  end
end