cmake_minimum_required(VERSION 2.8)
project(asm C)

enable_language(ASM_NASM)
set(CMAKE_ASM_NASM_FLAGS "${CMAKE_ASM_NASM_FLAGS} -f elf64 -Ox")
set(CMAKE_C_FLAGS "-O2")

add_definitions(-DAMOUNT_OF_NUMBERS=50)

add_executable(main main.c sum.asm)
