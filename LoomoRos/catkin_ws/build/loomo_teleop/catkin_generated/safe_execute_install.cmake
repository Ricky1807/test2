execute_process(COMMAND "/home/ricky/Projects/ROS/LoomoRos/catkin_ws/build/loomo_teleop/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/ricky/Projects/ROS/LoomoRos/catkin_ws/build/loomo_teleop/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
