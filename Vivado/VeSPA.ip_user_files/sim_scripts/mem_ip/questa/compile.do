vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/blk_mem_gen_v8_4_6
vlib questa_lib/msim/xil_defaultlib

vmap blk_mem_gen_v8_4_6 questa_lib/msim/blk_mem_gen_v8_4_6
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work blk_mem_gen_v8_4_6 -64 -incr -mfcu  \
"../../../../VeSPA.gen/sources_1/bd/mem_ip/ipshared/bb55/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  \
"../../../bd/mem_ip/ip/mem_ip_blk_mem_gen_0_0/sim/mem_ip_blk_mem_gen_0_0.v" \
"../../../bd/mem_ip/sim/mem_ip.v" \

vlog -work xil_defaultlib \
"glbl.v"

