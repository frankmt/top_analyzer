require 'top_process'

describe TopProcess do
  
  describe "class methods" do

    it "should create new process when it does not exist" do
      process = TopProcess.new(1234)
      TopProcess.should_receive(:new).with(1234).and_return(process)
      test_process = TopProcess.find_or_create(1234)
      test_process.should == process
    end
    
    it "should find process when it does exist" do
      old_process = TopProcess.new(4321)
      old_process.add_info("12:03:41","85%")
      
      test_process = TopProcess.find_or_create(4321)
      test_process.get_info("12:03:41").should == 0    
    end
    

  end
  
  it "should initialize pid" do
    process = TopProcess.new(1234)
    process.pid.should == 1234
  end
  
  it "should add info" do
    process = TopProcess.new(1234)
    process.add_info("12:03:41","85%")
    process.get_info("12:03:41").should == "85%"
  end
  
  it "should return 0 when there is no info" do
    process = TopProcess.new(1234)
    process.get_info("12:03:41").should == 0    
  end
  
end