Top Analyzer
=================================

Prints to stdout a csv file containing information extracted from a batch top output.  
Developed against top: procps version 3.2.7

The input file can be obtained via a top command, as in this example:  
  # Top  
  # -b -> batch mode  
  # -n -> number of samples  
  # -d -> delay between samples  
  top -b -n 360 -d 10  

Usage: ruby top_analyzer FILE [OPTIONS]

  -t, --target=TARGET                  monitoring target
    Defines which variable from the top command will be analyzed
    Current TARGET options are:
    r - resident memory
    v - virtual memory
    c - cpu percentage
    m - memory percentage (default)      

  -l, --limit=LIMIT                    monitoring lower limit
    If this variable is set, processes that have all samples lower 
    than LIMIT won't be returned in the output.

  -s, --starttime=TIME                 monitoring start time
    If this variable is set only samples obtained after TIME
    will be considered. TIME must be provided in the HH:MM:SS 
    format

  -e, --endtime=TIME                   monitoring start time
    If this variable is set only samples obtained before TIME
    will be considered. TIME must be provided in the HH:MM:SS 
    format
