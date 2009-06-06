Top Analyzer
=================================

Prints to stdout a csv file containing information extracted from a batch top output
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
    m - memory percentage      

  -l, --limit=LIMIT                    monitoring lower limit
    If this variable is set processes that have all samples lower 
    than LIMIT won't be returned in the output.
