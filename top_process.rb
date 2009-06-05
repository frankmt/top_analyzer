class TopProcess
  
  @@all_processes = []
  attr_reader :pid
  
  def self.find_or_create(pid)
    @@all_processes.each do |process|
      return process if process.pid == pid
    end
    
    new_process = TopProcess.new(pid)
    @@all_processes << new_process
    new_process
  end
  
  def initialize(pid)
    @pid = pid
    @info = {}
  end
  
  def add_info(timestamp, info)
    @info[timestamp] = info
  end
  
  def get_info(timestamp)
    @info[timestamp] ? @info[timestamp] : 0
  end
  
end