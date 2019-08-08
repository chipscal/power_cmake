#####################################################################################
#	Cmake auto building system script.												#
#	Auto configured cmakeConfig file.												#
#	Please DO NOT modify this file directly											#
#																					#
#	Author:	Luca Calacci															#
#	Email:	luca.calacci@gmail.com													#
#																					#
#####################################################################################


if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.5)
   message(FATAL_ERROR "CMake >= 2.6.0 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.6)
#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------


# Create imported target 
add_library(@TARGET_LIB@ SHARED IMPORTED)
set(@TARGET_LIB@_INCLUDE_DIRS "${CMAKE_CURRENT_LIST_DIR}/../../../include")

if(UNIX)
	file(GLOB libs "${CMAKE_CURRENT_LIST_DIR}/../../@PROJ_NAME@/*.so")
else()
	file(GLOB libs "${CMAKE_CURRENT_LIST_DIR}/../../@PROJ_NAME@/*${CMAKE_STATIC_LIBRARY_SUFFIX}")
endif()

foreach(entry ${libs})
	string(FIND ${entry} "-gd." pos REVERSE)
	message(STATUS "entry: " ${entry} ", pos: " ${pos})
	if((CMAKE_BUILD_TYPE MATCHES Debug))
		if ((pos GREATER_EQUAL 0))
			list(APPEND "@TARGET_LIB@_LIBRARIES" ${entry})
		endif()
	elseif((pos LESS 0))
		list(APPEND "@TARGET_LIB@_LIBRARIES" ${entry})
	endif()
endforeach()
message(STATUS "@TARGET_LIB@ LIBRARIES: " ${@TARGET_LIB@_LIBRARIES})

# This file does not depend on other imported targets which have
# been exported from the same project but in a separate export set.

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)

#####################################################################################
#	MIT License																		#
#																					#
#	Copyright (c) 2019 Luca Calacci													#
#																					#
#	Permission is hereby granted, free of charge, to any person obtaining a copy	#
#	of this software and associated documentation files (the "Software"), to deal	#
#	in the Software without restriction, including without limitation the rights	#
#	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell		#
#	copies of the Software, and to permit persons to whom the Software is			#
#	furnished to do so, subject to the following conditions:						#
#																					#
#	The above copyright notice and this permission notice shall be included in all	#
#	copies or substantial portions of the Software.									#
#																					#
#	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR		#
#	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,		#
#	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE		#
#	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER			#
#	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,	#
#	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE	#
#	SOFTWARE.																		#
#																					#
#####################################################################################
