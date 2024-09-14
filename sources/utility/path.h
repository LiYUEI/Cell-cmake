#pragma once

#include <string>
#include <iostream>

#ifdef WIN32
	#include <windows.h>
#else
	#include <stdio.h>
	#include <dirent.h>
#endif // WIN32

namespace path
{
	std::string pwd()
	{
#ifdef WIN32
		char buffer[MAX_PATH];
		GetModuleFileName(NULL, buffer, MAX_PATH);
		std::string f(buffer);
		return f.substr(0, std::string(buffer).find_last_of("\\/"));
#else
		char* cwd = _getcwd(0, 0);
		std::string working_directory(cwd);
		std::free(cwd);
		return working_directory;
#endif // WIN32
	}

}