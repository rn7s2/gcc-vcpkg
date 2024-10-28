# Parent project does not export its library target, so this CML implicitly
# depends on being added from it, i.e. the testing is done only from the build
# tree and is not feasible from an install location

project(gcc-projectTests LANGUAGES CXX)

# ---- Dependencies ----

find_package(Catch2 REQUIRED)
include(Catch)

# ---- Tests ----

add_executable(gcc-project_test source/gcc-project_test.cpp)
target_link_libraries(
    gcc-project_test PRIVATE
    gcc-project_lib
    Catch2::Catch2WithMain
)
target_compile_features(gcc-project_test PRIVATE cxx_std_20)

catch_discover_tests(gcc-project_test)

# ---- End-of-file commands ----

add_folders(Test)
