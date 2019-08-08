#####################################################################################
#	Cmake auto building library manifest.											#
#	Use this file in order to specify the library:									#
#		- name																		#
#		- type [SHARED, STATIC]														#
#		- major number																#
#		- minor number																#
#		- dependencies																#
#																					#
#																					#
#	Author:	Luca Calacci															#
#	Email:	luca.calacci@gmail.com													#
#																					#
#####################################################################################


set(LIBRARY_NAME "helloLib")
set(LIBRARY_TYPE SHARED)
set(LIBRARY_MAJOR 1)
set(LIBRARY_MINOR 0)

# find dependencies here...
# find(package_name REQUIRED)

list(APPEND LIBRARY_INCLUDE_DIRS 
		# included dirs here
	)

list(APPEND LIBRARY_LINKED_OBJECTS 
		# linked objects here
	)