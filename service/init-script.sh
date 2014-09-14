#! /bin/sh
# example python daemon starter script
# based on skeleton from Debian GNU/Linux
# cliechti@gmx.net
# place the daemon scripts in a folder accessible by root. /usr/local/sbin is a good idea

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/home/opencarpool/dev.opencarpool.org/service/src/jsonrpc_webservice
NAME=jsonrpc_webservice
PIDFILE=/home/opencarpool/dev_jsonrpc_webservice.pid
USER=opencarpool
DESC="DEV JSON-RPC Webservice for call2ride"
CONFIG="/home/opencarpool/dev.opencarpool.org/service/ocp_webservice_dev.cfg"

test -f $DAEMON || exit 0

set -e

case "$1" in
  start)
	echo -n "Starting $DESC: "
	start-stop-daemon --start --quiet --pidfile $PIDFILE \
		--chuid $USER --exec $DAEMON -- $CONFIG 
	echo "$NAME."
	;;
  stop)
	echo -n "Stopping $DESC: "
	start-stop-daemon --stop --quiet --pidfile $PIDFILE
	# \	--exec $DAEMON
	echo "$NAME."
	;;
  #reload)
	#
	#	If the daemon can reload its config files on the fly
	#	for example by sending it SIGHUP, do it here.
	#
	#	If the daemon responds to changes in its config file
	#	directly anyway, make this a do-nothing entry.
	#
	# echo "Reloading $DESC configuration files."
	# start-stop-daemon --stop --signal 1 --quiet --pidfile \
	#	/var/run/$NAME.pid --exec $DAEMON
  #;;
  restart|force-reload)
	#
	#	If the "reload" option is implemented, move the "force-reload"
	#	option to the "reload" entry above. If not, "force-reload" is
	#	just the same as "restart".
	#
	echo -n "Restarting $DESC: "
	start-stop-daemon --stop --quiet --pidfile \
		$PIDFILE
		# --exec $DAEMON
	sleep 1
	start-stop-daemon --start --quiet --pidfile $PIDFILE \
    --chuid $USER --exec $DAEMON -- $CONFIG
	echo "$NAME."
	;;
  *)
	N=/etc/init.d/$NAME
	# echo "Usage: $N {start|stop|restart|reload|force-reload}" >&2
	echo "Usage: $N {start|stop|restart|force-reload}" >&2
	exit 1
	;;
esac

exit 0

