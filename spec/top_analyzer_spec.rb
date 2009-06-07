require File.dirname(__FILE__) + '/spec_helper'

describe TopAnalyzer do
  
  describe "analyze" do
    
    it "should extract memory percentage from top file as default" do
      tempfile = create_temp_topfile
      expected_results = <<-RESULT
      PID,18:06:41,18:06:51
      29921 - java,11.2,11.4
      1 - init,0.0,0.0
      5 - migration,0.0,0
      3 - ksoftirqd,0.0,0
      28059 - ndbd,0,5.2
      28064 - mysqld,0,2.1
      1250 - httpd,0,0.6
      9074 - httpd,0,0.6
      RESULT
      
      analyzer = TopAnalyzer.new(tempfile.open,{})
      analyzer.analyze.should == expected_results
    end
    
  end
  
end

def create_temp_topfile
  file = Tempfile.new("top")
  file.print <<-TOP
  top - 18:06:41 up 33 days, 23:44,  6 users,  load average: 0.67, 0.95, 1.12
  Tasks: 171 total,   1 running, 169 sleeping,   1 stopped,   0 zombie
  Cpu(s):  5.2%us,  0.4%sy,  0.0%ni, 91.7%id,  2.6%wa,  0.0%hi,  0.0%si,  0.0%st
  Mem:   2058200k total,  1496812k used,   561388k free,   100132k buffers
  Swap:  2040244k total,   146600k used,  1893644k free,   488228k cached

    PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                                                                                 
  29921 tomcat    17   0  822m 225m  22m S    4 11.2   0:49.56 java                                                                                                    
      1 root      15   0 10328  272  244 S    0  0.0   0:13.95 init                                                                                                    
      2 root      RT  -5     0    0    0 S    0  0.0   0:02.58 migration/0                                                                                             
      3 root      34  19     0    0    0 S    0  0.0   0:00.23 ksoftirqd/0                                                                                             
      4 root      RT  -5     0    0    0 S    0  0.0   0:00.00 watchdog/0                                                                                              
      5 root      RT  -5     0    0    0 S    0  0.0   0:01.31 migration/1
  
  top - 18:06:51 up 33 days, 23:44,  6 users,  load average: 0.57, 0.92, 1.11
  Tasks: 171 total,   1 running, 169 sleeping,   1 stopped,   0 zombie
  Cpu(s):  2.3%us,  0.2%sy,  0.0%ni, 93.1%id,  4.4%wa,  0.0%hi,  0.1%si,  0.0%st
  Mem:   2058200k total,  1499532k used,   558668k free,   100196k buffers
  Swap:  2040244k total,   146600k used,  1893644k free,   488396k cached

    PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                                                                                 
  29921 tomcat    17   0  823m 228m  22m S    8 11.4   0:50.39 java                                                                                                    
  28059 root      15   0 1185m 104m 3252 S    1  5.2   4:23.75 ndbd                                                                                                    
  28064 mysql     15   0  149m  41m 7468 S    0  2.1  12:30.07 mysqld                                                                                                  
   1250 apache    15   0  300m  11m 2092 S    0  0.6   0:00.54 httpd                                                                                                   
   9074 apache    15   0  300m  11m 2092 S    0  0.6   0:00.45 httpd                                                                                                   
  30194 contents  15   0 12720 1120  804 R    0  0.1   0:00.01 top                                                                                                     
      1 root      15   0 10328  272  244 S    0  0.0   0:13.95 init
  TOP
  file.flush
  file
end