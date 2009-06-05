require 'top_process'

describe TopProcess do
  
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