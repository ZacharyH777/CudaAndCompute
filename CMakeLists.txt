cmake_minimum_required(VERSION 3.18)
project(CudaProject LANGUAGES CUDA)

# Set Definitions
set(CMAKE_CUDA_COMPILER "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.7/bin/nvcc")
set(CMAKE_CUDA_HOST_COMPILER "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/MSVC/14.29.30133/bin/HostX64/x64/cl.exe")
set(CMAKE_CONFIGURATION_TYPES "Debug;Release;RelWithDebInfo;MinSizeRel" CACHE STRING "Available build configurations" FORCE)

# Enforce D-Source
if(NOT DEFINED SOURCE_FOLDER)
    message(FATAL_ERROR "You must specify the source folder using -DSOURCE_FOLDER=<path>")
endif()

#Set Target Name for organization
get_filename_component(TARGET_NAME ${SOURCE_FOLDER} NAME)

file(GLOB_RECURSE CUDA_SOURCES "${SOURCE_FOLDER}/*.cu")
if(NOT CUDA_SOURCES)
    message(FATAL_ERROR "No .cu files found in the specified folder: ${SOURCE_FOLDER}")
endif()

# Debugging output for CUDA source files
foreach(file ${CUDA_SOURCES})
    message(STATUS "Adding CUDA source file: ${file}")
endforeach()

# Compile into object files
add_library(${TARGET_NAME}_objects OBJECT ${CUDA_SOURCES})
add_executable(${TARGET_NAME} $<TARGET_OBJECTS:${TARGET_NAME}_objects>)
target_compile_options(${TARGET_NAME}_objects PRIVATE
    $<$<CONFIG:Release>:-Xcompiler="/MT">
    $<$<CONFIG:Debug>:-Xcompiler="/MDd">
)

# More Organization
set(TARGET_RUNTIME_OUTPUT_DIRECTORY "${SOURCE_FOLDER}/bin")
set(TARGET_ARCHIVE_OUTPUT_DIRECTORY "${SOURCE_FOLDER}/lib")

set_target_properties(${TARGET_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${TARGET_RUNTIME_OUTPUT_DIRECTORY}"
    ARCHIVE_OUTPUT_DIRECTORY "${TARGET_ARCHIVE_OUTPUT_DIRECTORY}"
    OUTPUT_NAME "main"
)