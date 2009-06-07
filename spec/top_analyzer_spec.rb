require File.dirname(__FILE__) + '/spec_helper'

describe TopAnalyzer do
  
  describe "analyze" do
   
    it "should extract memory percentage from top file" do
      analyzer = TopAnalyzer.new(default_options)
      create_input(analyzer)
      
      expected_results = "PID,18:06:41,18:06:51\n29921 - java,11.2,11.4\n1 - init,0.0,2.0\n"
      analyzer.get_results.should == expected_results
    end
    
    it "should extract cpu percentage from top file" do
      analyzer = TopAnalyzer.new(default_options.merge(:target => :cpu_percentage))
      create_input(analyzer)
      
      expected_results = "PID,18:06:41,18:06:51\n29921 - java,4,8\n1 - init,0.5,1.5\n"
      analyzer.get_results.should == expected_results
    end
    
    it "should extract resident memory from top file" do
      analyzer = TopAnalyzer.new(default_options.merge(:target => :resident_memory))
      create_input(analyzer)
      expected_results = "PID,18:06:41,18:06:51\n29921 - java,230400.0,233472.0\n1 - init,272,273\n"

      analyzer.get_results.should == expected_results
    end
    
    it "should extract resident memory from top file" do
      analyzer = TopAnalyzer.new(default_options.merge(:target => :virtual_memory))
      create_input(analyzer)
      expected_results = "PID,18:06:41,18:06:51\n29921 - java,841728.0,842752.0\n1 - init,10328,10329\n"

      analyzer.get_results.should == expected_results
    end
    
  end
  
  describe "limit option" do

    it "should not include processes which arent above the lower limit" do
      analyzer = TopAnalyzer.new(:limit => 100000, :target => :virtual_memory)
      create_input(analyzer)
      expected_results = "PID,18:06:41,18:06:51\n29921 - java,841728.0,842752.0\n"

      analyzer.get_results.should == expected_results      
    end
    
  end
  
  describe "time options" do
    
    it "should not include timestamps before start time" do
      analyzer = TopAnalyzer.new(default_options.merge(:start_time => DateTime.strptime("18:06:45", "%H:%M:%S")))
      create_input(analyzer)
      
      expected_results = "PID,18:06:51\n29921 - java,11.4\n1 - init,2.0\n"
      analyzer.get_results.should == expected_results
    end
    
    it "should not include timestamps after end time" do
      analyzer = TopAnalyzer.new(default_options.merge(:end_time => DateTime.strptime("18:06:45", "%H:%M:%S")))
      create_input(analyzer)
      
      expected_results = "PID,18:06:41\n29921 - java,11.2\n1 - init,0.0\n"
      analyzer.get_results.should == expected_results
    end
    
  end
  
end

def default_options
  {
    :target => :memory_percentage,
    :limit => 0
  }
end

def create_input(analyzer)
  analyzer.analyze("top - 18:06:41 up 33 days, 23:44,  6 users,  load average: 0.67, 0.95, 1.12")
                  #  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  analyzer.analyze("29921 tomcat    17   0  822m 225m  22m S    4 11.2   0:49.56 java")
  analyzer.analyze("1 root      15   0 10328  272  244 S    0.5  0.0   0:13.95 init") 
  analyzer.analyze("top - 18:06:51 up 33 days, 23:44,  6 users,  load average: 0.57, 0.92, 1.11")
  analyzer.analyze("29921 tomcat    17   0  823m 228m  22m S    8 11.4   0:50.39 java")
  analyzer.analyze("1 root      15   0 10329  273  245 S    1.5  2.0   0:13.95 init") 
end