class TopMatcher
  
  TIMESTAMP_REGEX = '^top - (\d\d:\d\d:\d\d)'
  INFO_REGEX = '(\d{1,9})\s*(\w*)\s*(\d*)\s*(\d*)\s*([\d[:punct:]]*m?)\s*([\d[:punct:]]*m?)\s*([\d[:punct:]]*)m?\s*S\s*([\d[:punct:]]*)\s*([\d[:punct:]]*)\s*([\d[:punct:]]*)\s*(\w*)'
  MB = 1024.0
  
  TOP_FIELDS = {
    :pid => 1,
    :virtual_memory => 5,
    :resident_memory => 6,
    :cpu_percentage => 8,
    :memory_percentage => 9,
    :process_name => 11
  }
  
  def self.new_top?(top_line)
    not top_line.match(TIMESTAMP_REGEX).nil?
  end
  
  def self.extract_timestamp(top_line)
    top_line.match(TIMESTAMP_REGEX)[1]
  end
  
  def self.info?(top_line)
    not top_line.match(INFO_REGEX).nil?
  end
  
  def self.extract_info(top_line, field)
    info = top_line.match(INFO_REGEX)[TOP_FIELDS[field]]
    info.include?("m") ? TopMatcher.to_megabyte(info) : info
  end
  
  private 
  
  def self.to_megabyte(bytes_str)
    (bytes_str.to_f * MB).to_s
  end
  
  
end