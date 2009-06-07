require File.dirname(__FILE__) + '/spec_helper'

describe TopMatcher do
  
  describe "new top matching" do
    
    it "should know if its a new top line" do
      line = "top - 18:06:41 up 33 days, 23:44,  6 users,  load average: 0.67, 0.95, 1.12"
      TopMatcher.new_top?(line).should be_true
    end
    
    it "should know when its not a new top line" do
      TopMatcher.new_top?("").should be_false
      TopMatcher.new_top?("Tasks: 171 total,   1 running, 169 sleeping,   1 stopped,   0 zombie").should be_false
      TopMatcher.new_top?("Cpu(s):  5.2%us,  0.4%sy,  0.0%ni, 91.7%id,  2.6%wa,  0.0%hi,  0.0%si,  0.0%st").should be_false
      TopMatcher.new_top?("Mem:   2058200k total,  1496812k used,   561388k free,   100132k buffers").should be_false
      TopMatcher.new_top?("Swap:  2040244k total,   146600k used,  1893644k free,   488228k cached").should be_false
      TopMatcher.new_top?("  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND").should be_false                                                                                      
      TopMatcher.new_top?("29921 tomcat    17   0  822m 225m  22m S    4 11.2   0:49.56 java").should be_false
    end
    
  end
  
  describe "timestamp matching" do
    
    it "should get the timestamp from a new top line" do
      TopMatcher.extract_timestamp("top - 18:06:41 up 33 days, 23:44,  6 users,  load average: 0.67, 0.95, 1.12").should == "18:06:41"
      TopMatcher.extract_timestamp("top - 18:06:51 up 33 days, 23:44,  6 users,  load average: 0.57, 0.92, 1.11").should == "18:06:51"
    end
    
  end
  
  describe "info matching" do

    it "should know when its a info line" do
      line = "29921 tomcat    17   0  822m 225m  22m S    4 11.2   0:49.56 java"
      TopMatcher.info?(line).should be_true
    end
    
    it "should know when its not a info line" do
      TopMatcher.info?("top - 18:06:41 up 33 days, 23:44,  6 users,  load average: 0.67, 0.95, 1.12").should be_false
      TopMatcher.info?("").should be_false
      TopMatcher.info?("Tasks: 171 total,   1 running, 169 sleeping,   1 stopped,   0 zombie").should be_false
      TopMatcher.info?("Cpu(s):  5.2%us,  0.4%sy,  0.0%ni, 91.7%id,  2.6%wa,  0.0%hi,  0.0%si,  0.0%st").should be_false
      TopMatcher.info?("Mem:   2058200k total,  1496812k used,   561388k free,   100132k buffers").should be_false
      TopMatcher.info?("Swap:  2040244k total,   146600k used,  1893644k free,   488228k cached").should be_false
      TopMatcher.info?("  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND").should be_false                                                                                      
    end
    
    it "should extract pid" do
      line = "29921 tomcat    17   0  822m 225m  22m S    4 11.2   0:49.56 java"
      TopMatcher.extract_info(line,:pid).should == "29921"
    end
    
    it "should extract memory percentage" do
      line = "29921 tomcat    17   0  822m 225m  22m S    4 11.2   0:49.56 java"
      TopMatcher.extract_info(line,:memory_percentage).should == "11.2"
    end
    
    it "should extract cpu percentage" do
      line = "29921 tomcat    17   0  822m 225m  22m S    4 11.2   0:49.56 java"
      TopMatcher.extract_info(line,:cpu_percentage).should == "4"
    end
    
    it "should extract resident memory" do
      line = "29921 tomcat    17   0  822 225m  22m S    4 11.2   0:49.56 java"
      TopMatcher.extract_info(line,:resident_memory).should == "822"
    end
    
    it "should extract resident memory in megabytes" do
      line = "29921 tomcat    17   0  822m 225m  22m S    4 11.2   0:49.56 java"
      TopMatcher.extract_info(line,:resident_memory).should == "841728.0" #822 * 1024
    end

    it "should extract virtual memory" do
      line = "29921 tomcat    17   0  822m 225  22m S    4 11.2   0:49.56 java"
      TopMatcher.extract_info(line,:virtual_memory).should == "225"
    end
    
    it "should extract virtual memory in megabytes" do
      line = "29921 tomcat    17   0  822m 225m  22m S    4 11.2   0:49.56 java"
      TopMatcher.extract_info(line,:virtual_memory).should == "230400.0" #225 * 1024
    end
    
    
    it "should extract process name" do
      line = "29921 tomcat    17   0  822m 225m  22m S    4 11.2   0:49.56 java"
      TopMatcher.extract_info(line,:process_name).should == "java"
    end
    
    
  end
  
  
end