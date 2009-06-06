require 'top_process'

describe TopProcess do
  
  describe "class methods" do
    
    before(:each) do
      TopProcess.clear_all_processes
    end
    
    describe "find_or_create" do

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
        test_process.get_info("12:03:41").should == "0"    
      end

    end

    describe "export_all_to_csv" do
      
      it "should export all processes to csv" do
        timestamps = ["10:00:00", "10:00:10", "10:00:20"]

        process = TopProcess.find_or_create("1234")
        process.add_info(timestamps[0],"5")
        process.add_info(timestamps[2],"6.5")
        process.add_info(timestamps[1],"7")
        
        process = TopProcess.find_or_create("4321")
        process.add_info(timestamps[0],"15")
        process.add_info(timestamps[2],"16.5")
        process.add_info(timestamps[1],"17")

        csv = "1234,5,7,6.5\n4321,15,17,16.5\n"
        TopProcess.export_all_to_csv(timestamps).should == csv
      end
      
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
    process.get_info("12:03:41").should == "0"    
  end
  
  describe "description" do

    it "should export process info to csv according to passed timestamps" do
      timestamps = ["10:00:00", "10:00:10", "10:00:20"]
      process = TopProcess.new("1234")
      process.add_info(timestamps[0],"5")
      process.add_info(timestamps[2],"6.5")
      process.add_info(timestamps[1],"7")
      process.to_csv(timestamps).should == "1234,5,7,6.5"
    end  
    
    it "should return 0 for timestamps that dont exist for the process" do
      timestamps = ["10:00:00", "10:00:10", "10:00:20", "10:00:30", "10:00:40"]
      process = TopProcess.new("1234")
      process.add_info(timestamps[0],"5")
      process.add_info(timestamps[2],"6.5")
      process.add_info(timestamps[1],"7")
      process.to_csv(timestamps).should == "1234,5,7,6.5,0,0"      
    end

  end
  

  
end