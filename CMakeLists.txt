#####################################################################################
#	Cmake auto building system script.												#
#	This file initialize a project defined into manifest.cmake and builds 			#
#	documentation if the BUILD_DOCUMENTATION flag is set.							#
#																					#
#	Author:	Luca Calacci															#
#	Email:	luca.calacci@gmail.com													#
#																					#
#####################################################################################


cmake_minimum_required(VERSION 2.6)

include(manifest.cmake)

project(${PROJ_NAME})

option(BUILD_TESTS "Compile libraries tests" true)
if (BUILD_TESTS)
	enable_testing()
endif()

if(UNIX)
    message(STATUS "Linux env...")
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -std=c++14 ${ARCH_SPECIFIC}")
endif()

if (WIN32)
	set(WIN_INST_PREFIX "${PROJ_NAME}/")
endif()

if(NOT CMAKE_DEBUG_POSTFIX)
  set(CMAKE_DEBUG_POSTFIX -gd)
endif()

add_subdirectory("${PROJ_NAME}")

find_package(Doxygen)
option(BUILD_DOCUMENTATION "Create and install the HTML based API        
documentation (requires Doxygen)" ${DOXYGEN_FOUND})

install(FILES "README.md" DESTINATION ${WIN_INST_PREFIX}doc/${PROJ_NAME})

if(BUILD_DOCUMENTATION)
    if(NOT DOXYGEN_FOUND)
         message(FATAL_ERROR "Doxygen is needed to build the documentation.")
    endif()

    set(DOXYGEN_IN ${CMAKE_CURRENT_SOURCE_DIR}/${PROJ_NAME}/Doxyfile)
    set(DOXYGEN_OUT ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)

    # request to configure the file
    configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
    message("Doxygen build started")

    # note the option ALL which allows to build the docs together with the application
    add_custom_target(doc_doxygen ALL
        COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generating API documentation with Doxygen"
        VERBATIM )
	
    install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/doc_doxygen/html DESTINATION ${WIN_INST_PREFIX}doc/${PROJ_NAME})
    install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/doc_doxygen/latex DESTINATION ${WIN_INST_PREFIX}doc/${PROJ_NAME})
endif()


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