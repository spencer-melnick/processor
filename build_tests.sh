#! /bin/bash

SRC_PATH="
    alu/adder/*.v 
    alu/multiplier/*.v
    alu/divider/*.v
    general/*.v
"
mkdir -p build

iverilog -s adder_32_tb -o build/adder_32_tb $SRC_PATH
iverilog -s multiplier_32_tb -o build/multiplier_32_tb $SRC_PATH
iverilog -s divider_32_tb -o build/divider_32_tb $SRC_PATH
iverilog -s mux_4_tb -o build/mux_tb $SRC_PATH
