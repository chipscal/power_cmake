#pragma once

/************************************************************************************
*	API export macro definition file.												*
*																					*
*																					*
*	Author:	Luca Calacci															*
*	Email:	luca.calacci@gmail.com													*
*																					*
************************************************************************************/


#ifdef __cplusplus
	#ifdef API_EXPORTS
		#ifdef __GNUC__
			#define PUB_API __attribute__((visibility("default")))
		#else
			#define PUB_API __declspec(dllexport)
		#endif
	#else
		#ifdef __GNUC__
			#define PUB_API __attribute__((visibility("default")))
		#else
			#define PUB_API __declspec(dllimport)
		#endif
	#endif
#else
	#define PUB_API
#endif

#ifdef __GNUC__
	#ifdef __i386
		#define __stdcall __attribute__((stdcall))
	#else
		#define __stdcall
	#endif
#endif



#ifdef WIN32 
#define THROW_EXCPT(msg) throw std::exception(msg);
#else	
#define THROW_EXCPT(msg) throw std::runtime_error(msg);
#endif



/************************************************************************************
*	MIT License																		*
*																					*
*	Copyright (c) 2018 Luca Calacci													*
*																					*
*	Permission is hereby granted, free of charge, to any person obtaining a copy	*
*	of this software and associated documentation files (the "Software"), to deal	*
*	in the Software without restriction, including without limitation the rights	*
*	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell		*
*	copies of the Software, and to permit persons to whom the Software is			*
*	furnished to do so, subject to the following conditions:						*
*																					*
*	The above copyright notice and this permission notice shall be included in all	*
*	copies or substantial portions of the Software.									*
*																					*
*	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR		*
*	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,		*
*	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE		*
*	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER			*
*	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,	*
*	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE	*
*	SOFTWARE.																		*
*																					*
************************************************************************************/