# Catch and exit on any error in this script
onerror { exit -f -code 11 }
# Create design library
vlib work
# Create and open project
project new . compile_project
project open compile_project
# Add source files to project
set SRC1 "G:/dev_2025_local/biowear/high-pass-vhdl-filter-pta/vhdl"
project addfile "$SRC1/High_pass_filter.vhd"
# Calculate compilation order
project calculateorder
set compcmd [project compileall -n]
# Close project
project close
# Compile all files and report error
eval $compcmd
exit
