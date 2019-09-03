#####################################################################################
#	Cmake auto building system script.												#
#	This function auto configure a library test.									#
#	In order to configure a test a libtestmanifest.cmake file has to be				#
#	provided inside the test folder.												#
#																					#
#	Author:	Luca Calacci															#
#	Email:	luca.calacci@gmail.com													#
#																					#
#####################################################################################

FUNCTION(MAKE_LIB_TEST LIB_NAME TEST_DIR LIB_INCLUDE_DIRS LIB_OBJS)


	include(${TEST_DIR}/testmanifest.cmake)
	file(GLOB priv_sources "${TEST_DIR}/*.c*" "${TEST_DIR}/*.h*")

	add_executable(${TEST_NAME} ${priv_sources})
	

	list(APPEND idirs ${TEST_ADDITIONAL_INCLUDE_DIR} ${LIB_INCLUDE_DIRS} "${TEST_DIR}/../../../")
	foreach(idir ${idirs})
		message(STATUS "---->Test included dir: " ${idir})
		target_include_directories(
		${TEST_NAME} 
			PUBLIC ${idir}
	)
	endforeach()
	#unset(${idirs})

	message(STATUS "---->Test linked objs: " ${LIB_NAME})
	target_link_libraries(${TEST_NAME} ${LIB_NAME})
	list(APPEND lobjs ${TEST_ADDITIONAL_LINKED_OBJECTS} ${LIB_OBJS})
	
	set(skip_next false)
	foreach(lobj ${lobjs})
		
		if(NOT skip_next AND NOT lobj MATCHES debug AND NOT lobj MATCHES optimized)
			message(STATUS "---->---->Test linked objs: : " ${lobj})
			target_link_libraries(${TEST_NAME} ${lobj})

		endif()
		set(skip_next false)

		if(lobj MATCHES optimized AND CMAKE_BUILD_TYPE MATCHES Debug)
			set(skip_next true)
		elseif(lobj MATCHES debug AND NOT CMAKE_BUILD_TYPE MATCHES Debug)
			set(skip_next true)
		endif()

	endforeach()
	set(skip_next)

	install(TARGETS ${TEST_NAME} DESTINATION "${WIN_INST_PREFIX}lib/${PROJ_NAME}")
	add_test("${LIB_NAME}_${TEST_NAME}" ${TEST_NAME} ${TEST_ARGS})

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