class TopProcess
  
  @@all_processes = []
  attr_reader :pid
  
  def self.clear_all_processes
    @@all_processes = []
  end
  
  def self.find_or_create(pid, name)
    @@all_processes.each do |process|
      if process.pid == pid
        return process 
      end      
    end
    
    new_process = TopProcess.new(pid, name)
    @@all_processes << new_process
    new_process
  end
  
  def self.export_all_to_csv(timestamps)
    csv = ""
    @@all_processes.each do |process|
      csv_process = process.to_csv(timestamps,0.5)
      csv << csv_process + "\n" if csv_process
    end
    csv
  end
  
  def initialize(pid, name)
    @pid = pid
    @name = name
    @info = {}
  end
  
  def get_id
    [@pid,@name].join(" - ")
  end
  
  def add_info(timestamp, info)
    @info[timestamp] = info
  end
  
  def get_info(timestamp)
    @info[timestamp] ? @info[timestamp] : "0"
  end
  
  def to_csv(timestamps, limit=0)
    if limit > 0
      return nil if not reaches_limit(limit)
    end
    
    csv = get_id
    timestamps.each do |timestamp|
      csv << "," + get_info(timestamp)
    end
    csv
  end
  
  private
  
  def reaches_limit(limit)
    @info.each_value do |value|
      return true if value.to_i > limit
    end
    false
  end
  
end