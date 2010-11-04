require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

describe GOM::Storage do

  before :each do
    @id = "test_storage:object_1"
    @object = Object.new
  end

  describe "fetch" do

    before :each do
      @fetcher = Object.new
      @fetcher.stub!(:perform)
      @fetcher.stub!(:object).and_return(@object)
      GOM::Storage::Fetcher.stub!(:new).and_return(@fetcher)
    end

    it "should initialize the fetcher correctly" do
      GOM::Storage::Fetcher.should_receive(:new).with(@id, @object).and_return(@fetcher)
      GOM::Storage.fetch @id, @object
    end

    it "should perform a fetch" do
      @fetcher.should_receive(:perform)
      GOM::Storage.fetch @id
    end

    it "should return the object" do
      GOM::Storage.fetch(@id).should == @object
    end

  end

  describe "store" do

    before :each do
      @storage_name = "another_test_storage"
      @saver = Object.new
      @saver.stub!(:perform)
      @saver.stub!(:id).and_return(@id)
      GOM::Storage::Saver.stub!(:new).and_return(@saver)
    end

    it "should initialize the saver correctly" do
      GOM::Storage::Saver.should_receive(:new).with(@object, @storage_name).and_return(@saver)
      GOM::Storage.store @object, @storage_name
    end

    it "should perform a store" do
      @saver.should_receive(:perform)
      GOM::Storage.store @object
    end

  end

  describe "remove" do

    before :each do
      @remover = Object.new
      @remover.stub!(:perform)
      GOM::Storage::Remover.stub!(:new).and_return(@remover)
    end

    it "should initialize the remover correctly" do
      GOM::Storage::Remover.should_receive(:new).with(@object).and_return(@remover)
      GOM::Storage.remove @object
    end

    it "should perform a remove" do
      @remover.should_receive(:perform)
      GOM::Storage.remove @object
    end

  end

end
