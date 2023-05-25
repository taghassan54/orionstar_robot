/*
 *  Copyright (C) 2017 OrionStar Technology Project
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

package com.altkamul.robot.orionstar_robot;

import android.app.Application;
import android.content.Context;
import android.os.HandlerThread;
import android.util.Log;

import com.ainirobot.coreservice.client.ApiListener;
import com.ainirobot.coreservice.client.RobotApi;
import com.ainirobot.coreservice.client.module.ModuleCallbackApi;
import com.ainirobot.coreservice.client.speech.SkillApi;

public class RobotOSApplication extends Application {

    public void initRobotApi(ApiListener apiListener,Context applicationContext) {
        RobotApi.getInstance().connectServer(applicationContext, apiListener);
    }

}