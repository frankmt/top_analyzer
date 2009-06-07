require 'rake'
 
begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "top_analyzer"
    s.summary = %Q{Top Analyzer is a gem to analyzer top batch files, producing a csv output.}
    s.email = "frank@franktrindade.com"
    s.homepage = "http://github.com/frankmt/top_analyzer"
    s.description = "Top Analyzer is a gem to analyzer top batch files, producing a csv output."
    s.authors = ["Francisco Trindade"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
 
require 'spec/rake/spectask'
 
desc "Run the specs under spec/"
Spec::Rake::SpecTask.new(:spec) do |t|
 t.spec_opts = ['--options']
 t.spec_files = FileList['spec/*_spec.rb']
end
 
task :default => :spec
