transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {/home/francisco/Desktop/Projetos/VeSPA/dev-xico/Vivado/VeSPA.cache/compile_simlib/riviera}
vlib riviera/blk_mem_gen_v8_4_6
vlib riviera/xil_defaultlib

vlog -work blk_mem_gen_v8_4_6  -incr -v2k5 -l blk_mem_gen_v8_4_6 -l xil_defaultlib \
"../../../../VeSPA.gen/sources_1/bd/mem_ip/ipshared/bb55/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 -l blk_mem_gen_v8_4_6 -l xil_defaultlib \
"../../../bd/mem_ip/ip/mem_ip_blk_mem_gen_0_0/sim/mem_ip_blk_mem_gen_0_0.v" \
"../../../bd/mem_ip/sim/mem_ip.v" \

vlog -work xil_defaultlib \
"glbl.v"
