#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ricky/Projects/ROS/LoomoRos/catkin_ws/src/loomo_teleop"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ricky/Projects/ROS/LoomoRos/catkin_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ricky/Projects/ROS/LoomoRos/catkin_ws/install/lib/python2.7/dist-packages:/home/ricky/Projects/ROS/LoomoRos/catkin_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ricky/Projects/ROS/LoomoRos/catkin_ws/build" \
    "/usr/bin/python2" \
    "/home/ricky/Projects/ROS/LoomoRos/catkin_ws/src/loomo_teleop/setup.py" \
    build --build-base "/home/ricky/Projects/ROS/LoomoRos/catkin_ws/build/loomo_teleop" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/ricky/Projects/ROS/LoomoRos/catkin_ws/install" --install-scripts="/home/ricky/Projects/ROS/LoomoRos/catkin_ws/install/bin"
