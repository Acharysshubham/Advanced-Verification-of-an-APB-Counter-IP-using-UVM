# Open a VCD file for dumping waveforms
database -open waves -vcd

# Probe all signals in the 'tb' module and below
probe -create tb -all -depth all

# Run the simulation
run

# Close the database and exit
database -close
exit
