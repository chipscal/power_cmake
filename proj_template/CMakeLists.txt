#####################################################################################
#	Cmake auto building system script.												#
#	This file finds and configure for each sub folder in this directory				#
#	a target libraries and the respective tests.									#
#	In order to specify a target library a libmanifest.cmake file has to be			#
#	provided inside the library folder.												#
#																					#
#	Author:	Luca Calacci															#
#	Email:	luca.calacci@gmail.com													#
#																					#
#####################################################################################


include(makeLib.cmake)
include(subdirlist.cmake)
include(makeLibTest.cmake)

SUBDIRLIST(SUBDIRS ${CMAKE_CURRENT_LIST_DIR})


foreach(dir ${SUBDIRS})
	set(LIBRARY_INCLUDE_DIRS) #clear list
	set(LIBRARY_LINKED_OBJECTS) #clear list 
	include(${dir}/libmanifest.cmake)
	message("Founded new library: " ${LIBRARY_NAME})
	if(NOT ${LIBRARY_NAME}_EXCLUDE)
		MAKE_LIBRARY(${LIBRARY_NAME} ${LIBRARY_TYPE} "${LIBRARY_INCLUDE_DIRS}" "${LIBRARY_LINKED_OBJECTS}")

		if(BUILD_TESTS)
			SUBDIRLIST(TESTS ${CMAKE_CURRENT_LIST_DIR}/${dir}/tests)
			foreach(libtest ${TESTS})
				message(STATUS "---->Founded test: " ${libtest})
				MAKE_LIB_TEST(${LIBRARY_NAME} ${dir}/tests/${libtest} "${LIBRARY_INCLUDE_DIRS}" "${LIBRARY_LINKED_OBJECTS}") 
			endforeach()
		endif()
		add_definitions(-DHAVE_${LIBRARY_NAME})
	else()
		message(STATUS "----> excluded!")
	endif()
endforeach()


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
