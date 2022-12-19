#include "JoystickHandler.h"
#include <QDebug>
#include <iostream>

int		numAxis;
int		numButton;
char	nameJoy[80];

inline float max(float a, float b) {return (a>=b ? a : b);}
inline float min(float a, float b) {return (a>=b ? b : a);}

JoystickHandler::JoystickHandler(){
    connection = false;
    fdJoy = 0;

    for(int i=0; i<8; i++){
        JoyAxis[i] = 0;
    }
    for(int i=0; i<12; i++){
        JoyButton[i] = 0;
    }

    timer = new QTimer();
    connect(timer, SIGNAL(timeout()),this, SLOT(updatejoy()));
    timer->start(10);
}

JoystickHandler::~JoystickHandler(){
    close(fdJoy);
}

int JoystickHandler::CheckJoy(){
    if(connection && open(devName.toStdString().c_str(), O_RDONLY) == -1){
//        plog->write("[JOYSTICK] DISCONNECTED");
        connection = false;
        close(fdJoy);
    }
}

int JoystickHandler::ConnectJoy(const QString _devName){
    for(int i=0; i<8; i++){
        JoyAxis[i] = 0;
    }
    for(int i=0; i<12; i++){
        JoyButton[i] = 0;
    }

    devName = _devName;
    if((fdJoy = open(devName.toStdString().c_str(), O_RDONLY)) == -1){
        connection = false;
    }else if(!connection){
//        plog->write("[JOYSTICK] CONNECTED : "+QString().sprintf("%s",nameJoy));

        int version;
        ioctl(fdJoy, JSIOCGVERSION, &version);
        ioctl(fdJoy, JSIOCGAXES, &numAxis);
        ioctl(fdJoy, JSIOCGBUTTONS, &numButton);
        ioctl(fdJoy, JSIOCGNAME(80), &nameJoy);


        cout << "Version: " << version<<endl;
        cout << "Joy Connect: " << nameJoy << "(" << numAxis << ", " << numButton << ")"<<endl;

        fcntl(fdJoy, F_SETFL, O_NONBLOCK);	// use non-blocking methods
        connection = true;
    }
}

int JoystickHandler::DisconnectJoy(){
    connection = false;
    close(fdJoy);
    return true;
}

float calc_joy(float in)
{
    float thres = 500;
    float MaxA = 30000;
    float td;
    if(in>thres)
    {
        td = min(1.0,(in-thres)/(MaxA-thres));
    }
    else if(in<-thres)
    {
        td = max(-1.0,(in+thres)/(MaxA-thres));
    }
    else
    {
        td = 0;
    }
    return td;
}

void JoystickHandler::updatejoy(){
    static int connect_count = 0;
    static int init_count = 0;
    if(connection == true){
        if(init_count++ > 300){
            // read the joystick
            if(sizeof(struct js_event) == read(fdJoy, &(JoyEvent), sizeof(struct js_event))){
                switch(JoyEvent.type & ~JS_EVENT_INIT){
                case JS_EVENT_AXIS:
                    if(JoyEvent.number < 8)
                    {
                        (JoyAxis)[JoyEvent.number] = JoyEvent.value;
                    }
                    break;
                case JS_EVENT_BUTTON:
                    if(JoyEvent.number < 12)
                    {
                        (JoyButton)[JoyEvent.number] = JoyEvent.value;
                    }
                    break;
                }
            }
        }
    }else{
        init_count = 0;
        if(connect_count++%100 == 0){
            ConnectJoy("/dev/input/js0");
        }
    }
    if(connect_count++%100 == 0){
        CheckJoy();
    }
}
