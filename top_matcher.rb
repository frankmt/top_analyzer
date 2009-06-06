class TopMatcher
  
  TIMESTAMP_REGEX = '^top - (\d\d:\d\d:\d\d)'
  INFO_REGEX = '(\d{1,9})\s*(\w*)\s*(\d*)\s*(\d*)\s*(\d*m?)\s*(\d*m?)\s*(\d*m?)\s*S\s*(\d*)\s*([\d[:punct:]]*)\s*([\d[:punct:]]*)\s*(\w*)'
  
  TOP_FIELDS = {
    :pid => 1,
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
    top_line.match(INFO_REGEX)[TOP_FIELDS[field]]
  end
  
end