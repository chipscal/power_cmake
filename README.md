# Reference Generator

Cmake project automated build system.
By using this build system is possible to:
	- configure and build multiple libraries (static and shared)
	- configure and auto execute for each target library several tests
	- install libraries, tests and documentation into your INSTALL_ROOT
	- it supports either Windows and Linux/Unix

## Getting started
In order to start a manifest.cmake file has to be specified inside the ROOT.
This file has to set at least the following variables:
	* PROJ_NAME: name of your project
	* PROJ_AUTHOR: author(s) of the project 
	* PROJ_AUTHOR_EMAIL: email(s) of the author(s)
Inside the ROOT a folder with the same name of the project has to be created. 

In order to create a new target library it is necessary to:
	* create a subfolder inside ROOT/project folder with the following structure:
		* src/ 
			* *.cpp, *.h, *.hpp (sources and only private headers * not installed)
		* tests/
			* test0: (Optionally)
				* *.cpp, *.h, *.hpp
				* testmanifest.cmake
			* ...
		* libmanifest.cmake
		* *.h, *.hpp (public headers)

A library is defined using a libmanifest.cmake file  that has to specify at least:
	* LIBRARY_NAME: the name of the library
	* LIBRARY_TYPE: SHARED or STATIC
	* LIBRARY_MAJOR: library major number 
	* LIBRARY_MINOR: library minor number

In order to import dependencies you may use this file to find packages and append
the package include directories and objects respectively into:
	* LIBRARY_INCLUDE_DIRS 
	* LIBRARY_LINKED_OBJECTS

Inside the test folder a testmanifest.cmake has to be created and must specify:
	* TEST_NAME: the test name
	* TEST_ARGS: test arguments

All the library dependencies are automatically included into the test. If other packages
are neaded it is possible to use the testmanifest in order to find packages and to append
their include direcoteries and objects respectively inside:
	* TEST_ADDITIONAL_INCLUDE_DIR 
	* TEST_ADDITIONAL_LINKED_OBJECTS 


The project is configured to build the documentation using Doxygen (if present). The doxyfile
is already configured to use as mainpage this README.md, so you can start to describe your 
project from this file.

The install scripts will provide to copy into the install folder either the README.md and the 
LICENSE.md files.

## Authors

* **Luca Calacci** - luca.calacci@gmail.com 
    

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

