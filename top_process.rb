class TopProcess
  
  @@all_processes = []
  attr_reader :pid
  
  def self.clear_all_processes
    @@all_processes = []
  end
  
  def self.find_or_create(pid)
    @@all_processes.each do |process|
      if process.pid == pid
        return process 
      end      
    end
    
    new_process = TopProcess.new(pid)
    @@all_processes << new_process
    new_process
  end
  
  def self.export_all_to_csv(timestamps)
    csv = ""
    @@all_processes.each do |process|
      csv << process.to_csv(timestamps) + "\n"
    end
    csv
  end
  
  def initialize(pid)
    @pid = pid
    @info = {}
  end
  
  def add_info(timestamp, info)
    @info[timestamp] = info
  end
  
  def get_info(timestamp)
    @info[timestamp] ? @info[timestamp] : "0"
  end
  
  def to_csv(timestamps)
    csv = @pid
    timestamps.each do |timestamp|
      csv << "," + get_info(timestamp)
    end
    csv
  end
  
end