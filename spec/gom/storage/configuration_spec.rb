require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

describe GOM::Storage::Configuration do

  before :each do
    GOM::Storage::Configuration.read File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "storage.configuration"))
  end

  describe "[]" do

    before :each do
      @configuration = GOM::Storage::Configuration[:test_storage]
    end

    it "should return the configuration value" do
      @configuration[:test].should == "test value"
    end

  end

  describe "read" do

    before :each do
      @configuration = GOM::Storage::Configuration[:test_storage]
    end

    it "should read the configuration file" do
      @configuration.should be_instance_of(GOM::Storage::Configuration)
    end

    it "should initialize the right adapter class" do
      @configuration.adapter_class.should == FakeAdapter
    end

    it "should create an adapter instance if requested" do
      adapter = Object.new
      FakeAdapter.should_receive(:new).with(@configuration).and_return(adapter)
      @configuration.adapter.should == adapter
    end

  end

  describe "default" do

    it "should select the first configuration" do
      GOM::Storage::Configuration.default.should == GOM::Storage::Configuration[:test_storage]
    end

    it "should raise StandardError if no configuration loaded" do
      GOM::Storage::Configuration.instance_variable_set :@configurations, { }
      lambda do
        GOM::Storage::Configuration.default
      end.should raise_error(StandardError)
    end

  end

end
