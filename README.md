# Run Once per folder you want to build
- `cmake -G "Visual Studio 16 2019" -DSOURCE_FOLDER=Hello_Cuda -B build`
- Generic `cmake -G "Visual Studio 16 2019" -DSOURCE_FOLDER=<Source_Folder_Name> -B build`
  
# Run each time you/change something update
- `cmake --build build --config Release --target Hello_Cuda`
- Generic `cmake --build build --config Release --target <Same_Source_Folder_Name>`

# Run exe
- `build/Hello_Cuda/bin/Release/main.exe`
- Generic `build/<Same_Source_Folder_Name>/bin/Release/main.exe`

P.S. (Has only been configured for Windows michines. Edit CMakeSettings for any other machine.)
