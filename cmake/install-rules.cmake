install(
    TARGETS gcc-project_exe
    RUNTIME COMPONENT gcc-project_Runtime
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
