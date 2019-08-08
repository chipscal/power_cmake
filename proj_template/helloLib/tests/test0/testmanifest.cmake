#####################################################################################
#	Cmake auto building library manifest.											#
#	Use this file in order to specify a test:										#
#		- name																		#
#		- test arguments															#
#		- additional dependencies (Note: all the library dependencies are			#
#			automatically provided by the building system.							#
#																					#
#																					#
#	Author:	Luca Calacci															#
#	Email:	luca.calacci@gmail.com													#
#																					#
#####################################################################################


set(TEST_NAME "hellotest")
set(TEST_ARGS )

#find additional package here...


list(APPEND TEST_ADDITIONAL_INCLUDE_DIR 
		#your additional include dir here...
	)

list(APPEND TEST_ADDITIONAL_LINKED_OBJECTS 
		#your additional object here...
	)