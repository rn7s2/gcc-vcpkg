# gcc-project

This demo shows how to configure a gcc toolchain for a C++ project using vcpkg.
It is assumed that the project is generated using cmake-init and that CLion is
being used as the editor.

## vcpkg integration with CMake
vcpkg integrates with CMake projects by providing a toolchain file
`<vcpkg-root>/scripts/buildsystems/vcpkg.cmake`
that adds vcpkg functionality into the CMake build process.
Use the vcpkg toolchain file by setting the `CMAKE_TOOLCHAIN_FILE` cmake variable.

When using the CLion vcpkg dialog, CLion adds this variable to 
the selected built-in cmake profiles.

cmake-init sets this variable in the `vcpkg` preset in `CMakePreset.json`.
To use cmake-init presets in CLion, set `VCPKG_ROOT` environment variable in `CMakeUserPresets.json`:
```
"environment": {
  "VCPKG_ROOT": "<path to vcpkg-root>"
}
```

## Adding a gcc toolchain to vcpkg
1. Add `gcc-14-toolchain.cmake` - toolchain file that specifies the gcc toolchain.
In addition to the compiler paths, it is necessary to set
`set(CMAKE_OSX_SYSROOT /Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk)`
2. Add `arm64-osx-gcc.cmake` - custom triplet file. Within the triplet file, we set
`VCPKG_CHAINLOAD_TOOLCHAIN_FILE` to use the above toolchain file
3. Tell vcpkg to use the custom triplet by setting
   - `VCPKG_TARGET_TRIPLET` - name of the custom triplet (arm64-osx-gcc)
   - `VCPKG_OVERLAY_TRIPLETS` - directory containing custom triplet file
4. With the variables above, vcpkg will use the gcc toolchain to build vcpkg packages.
It is also necessary to tell vcpkg to use the gcc toolchain in the vcpkg provided toolchain file 
used to build the actual project. This is done by setting
   - `VCPKG_CHAINLOAD_TOOLCHAIN_FILE` (path to gcc toolchain file)

Note that the `VCPKG_CHAINLOAD_TOOLCHAIN_FILE` variable is used in two different places to
do different things. See https://github.com/microsoft/vcpkg/issues/36244

If using cmake-init presets, variables should be set in `CMakeUserPresets.json`.

If using CLion built-in CMake profiles, variables should be set in `CMake Options`
for the CMake profile.

## References
- https://stackoverflow.com/questions/74422058/how-to-use-vcpkg-with-clang-on-linux
- https://github.com/microsoft/vcpkg/issues/16368
- https://learn.microsoft.com/en-gb/vcpkg/users/buildsystems/cmake-integration#using-multiple-toolchain-files
- https://gist.github.com/scivision/d69faebbc56da9714798087b56de925a

# Building and installing

See the [BUILDING](BUILDING.md) document.

# Contributing

See the [CONTRIBUTING](CONTRIBUTING.md) document.

# Licensing

<!--
Please go to https://choosealicense.com/licenses/ and choose a license that
fits your needs. The recommended license for a project of this type is the
GNU AGPLv3.
-->
