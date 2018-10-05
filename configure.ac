AC_DEFUN(
	[CHECK_HEADER_WITH_ERROR],
	[
		AC_CHECK_HEADER([$1], [], AC_MSG_ERROR([Error using $1]), [$2])
	]
)

AC_DEFUN(
	[CHECK_LIB_WITH_ERROR],
	[
		AC_CHECK_LIB([$1], [$2], [], AC_MSG_ERROR([Error using $1]), [$3])
	]
)

AC_DEFUN(
	[CHECK_PATH_WITH_ERROR],
	if ! test -e $1
	then
		AC_MSG_ERROR([$1 path not found])
	else
		AC_MSG_NOTICE([Found path $1])
	fi
)

ac_deps_path
###   Deps location   ###
AC_ARG_WITH(
	[deps],
	AC_HELP_STRING(
		[--with-deps], 
		[Set the search path for dependincies],
	), 
	[ac_deps_path=$withval],
	[ac_deps_path="/opt/common"] 
)

###   ZeroMQ   ###
ac_zeromq_path=$ac_deps_path/zeromq/

AC_ARG_WITH(
	[zeromq],
	AC_HELP_STRING([--with-zeromq], [Set the location of the ZMQ dependency],), ac_zeromq_path=$withval
)

AC_MSG_NOTICE([===========================================])
AC_MSG_NOTICE([+++   Checking for ZMQ dep_zeromq_ver   +++])
AC_MSG_NOTICE([at $ac_zmq_path])
AC_MSG_NOTICE([===========================================])
AC_SUBST(ac_zmq_path)

CHECK_PATH_WITH_ERROR([$ac_zeromq_path])

CPPFLAGS="$CPPFLAGS -I$ac_zeromq_path/include"
CHECK_WEADER_WITH_ERROR([zmq.h])
