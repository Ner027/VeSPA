transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+mem_ip  -L blk_mem_gen_v8_4_6 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O2 xil_defaultlib.mem_ip xil_defaultlib.glbl

do {mem_ip.udo}

run

endsim

quit -force
