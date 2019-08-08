#####################################################################################
#	Cmake auto building system script.												#
#	Function used to find all the private and public sources and header files.		#
#																					#
#																					#
#	Author:	Luca Calacci															#
#	Email:	luca.calacci@gmail.com													#
#																					#
#####################################################################################

FUNCTION(FIND_SOURCES TARGET_LIB CURRENT_DIR)	

	message(STATUS "-------> Entering dir: " ${CURRENT_DIR})

	file(GLOB pub_header "${CURRENT_DIR}/*.h" "${CURRENT_DIR}/*.hpp")
	file(GLOB_RECURSE priv_sources "${CURRENT_DIR}/src/*.cpp" "${CURRENT_DIR}/src/*.h" "${CURRENT_DIR}/src/*.hpp")

	foreach(hdr ${pub_header})
		message(STATUS "---------------> founded header: " ${hdr})
	endforeach()

	foreach(psrc ${priv_sources})
		message(STATUS "---------------> founded source: " ${psrc})
	endforeach()

	message(STATUS "Preparing build resources for: " ${TARGET_LIB})
	target_sources(${TARGET_LIB}
		PUBLIC ${pub_header}
		PRIVATE ${priv_sources}
	)

	#add_subdirectory("tests")

	install(FILES ${pub_header} DESTINATION ${${TARGET_LIB}_INCLUDE_DIRS}/${TARGET_LIB})
ENDFUNCTION()

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
