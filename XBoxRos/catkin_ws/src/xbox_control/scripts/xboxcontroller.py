#!/usr/bin/env python
import rospy
from geometry_msgs.msg import Twist
from sensor_msgs.msg import Joy


e = """
Communications Failed
"""
LINEAR_STEP = 0.15
ANGULAR_STEP = 0.2

def callback(data):
    twist = Twist()
    try:
        print(data.axes)
        twist.linear.x = data.axes[1]
        twist.angular.z = data.axes[0]
        
        if (data.axes[3]!=0 or data.axes[2]!=0):
        	twist.linear.x = data.axes[3]*LINEAR_STEP
        	twist.angular.z = data.axes[2]*ANGULAR_STEP

        print('speed: %.2f, turn: %.2f' % (twist.linear.x, twist.angular.z))
        if data.buttons[7] == 1:
            twist.linear.x = 0
            twist.angular.z = 0
            print("STOP!!")
            print('speed: %.2f, turn: %.2f' % (twist.linear.x, twist.angular.z))
        pub.publish(twist)
    except:
        print(e)


# Intializes everything
def start():
    # publishing to "cmd_vel" to control turtle1
    global pub
    rospy.init_node('xbox_control')
    pub = rospy.Publisher('LO02/cmd_vel', Twist, queue_size=10)
    # subscribed to joystick inputs on topic "joy"
    rospy.Subscriber("joy", Joy, callback)
    # starts the node

    rospy.spin()


if __name__ == '__main__':
    start()

