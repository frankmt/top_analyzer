class TopProcess
  
  # @@processes = []
  attr_reader :pid
  
  def self.find_or_create(pid)
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