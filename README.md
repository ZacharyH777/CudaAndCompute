# Run Once per folder you want to build
- `cmake -G "Visual Studio 16 2019" -DSOURCE_FOLDER=Hello_Cuda -B build`

# Run each time updated update
- `cmake --build build --config Release --target Hello_Cuda`

