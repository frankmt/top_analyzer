Top Analyzer
============

Prints to stdout a csv file containing information extracted from a batch top output
s
Usage: ruby top_analyzer FILE [OPTIONS]

Options:
  -l, -limit : lower limit of monitoring. 
      If this variable is set processes that have all sampled under 
      this limit won't be returned in the output.