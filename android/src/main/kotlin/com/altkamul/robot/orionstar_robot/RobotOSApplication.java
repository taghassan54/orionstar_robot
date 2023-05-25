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

    private static final String TAG = RobotOSApplication.class.getName();

    private Context mContext;
    private SkillApi mSkillApi;

    private SpeechCallback mSkillCallback;
    private HandlerThread mApiCallbackThread;
    private ModuleCallbackApi mModuleCallback;
    private static RobotOSApplication mApplication;

    @Override
    public void onCreate() {
        super.onCreate();
        mContext = this;
        mApplication = this;
        init();
//        initRobotApi();
    }

    public void init() {
        mSkillCallback = new SpeechCallback();
        mModuleCallback = new ModuleCallback();
        mApiCallbackThread = new HandlerThread("RobotOSDemo");
        mApiCallbackThread.start();
    }

    public static RobotOSApplication getInstance() {
        return mApplication;
    }

    public void initRobotApi(ApiListener apiListener,Context applicationContext) {
        RobotApi.getInstance().connectServer(applicationContext, apiListener);
    }

    private void addApiCallBack() {
        Log.d(TAG, "CoreService connected ");
        RobotApi.getInstance().setCallback(mModuleCallback);
        RobotApi.getInstance().setResponseThread(mApiCallbackThread);
    }

    private void initSkillApi() {
        mSkillApi = new SkillApi();
        ApiListener apiListener = new ApiListener() {
            @Override
            public void handleApiDisabled() {
            }

            /**
             * Handle speech service
             * 语音服务连接成功，注册语音回调
             */
            @Override
            public void handleApiConnected() {
                mSkillApi.registerCallBack(mSkillCallback);
            }

            /**
             * Disconnect speech service
             * 语音服务已断开
             */
            @Override
            public void handleApiDisconnected() {
            }
        };
        mSkillApi.addApiEventListener(apiListener);
        mSkillApi.connectApi(mContext);
    }

    public SkillApi getSkillApi() {
        if (mSkillApi.isApiConnectedService()) {
            return mSkillApi;
        }
        return null;
    }
}
