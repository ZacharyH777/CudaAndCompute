cmake_minimum_required(VERSION 3.18)
project(CudaProject LANGUAGES CUDA)

# Set CUDA Compiler
set(CMAKE_CUDA_COMPILER "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.7/bin/nvcc")
set(CMAKE_CUDA_HOST_COMPILER "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/MSVC/14.29.30133/bin/HostX64/x64/cl.exe")

# Set CMake configuration types
set(CMAKE_CONFIGURATION_TYPES "Debug;Release;RelWithDebInfo;MinSizeRel" CACHE STRING "Available build configurations" FORCE)

# Expect SOURCE_FOLDER to be passed via -DSOURCE_FOLDER
if(NOT DEFINED SOURCE_FOLDER)
    message(FATAL_ERROR "You must specify the source folder using -DSOURCE_FOLDER=<path>")
endif()

# Extract the folder name to use as a unique target name
get_filename_component(TARGET_NAME ${SOURCE_FOLDER} NAME)

# Find all .cu files in the specified folder
file(GLOB_RECURSE CUDA_SOURCES "${SOURCE_FOLDER}/*.cu")

# Ensure source files exist
if(NOT CUDA_SOURCES)
    message(FATAL_ERROR "No .cu files found in the specified folder: ${SOURCE_FOLDER}")
endif()

# Debugging output for CUDA source files
foreach(file ${CUDA_SOURCES})
    message(STATUS "Adding CUDA source file: ${file}")
endforeach()

# Compile each CUDA source file into object files
add_library(${TARGET_NAME}_objects OBJECT ${CUDA_SOURCES})

# Link the compiled object files into an executable
add_executable(${TARGET_NAME} $<TARGET_OBJECTS:${TARGET_NAME}_objects>)

# Ensure proper CUDA runtime library selection
target_compile_options(${TARGET_NAME}_objects PRIVATE
    $<$<CONFIG:Release>:-Xcompiler="/MT">
    $<$<CONFIG:Debug>:-Xcompiler="/MDd">
)

# Configure output directories
set(TARGET_RUNTIME_OUTPUT_DIRECTORY "${SOURCE_FOLDER}/bin")
set(TARGET_ARCHIVE_OUTPUT_DIRECTORY "${SOURCE_FOLDER}/lib")

set_target_properties(${TARGET_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${TARGET_RUNTIME_OUTPUT_DIRECTORY}"
    ARCHIVE_OUTPUT_DIRECTORY "${TARGET_ARCHIVE_OUTPUT_DIRECTORY}"
    OUTPUT_NAME "main"  # Optional: Name the executable "main"
)

# Optional: Debugging message for project name
message(STATUS "Project ${TARGET_NAME} will generate ${TARGET_NAME}.vcxproj")