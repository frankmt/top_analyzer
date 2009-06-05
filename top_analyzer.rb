top_file = File.new(ARGV[0])

begin
    while (line = top_file.readline)
        line.chomp
        current_ timestamp = line.match('top - (\d\d:\d\d:\d\d)')[1] if line.match('top - (\d\d:\d\d:\d\d)')
    end
rescue EOFError
    top_file.close
end