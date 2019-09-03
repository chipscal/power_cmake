#####################################################################################
#	Cmake auto building system script.												#
#	This function auto configure a target library (static or shared).				#
#																					#
#																					#
#	Author:	Luca Calacci															#
#	Email:	luca.calacci@gmail.com													#
#																					#
#####################################################################################

include(findSources.cmake)

FUNCTION(MAKE_LIBRARY TARGET_LIB LIB_TYPE INCLUDE_DIRS LINK_OBJ)
	
	add_library(
		${TARGET_LIB} ${LIB_TYPE}
			"api_export.h"
	)

	set(${TARGET_LIB}_INCLUDE_DIRS "${WIN_INST_PREFIX}include/${PROJ_NAME}")#/${TARGET_LIB}")
	message(STATUS "Install include dir: " ${${TARGET_LIB}_INCLUDE_DIRS})
	set(${TARGET_LIB}_LIBRARIES "${WIN_INST_PREFIX}lib/${PROJ_NAME}")
	message(STATUS "Install libraries dir: " ${${TARGET_LIB}_LIBRARIES})


	target_compile_definitions(${TARGET_LIB} PRIVATE API_EXPORTS)

	set(skip_next false)
	foreach(lobj ${LINK_OBJ})
		
		if(NOT skip_next AND NOT lobj MATCHES debug AND NOT lobj MATCHES optimized)
			message(STATUS "---->Target linked library: " ${lobj})
			target_link_libraries(${TARGET_LIB} ${lobj})

		endif()
		set(skip_next false)

		if(lobj MATCHES optimized AND CMAKE_BUILD_TYPE MATCHES Debug)
			set(skip_next true)
		elseif(lobj MATCHES debug AND NOT CMAKE_BUILD_TYPE MATCHES Debug)
			set(skip_next true)
		endif()

	endforeach()
	set(skip_next)
	
	message(STATUS "${TARGET_LIB} LIBRARIES: " ${${TARGET_LIB}_LIBRARIES})


	set(PROJ_SRC_DIR "${CMAKE_SOURCE_DIR}/${PROJ_NAME}")

	message(STATUS "source dir: " ${PROJ_SRC_DIR})

	target_include_directories(
		${TARGET_LIB} 
			PUBLIC ${PROJ_SRC_DIR}
	)
	foreach(idir ${INCLUDE_DIRS})
		message(STATUS "---->Target included dir: " ${idir})
		target_include_directories(
		${TARGET_LIB} 
			PUBLIC ${idir}
	)
	endforeach()


	if (WIN32)
		add_custom_command(TARGET ${TARGET_LIB} POST_BUILD			# Adds a post-build event to pyvlib
			COMMAND ${CMAKE_COMMAND} -E copy_if_different  # which executes "cmake - E copy_if_different..."
				"$<TARGET_FILE:${TARGET_LIB}>"      # <--this is in-file
				"$<TARGET_FILE_DIR:${TARGET_LIB}>/${TARGET_LIB}/tests")
	endif()
		
	FIND_SOURCES(${TARGET_LIB} "${PROJ_SRC_DIR}/${TARGET_LIB}")


	install(FILES api_export.h DESTINATION ${${TARGET_LIB}_INCLUDE_DIRS})
	install(TARGETS ${TARGET_LIB} DESTINATION ${${TARGET_LIB}_LIBRARIES})

	set(Config_IN ${CMAKE_CURRENT_SOURCE_DIR}/targetConfig.cmake)
	set(Config_OUT ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_LIB}Config.cmake)

	# request to configure the file
	configure_file(${Config_IN} ${Config_OUT} @ONLY)

	install(FILES ${Config_OUT} DESTINATION ${WIN_INST_PREFIX}lib/cmake/${PROJ_NAME})
	#install(FILES "LICENSE.md" DESTINATION ${WIN_INST_PREFIX}doc/${PROJ_NAME})

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