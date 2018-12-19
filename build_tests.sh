#! /bin/bash

SRC_PATH="
    alu/adder/*.v 
    alu/multiplier/*.v
    alu/divider/*.v
    alu/*.v
    general/*.v
    datapath/*.v
"
mkdir -p build

iverilog -s adder_32_tb -o build/adder_32_tb $SRC_PATH
iverilog -s multiplier_32_tb -o build/multiplier_32_tb $SRC_PATH
iverilog -s divider_32_tb -o build/divider_32_tb $SRC_PATH
iverilog -s mux_4_tb -o build/mux_tb $SRC_PATH
iverilog -s alu_32_tb -o build/alu_32_tb $SRC_PATH
iverilog -s register_tb -o build/register_tb $SRC_PATH
iverilog -s left_shift_tb -o build/left_shift_tb $SRC_PATH
iverilog -s sign_extend_tb -o build/sign_extend_tb $SRC_PATH
