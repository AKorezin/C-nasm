cmake_minimum_required(VERSION 2.8)

enable_language(ASM_NASM)
set(CMAKE_ASM_NASM_FLAGS "${CMAKE_ASM_NASM_FLAGS} -f elf64")
set(CMAKE_CXX_FLAGS "-O2")
set(CMAKE_C_FLAGS "-O2")
add_executable(main main.c add.asm)
