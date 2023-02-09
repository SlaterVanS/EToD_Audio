workspace "EToDAudio"
	architecture "x86_64"
	startproject "EToDAudio-Examples"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}
	
	flags
	{
		"MultiProcessorCompile"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

group "Dependencies"
	include "EToDAudio/vendor/OpenAL-Soft"
	include "EToDAudio/vendor/libogg"
	include "EToDAudio/vendor/Vorbis"
group ""

project "EToDAudio"
	location "EToDAudio"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS",
		"AL_LIBTYPE_STATIC"
	}

	includedirs
	{
		"%{prj.name}/src",
		"EToDAudio/vendor/OpenAL-Soft/include",
		"EToDAudio/vendor/OpenAL-Soft/src",
		"EToDAudio/vendor/OpenAL-Soft/src/common",
		"EToDAudio/vendor/libogg/include",
		"EToDAudio/vendor/Vorbis/include",
		"EToDAudio/vendor/minimp3"
	}

	links
	{
		"OpenAL-Soft",
		"Vorbis"
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		defines "ETOD_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "ETOD_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "ETOD_DIST"
		runtime "Release"
		optimize "on"

project "EToDAudio-Examples"
	location "EToDAudio-Examples"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"EToDAudio/src"
	}

	links
	{
		"EToDAudio"
	}

	filter "system:windows"
		systemversion "latest"
		
	filter "configurations:Debug"
		defines "ETOD_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "ETOD_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "ETOD_DIST"
		runtime "Release"
		optimize "on"
