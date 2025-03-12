CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
SET (CMAKE_CXX_STANDARD 20)

AUX_SOURCE_DIRECTORY(./ SRC)

SET(LINK_unwind "unwind")
SET(LINK_glog   "glog")
SET(LINK_gflags "gflags")

if(BUILD_STATIC_LIB)
  ADD_LIBRARY(log STATIC ${SRC})
else()
  ADD_LIBRARY(log SHARED ${SRC})
endif()

find_package (glog 0.6.0 REQUIRED)
find_package (gflags REQUIRED)
target_link_libraries(log PUBLIC ${LINK_glog} ${LINK_gflags} ${LINK_unwind})
