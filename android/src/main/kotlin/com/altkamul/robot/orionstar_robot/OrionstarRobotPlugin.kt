package com.altkamul.robot.orionstar_robot

import android.content.Context
import android.os.Handler
import android.os.HandlerThread
import android.os.Looper
import android.os.RemoteException
import android.text.TextUtils
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.Nullable
import com.ainirobot.base.analytics.utils.StringUtil
import com.ainirobot.coreservice.client.ApiListener
import com.ainirobot.coreservice.client.Definition
import com.ainirobot.coreservice.client.RobotApi
import com.ainirobot.coreservice.client.actionbean.LeadingParams
import com.ainirobot.coreservice.client.actionbean.Pose
import com.ainirobot.coreservice.client.listener.ActionListener
import com.ainirobot.coreservice.client.listener.CommandListener
import com.ainirobot.coreservice.client.listener.Person
import com.ainirobot.coreservice.client.listener.TextListener
import com.ainirobot.coreservice.client.module.ModuleCallbackApi
import com.ainirobot.coreservice.client.person.PersonApi
import com.ainirobot.coreservice.client.person.PersonListener
import com.ainirobot.coreservice.client.person.PersonUtils
import com.ainirobot.coreservice.client.robotsetting.RobotSettingApi
import com.ainirobot.coreservice.client.speech.SkillApi
import com.ainirobot.coreservice.client.speech.SkillCallback
import com.ainirobot.coreservice.client.speech.entity.TTSEntity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONException
import org.json.JSONObject










/** OrionstarRobotPlugin */
class OrionstarRobotPlugin : FlutterPlugin, MethodCallHandler {

    private val REGISTER = "register"
    private val FIND_FACE = "findFace"

    private val TAG: String =
        ""


    private var methodChannel: MethodChannel? = null
    private var checkTimes = 0
    private var action = ""
    private var reqId = 0
    private var mApiCallbackThread: HandlerThread? = null
    private var mSkillApi: SkillApi? = null
    var applicationContext: Context? = null

    private var picture: String? = null
    private var places: String? = null
    private var mapName: String? = null
    var textListenerStatus: String? = null
    var messages: String? = null
    var isRobotEstimateMessage: String? = null
    var navigationResult: String? = null
    var botReqType: String? = null
    var botReqText: String? = null
    var botReqParam: String? = null

    private lateinit var channel: MethodChannel


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "orionstar_robot")
        channel.setMethodCallHandler(this)

        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {


        when (call.method) {

            "checkInit" -> {
                checkTimes = 0
                init()
                initRobotApi()
                checkInit()
                result.success("Api Connected Service Successfully !")
            }
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "getRobotBatteryInfo" -> {
                val robotBatteryInfo = RobotSettingApi.getInstance()
                    .getRobotString(Definition.ROBOT_SETTINGS_BATTERY_INFO)
                result.success(robotBatteryInfo)
            }
            "stopAutoChargeAction" -> {
                RobotApi.getInstance().stopAutoChargeAction(reqId, true)
            }
            "resetRequestResponse" -> {
                botReqType = null
                botReqText = null
                botReqParam = null
            }
            "getRequestResponse" -> {
                result.success(botReqParam)
            }
            "startNaviToAutoChargeAction" -> {
                startNaviToAutoChargeAction()

                result.success("success")
            }
            "stopChargingByApp" -> {
            stopChargingByApp()

                result.success("success")
            }
            "queryByText" -> {
                Log.d("call.arguments", "${call.arguments}")
                if (call.arguments != null)
                    queryByText("${call.arguments}")

                result.success("success")
            }
            "stopTTS" -> {
                stopTTS()
                result.success("success")
            }

            "enableRecognizable" -> {
                enableRecognizable()
                result.success("success")
            }
            "disableRecognizable" -> {
                disableRecognizable()
                result.success("success")
            }

            "playText" -> {
                Log.d("call.arguments", "${call.arguments}")
                if (call.arguments != null)
                    playText("${call.arguments}")

                result.success("play Text success")
            }
            "getPerson" -> {
                val person = PersonApi.getInstance().focusPerson
                result.success("$person")
            }
            "registerById" -> {

                registerById()
                result.success("register By Id success")
            }
            "stopFocusFollow" -> {
                stopFocusFollow()
                result.success("Stop Focus Follow")
            }
            "isRobotEstimate" -> {
                isRobotEstimate()
                result.success(isRobotEstimateMessage)
            }
            "startFocusFollow" -> {
                startFocusFollow()
                result.success("Start Focus Follow")
            }
            "findPeople" -> {
                action = FIND_FACE
                registerPersonListener()
                result.success("find People success")
            }
            "register" -> {
                action = REGISTER
                registerPersonListener()
                result.success("register success")
            }
            "isRobotInLocation" -> {
                var isInLocation=false
                Log.d("call.arguments", "${call.arguments}")
                if (call.arguments != null){
                    isInLocation= isRobotInLocation("${call.arguments}")
                }
                result.success("$isInLocation")
            }
            "startNavigation" -> {
                navigationResult="NavigationResult:Code=9999,message=startNavigation"
                Log.d("call.arguments", "${call.arguments}")
                if (call.arguments != null){
                    startNavigation("${call.arguments}")
                }
                result.success("start Navigation success")
            }
            "resumeSpecialPlaceTheta" -> {

                Log.d("call.arguments", "${call.arguments}")
                if (call.arguments != null){
                    resumeSpecialPlaceTheta("${call.arguments}")
                }
                result.success("Resume Special Place Theta success")
            }
            "getNavigationResult" -> {
                result.success(navigationResult.toString())
            } "stopNavigation" -> {
            stopNavigation()
                result.success(navigationResult.toString())
            }
            "checkStatus" -> {
                result.success(messages.toString())
            }
            "getTextListenerStatus" -> {
                result.success(textListenerStatus.toString())
            }
            "resetHead" -> {
                RobotApi.getInstance().resetHead(reqId++, mMotionListener)
                result.success("reset Head success")
            }
            "stopMove" -> {
                RobotApi.getInstance().stopMove(reqId++, mMotionListener)
                result.success("stop Move")
            }
            "turnLeft" -> {
                RobotApi.getInstance().turnLeft(reqId++, 0.2f, mMotionListener)
                result.success("turn Left")
            }
            "turnRight" -> {
                RobotApi.getInstance().turnRight(reqId++, 0.2f, mMotionListener)
                result.success("turn Right")
            }
            "mHeadUp" -> {
                moveHead(0, -20)

                result.success("turn mHeadUp")
            }
            "mHeadDown" -> {
                moveHead(0, 20)
                result.success("turn mHeadDown")
            }
            "moveHead" -> {
                moveHead(0, 20)

            }
            "goBackward" -> {
                goBackward()
            }
            "goForward" -> {
                if (call.arguments != null)
                    goForward("${call.arguments}".toFloat())
            }
            "getPicture" -> {
                getPictureById()
                result.success(picture.toString())
            }
            "setLocation" -> {
                Log.d("call.arguments", "${call.arguments}")
                if (call.arguments != null)
                    setLocation("${call.arguments}")

                result.success("save the location point successfully")
            }
            "removeLocation" -> {
                Log.d("call.arguments", "${call.arguments}")
                if (call.arguments != null)
                    removeLocation("${call.arguments}")

                result.success("save the location point successfully")
            }
            "startLead" -> {

                Log.d("call.arguments", "${call.arguments}")
                if (call.arguments != null)
                    startLead("${call.arguments}")

                result.success("save the location point successfully")
            }
            "startCruise" -> {
                startCruise()
                result.success("$messages")
            }
            "stopCruise" -> {
                stopCruise()
                result.success("$messages")
            }
            "robotGetLocation" -> {
                getPosition()

                result.success(places.toString())
            }
            "checkMapName" -> {
                checkMapName()
                result.success(mapName.toString())
            }
            else -> {
                result.notImplemented()
            }
        }

    }

    fun sendNavigationResult(type: String, status: Int, data: String,methodName:String) {
//        methodChannel!!.invokeMethod("openCaller", false)
        val handler = Handler(Looper.getMainLooper())
        handler.post {
            channel.invokeMethod(
                methodName,
                "{\"type\":\"${type}\",\"status\":\"${status}\",\"data\":\"${data}\"}",
                object : Result {
                    override fun success(@Nullable result: Any?) {
                        Log.i("fromInvoke", "success" + result.toString())
                    }

                    override fun error(
                        errorCode: String,
                        @Nullable errorMessage: String?,
                        @Nullable errorDetails: Any?
                    ) {
                        Log.i("fromInvoke", "failed$errorMessage")
                    }

                    override fun notImplemented() {
                        Log.i("fromInvoke", "not implemented")
                    }
                }
            )
        }

    }

    private fun stopCruise() {
        RobotApi.getInstance().stopCruise(reqId++)
    }

    private fun goForward(distance: Float) {
        try {
            Log.d("goForwardCallArguments", "$distance")
            RobotApi.getInstance().goForward(reqId++, 0.2f, distance, true, mMotionListener)
        } catch (e: Exception) {
            messages = e.message
        }
    }

    private fun goBackward() {
        RobotApi.getInstance().goBackward(reqId++, 0.2f, 2.toFloat(), mMotionListener)
    }

    private fun moveHead(i: Int, i1: Int) {
        RobotApi.getInstance()
            .moveHead(
                reqId,
                "relative",
                "relative",
                i,
                i1,
                mMotionListener
            )
    }

    private fun registerById() {
        val person = PersonApi.getInstance().focusPerson
        if (person != null) {
            PersonApi.getInstance()
                .registerById(person.id, "register By Id", object : CommandListener() {
                    override fun onResult(result: Int, message: String) {
                        Log.d("registerById", result.toString() + message)
                        messages =
                            (result.toString() + " " + message + " person id is ${person.id}")
                    }
                })

        }
    }


    private fun init() {

        mApiCallbackThread = HandlerThread("RobotOSDemo")
        mApiCallbackThread!!.start()

    }

    private fun initRobotApi() {
        RobotApi.getInstance().connectServer(applicationContext, object : ApiListener {
            override fun handleApiDisabled() {
                Log.i(TAG, "handleApiDisabled")
            }

            /**
             * Server connected, set callback to handle message
             * Server已连接，设置接收请求的回调，包含语音指令、系统事件等
             *
             * Start connect RobotOS, init and make it ready to use
             * 启动与RobotOS连接，这里可以做一些初始化的工作 例如连接语音,本地服务等
             */
            override fun handleApiConnected() {
                Log.i(
                    TAG,
                    "handleApiConnected"
                )
                addApiCallBack()
                initSkillApi()

            }

            /**
             * Disconnect RobotOS
             * 连接已断开
             */
            override fun handleApiDisconnected() {
                Log.i(
                    TAG,
                    "handleApiDisconnected"
                )
            }
        })
    }

    private fun checkInit() {

        checkTimes++
        if (checkTimes > 10) {
            Log.e("isApiConnectedService", "Api Connected Service Filed !")
            messages = ("Api Connected Service Filed !")
        } else if (RobotApi.getInstance().isApiConnectedService) {
            Log.d("isApiConnectedService", "Api Connected Service Successfully !")
            messages = ("Api Connected Service Successfully !")
        } else {

            Handler(Looper.getMainLooper()).postDelayed({ checkInit() }, 200)
        }
    }

    private fun addApiCallBack() {
        Log.d(TAG, "CoreService connected ")
        RobotApi.getInstance().setCallback(mModuleCallbackApi)
        RobotApi.getInstance().setResponseThread(mApiCallbackThread)
    }


    private fun initSkillApi() {
        mSkillApi = SkillApi()
        val apiListener: ApiListener = object : ApiListener {
            override fun handleApiDisabled() {}

            /**
             * Handle speech service
             * 语音服务连接成功，注册语音回调
             */
            override fun handleApiConnected() {
                mSkillApi!!.registerCallBack(mSpeechCallbackApi)
            }

            /**
             * Disconnect speech service
             * 语音服务已断开
             */
            override fun handleApiDisconnected() {}
        }
        mSkillApi!!.addApiEventListener(apiListener)
        mSkillApi!!.connectApi(applicationContext)

    }


    private val mMotionListener: CommandListener = object : CommandListener() {
        override fun onResult(result: Int, message: String) {
            LogTools.info("result: $result message:$message")
            messages = if ("succeed" == message) {
                "Motion Listener succeed"
            } else {
                "Motion Listener failed"
            }
        }
    }

    private fun getPosition() {
        var placesList: List<Pose> = RobotApi.getInstance().placeList

        val sb = StringBuilder()
        for (pose in placesList) {
            sb.append(pose.name)
            sb.append(',')
        }
        LogTools.info("Place list:$sb")
        places = sb.toString()
    }

    private fun getPictureById() {
        RobotApi.getInstance()
            .getPictureById(reqId, reqId++, 10, object : CommandListener() {
                override fun onResult(result: Int, message: String) {
                    try {
                        val json = JSONObject(message)
                        val status = json.optString("status")
                        //get photos successfully
                        if (Definition.RESPONSE_OK == status) {
                            val pictures = json.optJSONArray("pictures")
                            if (!TextUtils.isEmpty(pictures.optString(0))) {
                                //Photo storage local full path
                                val picturePath = pictures.optString(0)
                                picture = picturePath
                            }
                        }
                    } catch (e: JSONException) {
                        e.printStackTrace()
                    } catch (e: java.lang.NullPointerException) {
                        e.printStackTrace()
                    }
                }
            })
    }

    private fun setLocation(placeName: String) {
        RobotApi.getInstance().setLocation(reqId, placeName, object : CommandListener() {
            override fun onResult(result: Int, message: String) {
                messages = if ("succeed" == message) {
                    //save the location point successfully
                    "save the location point successfully"
                } else {
                    //failed to save location point
                    "failed to save location point"
                }
            }
        })
    }

    private fun removeLocation(placeName: String) {
        RobotApi.getInstance().removeLocation(reqId, placeName, object : CommandListener() {
            override fun onResult(result: Int, message: String) {

                messages = if ("succeed" == message) {
                    // removeLocation successful
                    "moveLocation successful"
                } else {
                    //removeLocation failed
                    "removeLocation failed"
                }
            }
        })
    }

    private fun checkMapName() {
        RobotApi.getInstance().getMapName(reqId, object : CommandListener() {
            override fun onResult(result: Int, message: String) {
                if (!TextUtils.isEmpty(message)) {
                    //"message" means map name
                    mapName = message
                }
            }
        })
    }

    private fun startCruise() {

try {
    RobotApi.getInstance().stopCruise(reqId++)
    val route = RobotApi.getInstance().placeList
//        route.removeAt(0)
//        route.removeAt(1)
    val sb = java.lang.StringBuilder()
    for (pose in route) {
        sb.append(pose.name)
        sb.append(',')
    }
    LogTools.info("Place list:$sb")
    messages = ("Place list:$sb")
    val startPoint = 0
    val dockingPoints: MutableList<Int> = java.util.ArrayList()
    dockingPoints.add(1)
    RobotApi.getInstance().startCruise(reqId++, route, startPoint, dockingPoints, cruiseListener)

}catch (ex:Exception){}
    }

    /**
     * 开始引领
     */
    private fun startLead(destinationName:String) {
        val params = LeadingParams()

        //获取机器人视野内所有人体信息的人员列表

        //Get all bodies from robot
        val personList = PersonApi.getInstance().allBodyList
        if (personList == null || personList.size < 1) {
            LogTools.info("No person found.  没有找到需要引领的人。")
            return
        }
        //最佳身体意思是，机器人认为最像人身体的身体
        //best body mean it looks like body most
        val person = PersonUtils.getBestBody(personList, 3.0)
        LogTools.info("PersionID" + person.id)
        params.personId = person.id
        params.destinationName = destinationName
        params.lostTimer = (10 * 1000).toLong()
        params.detectDelay = (5 * 1000).toLong()
        params.maxDistance = 3.0
        val reqId = 0
        LogTools.info("startLead:$destinationName")
        RobotApi.getInstance().startLead(reqId, params, object : ActionListener() {
            val  resultMethodName:String="LeadResultEvent"
            @Throws(RemoteException::class)
            override fun onResult(status: Int, responseString: String) {
                when (status) {
                    Definition.RESULT_OK -> {
                        sendNavigationResult("success",status,responseString,resultMethodName)
                        LogTools.info("onResult status :$status(Lead success) result:$responseString")
                        LogTools.info("onResult status :$status(成功将目标引领到目的地) result:$responseString")
                    }
                    Definition.ACTION_RESPONSE_STOP_SUCCESS -> {
                        sendNavigationResult("success",status,responseString,resultMethodName)
                        LogTools.info("onResult status :$status(Lead in progress, but stopped) result:$responseString")
                        LogTools.info("onResult status :$status(成功将目标引领到目的地在引领执行中，主动调用stopLead，成功停止引领) result:$responseString")
                    }
                    else -> {}
                }
            }

            @Throws(RemoteException::class)
            override fun onError(errorCode: Int, errorString: String) {
                when (errorCode) {
                    Definition.ERROR_NOT_ESTIMATE -> {
                        sendNavigationResult("error",errorCode,errorString, resultMethodName)
                        LogTools.info("onError errorCode :$errorCode(not estimate) result:$errorString")
                        LogTools.info("onError errorCode :$errorCode(当前未定位) result:$errorString")
                    }
                    Definition.ERROR_SET_TRACK_FAILED, Definition.ERROR_TARGET_NOT_FOUND -> {
                        sendNavigationResult("error",errorCode,errorString, resultMethodName)
                        LogTools.info("onError errorCode :$errorCode(No person found) result:$errorString")
                        LogTools.info("onError errorCode :$errorCode(引领目标未找到) result:$errorString")
                    }
                    Definition.ERROR_IN_DESTINATION -> {
                        sendNavigationResult("error",errorCode,errorString, resultMethodName)
                        LogTools.info("onError errorCode :$errorCode(Already in destination) result:$errorString")
                        LogTools.info("onError errorCode :$errorCode(当前已经在引领目的地) result:$errorString")
                    }
                    Definition.ERROR_DESTINATION_CAN_NOT_ARRAIVE -> {
                        sendNavigationResult("error",errorCode,errorString, resultMethodName)
                        LogTools.info("onError errorCode :$errorCode(Avoid timeout，default 20s run less than 0.1m) result:$errorString")
                        LogTools.info("onError errorCode :$errorCode(避障超时，默认为机器人20s的前进距离不足0.1m) result:$errorString")
                    }
                    Definition.ERROR_DESTINATION_NOT_EXIST -> {
                        sendNavigationResult("error",errorCode,errorString, resultMethodName)
                        LogTools.info("onError errorCode :$errorCode(destination not exist) result:$errorString")
                        LogTools.info("onError errorCode :$errorCode(引领目的地不存在) result:$errorString")
                    }
                    Definition.ERROR_HEAD -> {
                        sendNavigationResult("error",errorCode,errorString, resultMethodName)
                        LogTools.info("onError errorCode :$errorCode(Head can't work in the process of leading) result:$errorString")
                        LogTools.info("onError errorCode :$errorCode(引领中操作头部云台失败) result:$errorString")
                    }
                    Definition.ACTION_RESPONSE_ALREADY_RUN -> {
                        sendNavigationResult("error",errorCode,errorString, resultMethodName)
                        LogTools.info("onError errorCode :$errorCode(Leading function already started, please stop and then restart) result:$errorString")
                        LogTools.info("onError errorCode :$errorCode(引领已经在进行中，请先停止上次引领，才能重新执行) result:$errorString")
                    }
                    Definition.ACTION_RESPONSE_REQUEST_RES_ERROR -> {
                        sendNavigationResult("error",errorCode,errorString,resultMethodName)
                        LogTools.info("onError errorCode :$errorCode(Other function using wheels, please stop them first) result:$errorString")
                        LogTools.info("onError errorCode :$errorCode(已经有需要控制底盘的接口调用，请先停止，才能继续调用) result:$errorString")
                    }
                    else -> {}
                }
            }

            @Throws(RemoteException::class)
            override fun onStatusUpdate(status: Int, data: String) {
                when (status) {
                    Definition.STATUS_NAVI_OUT_MAP -> {
                        sendNavigationResult("update", status,data, resultMethodName)
                        LogTools.info("onStatusUpdate status :$status(can't find destination, maybe it's out of this map ) result:$data")
                        LogTools.info("onStatusUpdate status :$status(目标点不能到达，引领目的地在地图外，有可能为地图与位置点不匹配，请重新设置位置点) result:$data")
                    }
                    Definition.STATUS_NAVI_AVOID -> {
                        sendNavigationResult("update",status,data, resultMethodName)
                        LogTools.info("onStatusUpdate status :$status(can not avoid obstacles) result:$data")
                        LogTools.info("onStatusUpdate status :$status(当前引领路线已被障碍物堵死) result:$data")
                    }
                    Definition.STATUS_NAVI_AVOID_END -> {
                        sendNavigationResult("update",status,data, resultMethodName)
                        LogTools.info("onStatusUpdate status :$status(obstacles removed) result:$data")
                        LogTools.info("onStatusUpdate status :$status(障碍物已移除) result:$data")
                    }
                    Definition.STATUS_GUEST_FARAWAY -> {
                        sendNavigationResult("update",status,data, resultMethodName)
                        LogTools.info("onStatusUpdate status :$status(destination is too far away, please change maxDistance settings ) result:$data")
                        LogTools.info("onStatusUpdate status :$status(引领目标距离机器人太远，判断标准通过参数maxDistance设置) result:$data")
                    }
                    Definition.STATUS_DEST_NEAR -> {
                        sendNavigationResult("update",status,data, resultMethodName)
                        LogTools.info("onStatusUpdate status :$status(leading person in near destination) result:$data")
                        LogTools.info("onStatusUpdate status :$status(引领目标进入机器人maxDistance范围内) result:$data")
                    }
                    Definition.STATUS_LEAD_NORMAL -> {
                        sendNavigationResult("update",status,data, resultMethodName)
                        LogTools.info("onStatusUpdate status :$status(leading started) result:$data")
                        LogTools.info("onStatusUpdate status :$status(正式开始导航) result:$data")
                    }
                    else -> {}
                }
            }
        })
    }

    /**
     * leading stop
     * 结束引领
     * isResetHW： 引领时会切换摄像头到后置摄像头，isResetHW是用于设置停止引领时是否恢复摄像头状态，
     * true: reset front camera, false: doesn't do anything
     * true：恢复摄像头为前置，false : 保持停止时的状态
     */
    private fun stopLead() {
        RobotApi.getInstance().stopLead(0, true)
    }


    /**
     * startNavigation
     * 导航到指定位置
     */
    private fun startNavigation(placeName: String?) {

        if(!isRobotInLocation(placeName)){
            try {
                stopFocusFollow()
                stopNavigation()
                stopCruise()
                RobotApi.getInstance().startNavigation(
                    0,
                    placeName,
                    1.5,
                    (10 * 1000).toLong(),
                    mNavigationListener
                )
            }catch (ex:Exception){
                Log.e("NavigationException",ex.message.toString())
            }
        }

    }

    private fun resumeSpecialPlaceTheta(placeName: String?) {
        RobotApi.getInstance().resumeSpecialPlaceTheta(reqId,
            placeName,
            object : CommandListener() {
                fun onResponse(result: Int, message: String?) {}
            })
    }

    /**
     * stopNavigation
     * 停止导航到指定位置
     */
    private fun stopNavigation() {
        RobotApi.getInstance().stopNavigation(0)
    }

    private fun isRobotInLocation(placeName: String?): Boolean {
        var isInLocation=false
        try {

            val params = JSONObject()
            params.put(Definition.JSON_NAVI_TARGET_PLACE_NAME, placeName) //position name
            params.put(Definition.JSON_NAVI_COORDINATE_DEVIATION, 2) //position range
            RobotApi.getInstance().isRobotInlocations(0,
                params.toString(), object : CommandListener() {
                    override fun onResult(result: Int, message: String?) {
                        try {
                            val json = JSONObject(message)
                            //whether or not at the target point
                            isInLocation= json.getBoolean(Definition.JSON_NAVI_IS_IN_LOCATION)
                        } catch (e: JSONException) {
                            e.printStackTrace()
                        }
                    }
                })
        } catch (e: JSONException) {
            e.printStackTrace()
        }
        return isInLocation
    }

//    private fun isCurrentMap(): Boolean {
//        return TextUtils.equals(
//            placeName1,
//            GlobalData.getInstance().getCurrentMapName()
//        )
//    }


    private val mSpeechCallbackApi: SkillCallback = object : SkillCallback() {

        @Throws(RemoteException::class)
        override fun onSpeechParResult(s: String) {
            LogTools.info("$TAG onSpeechParResult:$s")
        }

        @Throws(RemoteException::class)
        override fun onStart() {
            LogTools.info("$TAG onStart")
        }

        @Throws(RemoteException::class)
        override fun onStop() {
            LogTools.info("$TAG onStop")
        }

        @Throws(RemoteException::class)
        override fun onVolumeChange(i: Int) {
            //LogTools.info(TAG+" onVolumeChange :" + i);
        }

        @Throws(RemoteException::class)
        override fun onQueryEnded(i: Int) {
            LogTools.info("$TAG onQueryEnded :$i")
        }

        @Throws(RemoteException::class)
        override fun onQueryAsrResult(asrResult: String) {
            LogTools.info("$TAG onQueryAsrResult :$asrResult")
        }
    }

    private val mModuleCallbackApi: ModuleCallbackApi = object : ModuleCallbackApi() {

        val  resultMethodName:String="speechResultEvent"
        /**
         * Receive speech request
         * 接收语音指令 底层发起request 请求
         *
         * @param reqId
         * @param reqType 语音指令类型, Speech type
         * @param reqText 语音识别内容, Speech text
         * @param reqParam 语音指令参数, Speech param
         * @throws RemoteException
         */
        @Throws(RemoteException::class)
        override fun onSendRequest(
            reqId: Int,
            reqType: String,
            reqText: String,
            reqParam: String
        ): Boolean {
            Log.d(
                TAG,
                "New request:  type is:$reqType text is:$reqText reqParam = $reqParam"
            )
            val text =
                "New request:  type is:$reqType text is:$reqText reqParam = $reqParam"
            LogTools.info(text)
            sendNavigationResult("success",1,"request:$reqType,text:$reqText,reqParam:$reqParam", resultMethodName)

            botReqType = (reqType)
            botReqText = (reqText)
            botReqParam = (reqParam)
            return true
        }


        /**
         * hardware error callback
         * 硬件出现异常回调
         * @param function
         * @param type
         * @param message
         * @throws RemoteException
         */
        @Throws(RemoteException::class)
        override fun onHWReport(function: Int, type: String, message: String) {
            Log.i(
                TAG,
                "onHWReport function:$function type:$type message:$message"
            )
            LogTools.info("onHWReport function:$function type:$type message:$message")
            messages = ("onHWReport function:$function type:$type message:$message")
            sendNavigationResult("success",0,"onHWReport function:$function type:$type message:$message", resultMethodName)

        }

        /**
         * Suspend system, after this message, RobotOS can not work with this APP
         * 控制权被系统剥夺，收到该事件后，所有Api调用无效
         * @throws RemoteException
         */
        @Throws(RemoteException::class)
        override fun onSuspend() {
            Log.d(TAG, "onSuspend")
            LogTools.info("onSuspend")
            messages = ("onSuspend")
            sendNavigationResult("success",0,"onSuspend", resultMethodName)

        }

        /**
         * Recovery system, after this message, RobotOS can work with this APP again.
         * 控制权恢复，收到该事件后，重新恢复对机器人的控制
         * @throws RemoteException
         */
        @Throws(RemoteException::class)
        override fun onRecovery() {
            Log.d(TAG, "onRecovery")
            LogTools.info("onRecovery")
            messages = ("onRecovery")
            sendNavigationResult("success",0,"onRecovery", resultMethodName)

        }
    }

    private val mNavigationListener: ActionListener = object : ActionListener() {
        val  resultMethodName:String="navigationResultEvent"
        @Throws(RemoteException::class)
        override fun onResult(status: Int, response: String) {
            when (status) {
                Definition.RESULT_OK -> if ("true" == response) {
                    sendNavigationResult("success",status,response,resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$response"
                    // messages="$status(Navigation success) message: $response"
//                    messages= response
//                    messages =
//                        ("startNavigation result: $status(Navigation success) message: $response")
                    LogTools.info("startNavigation result: $status(Navigation success) message: $response")
                    LogTools.info("startNavigation result: $status(导航成功) message: $response")
                } else {
                    sendNavigationResult("success",status,response,resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$response"
//                    messages = "$status(Navigation failed) message: $response"
//                    messages = response
//                    messages =
//                        ("startNavigation result: $status(Navigation failed) message: $response")
                    LogTools.info("startNavigation result: $status(Navigation failed) message: $response")
                    LogTools.info("startNavigation result: $status(导航失败) message: $response")
                }
                Definition.ACTION_RESPONSE_STOP_SUCCESS->{
                    sendNavigationResult("success",status,response,resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$response"
                }
                else -> {
                    sendNavigationResult("success",status,response,resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$response"
                }
            }
        }

        @Throws(RemoteException::class)
        override fun onError(errorCode: Int, errorString: String) {
            when (errorCode) {
                Definition.ERROR_NOT_ESTIMATE -> {

//                    messages=("onError result: $errorCode(not estimate) message: $errorString")
//                    messages = errorString
                    sendNavigationResult("error",errorCode,errorString,resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                    LogTools.info("onError result: $errorCode(not estimate) message: $errorString")
                    LogTools.info("onError result: $errorCode(当前未定位) message: $errorString")
                }
                Definition.ERROR_IN_DESTINATION -> {
                    //   messages=("onError result: $errorCode(in destination, no action) message: $errorString")
//                    messages = errorString
                    sendNavigationResult("error",errorCode,errorString,resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                    LogTools.info("onError result: $errorCode(in destination, no action) message: $errorString")
                    LogTools.info("onError result: $errorCode(当前机器人已经在目的地范围内) message: $errorString")
                }
                Definition.ERROR_DESTINATION_NOT_EXIST -> {
                    //   messages=("onError result: $errorCode(destination not exist) message: $errorString")
//                    messages = errorString
                    sendNavigationResult("error",errorCode,errorString,resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                    LogTools.info("onError result: $errorCode(destination not exist) message: $errorString")
                    LogTools.info("onError result: $errorCode(导航目的地不存在) message: $errorString")
                }
                Definition.ERROR_DESTINATION_CAN_NOT_ARRAIVE -> {
                    //   messages=("onError result: $errorCode(avoid timeout, can not arrive) message: $errorString")
//                    messages = errorString
                    sendNavigationResult("error",errorCode,errorString,resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                    LogTools.info("onError result: $errorCode(avoid timeout, can not arrive) message: $errorString")
                    LogTools.info("onError result: $errorCode(避障超时，目的地不能到达，超时时间通过参数设置) message: $errorString")
                }
                Definition.ACTION_RESPONSE_ALREADY_RUN -> {
                    //   messages=("onError result: $errorCode(already started, please stop first) message: $errorString")
//                    messages = errorString
                    sendNavigationResult("error",errorCode,errorString,resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                    LogTools.info("onError result: $errorCode(当前接口已经调用，请先停止，才能再次调用) message: $errorString")
                }
                Definition.ACTION_RESPONSE_REQUEST_RES_ERROR -> {
                    //  messages=("onError result: $errorCode(wheels are busy for other actions, please stop first) message: $errorString")
//                    messages = errorString
                    sendNavigationResult("error",errorCode,errorString,resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                    LogTools.info("onError result: $errorCode(已经有需要控制底盘的接口调用，请先停止，才能继续调用) message: $errorString")
                }
                else -> {
                    sendNavigationResult("error",errorCode,errorString,resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                }
            }
        }

        @Throws(RemoteException::class)
        override fun onStatusUpdate(status: Int, data: String) {
            when (status) {
                Definition.STATUS_NAVI_AVOID -> {
                    // messages=("onStatusUpdate result: $status(can not avoid obstacles) message: $data")
//                    messages = data
                    sendNavigationResult("success",status,data,resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$data"
                    LogTools.info("onStatusUpdate result: $status(当前路线已经被障碍物堵死) message: $data")
                }
                Definition.STATUS_NAVI_AVOID_END -> {
//                    messages = data
//                    messages=("onStatusUpdate result: $status(Obstacle removed) message: $data")
                    sendNavigationResult("success",status,data,resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$data"
                    LogTools.info("onStatusUpdate result: $status(障碍物已移除) message: $data")
                }
                else -> {
                    navigationResult="NavigationResult:Code=$status,message=$data"
                }
            }
        }
    }

    private val mFocusListener: ActionListener = object : ActionListener() {
        val  resultMethodName:String="focusResultEvent"
        @Throws(RemoteException::class)
        override fun onResult(status: Int, response: String) {
            when (status) {
                Definition.RESULT_OK -> if ("true" == response) {
                    sendNavigationResult("success",status,response, resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$response"
                    // messages="$status(Navigation success) message: $response"
//                    messages= response
//                    messages =
//                        ("startNavigation result: $status(Navigation success) message: $response")
                    LogTools.info("startNavigation result: $status(Navigation success) message: $response")
                    LogTools.info("startNavigation result: $status(导航成功) message: $response")
                } else {
                    sendNavigationResult("success",status,response, resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$response"
//                    messages = "$status(Navigation failed) message: $response"
//                    messages = response
//                    messages =
//                        ("startNavigation result: $status(Navigation failed) message: $response")
                    LogTools.info("startNavigation result: $status(Navigation failed) message: $response")
                    LogTools.info("startNavigation result: $status(导航失败) message: $response")
                }
                Definition.ACTION_RESPONSE_STOP_SUCCESS->{
                    sendNavigationResult("success",status,response, resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$response"
                }
                else -> {
                    sendNavigationResult("success",status,response, resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$response"
                }
            }
        }

        @Throws(RemoteException::class)
        override fun onError(errorCode: Int, errorString: String) {
            when (errorCode) {
                Definition.ERROR_NOT_ESTIMATE -> {

//                    messages=("onError result: $errorCode(not estimate) message: $errorString")
//                    messages = errorString
                    sendNavigationResult("error",errorCode,errorString, resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                    LogTools.info("onError result: $errorCode(not estimate) message: $errorString")
                    LogTools.info("onError result: $errorCode(当前未定位) message: $errorString")
                }
                Definition.ERROR_IN_DESTINATION -> {
                    //   messages=("onError result: $errorCode(in destination, no action) message: $errorString")
//                    messages = errorString
                    sendNavigationResult("error",errorCode,errorString,resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                    LogTools.info("onError result: $errorCode(in destination, no action) message: $errorString")
                    LogTools.info("onError result: $errorCode(当前机器人已经在目的地范围内) message: $errorString")
                }
                Definition.ERROR_DESTINATION_NOT_EXIST -> {
                    //   messages=("onError result: $errorCode(destination not exist) message: $errorString")
//                    messages = errorString
                    sendNavigationResult("error",errorCode,errorString,resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                    LogTools.info("onError result: $errorCode(destination not exist) message: $errorString")
                    LogTools.info("onError result: $errorCode(导航目的地不存在) message: $errorString")
                }
                Definition.ERROR_DESTINATION_CAN_NOT_ARRAIVE -> {
                    //   messages=("onError result: $errorCode(avoid timeout, can not arrive) message: $errorString")
//                    messages = errorString
                    sendNavigationResult("error",errorCode,errorString,resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                    LogTools.info("onError result: $errorCode(avoid timeout, can not arrive) message: $errorString")
                    LogTools.info("onError result: $errorCode(避障超时，目的地不能到达，超时时间通过参数设置) message: $errorString")
                }
                Definition.ACTION_RESPONSE_ALREADY_RUN -> {
                    //   messages=("onError result: $errorCode(already started, please stop first) message: $errorString")
//                    messages = errorString
                    sendNavigationResult("error",errorCode,errorString,resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                    LogTools.info("onError result: $errorCode(当前接口已经调用，请先停止，才能再次调用) message: $errorString")
                }
                Definition.ACTION_RESPONSE_REQUEST_RES_ERROR -> {
                    //  messages=("onError result: $errorCode(wheels are busy for other actions, please stop first) message: $errorString")
//                    messages = errorString
                    sendNavigationResult("error",errorCode,errorString, resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                    LogTools.info("onError result: $errorCode(已经有需要控制底盘的接口调用，请先停止，才能继续调用) message: $errorString")
                }
                else -> {
                    sendNavigationResult("success",errorCode,errorString, resultMethodName)

                    navigationResult="NavigationResult:Code=$errorCode,message=$errorString"
                }
            }
        }

        @Throws(RemoteException::class)
        override fun onStatusUpdate(status: Int, data: String) {
            when (status) {
                Definition.STATUS_NAVI_AVOID -> {
                    // messages=("onStatusUpdate result: $status(can not avoid obstacles) message: $data")
//                    messages = data
                    sendNavigationResult("success",status,data, resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$data"
                    LogTools.info("onStatusUpdate result: $status(当前路线已经被障碍物堵死) message: $data")
                }
                Definition.STATUS_NAVI_AVOID_END -> {
//                    messages = data
//                    messages=("onStatusUpdate result: $status(Obstacle removed) message: $data")
                    sendNavigationResult("success",status,data, resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$data"
                    LogTools.info("onStatusUpdate result: $status(障碍物已移除) message: $data")
                }
                else -> {
                    sendNavigationResult("success",status,data, resultMethodName)

                    navigationResult="NavigationResult:Code=$status,message=$data"
                }
            }
        }
    }

    /**
     *
     */
    private fun registerPersonListener() {
        PersonApi.getInstance().registerPersonListener(mListener)
    }

    var reqID = 0

    /**
     * Use this to get all persons from robot visual ability
     * 人员变化时，可以调用获取当前人员列表接口获取机器人视野内所有人员
     */
    private val mListener: PersonListener = object : PersonListener() {
        override fun personChanged() {
            super.personChanged()
            val allFaceList = PersonApi.getInstance().allPersons
            LogTools.info("Found faces,count:" + allFaceList.size)
            messages = ("Found faces,count:" + allFaceList.size)
            //get best person face to register
            //找到人脸最佳的进行识别
            val person = PersonUtils.getBestFace(allFaceList)
            if (person == null) {
                messages = ("No good face found | 没有找到符合要求的人脸图片")
                LogTools.info("No good face found | 没有找到符合要求的人脸图片")
                return
            }
            //stop find people
            //停止找人
            PersonApi.getInstance().unregisterPersonListener(this)

            //get the face from network
            //找找人脸是否已经注册
            RobotApi.getInstance()
                .getPictureById(reqID++, person.id, 1, object : CommandListener() {
                    override fun onResult(result: Int, message: String) {
                        try {
                            val json = JSONObject(message)
                            val status = json.optString("status")
                            //获取照片成功 get picture success
                            if (Definition.RESPONSE_OK == status) {
                                val pictures = json.optJSONArray("pictures")
                                if (TextUtils.isEmpty(pictures.optString(0))) {
                                    LogTools.info("No good face picture found | 没有找到符合要求的人脸图片")
                                    messages = ("No good face picture found | 没有找到符合要求的人脸图片")
                                } else {
                                    val picturePath = pictures.optString(0)
                                    val facePics: MutableList<String> = ArrayList()
                                    facePics.add(picturePath)
                                    picture = picturePath
                                    RobotApi.getInstance().getPersonInfoFromNet(
                                        reqID++,
                                        person.userId,
                                        facePics,
                                        object : CommandListener() {
                                            override fun onResult(
                                                result: Int,
                                                message: String,
                                                extraData: String
                                            ) {
                                                try {
                                                    val json = JSONObject(message)
                                                    val info = json.getJSONObject("data")
                                                        .getJSONObject("people")
                                                    if (StringUtil.isNullOrEmpty(info.getString("user_id"))) {
                                                        LogTools.info(
                                                            "Person Unregister | gender:" + info.getString(
                                                                "gender"
                                                            )
                                                        )

                                                        messages = (
                                                                "Person Unregister | gender:" + info.getString(
                                                                    "gender"
                                                                )
                                                                )
                                                        if (action === REGISTER) {
                                                            registerPerson(person)
                                                        }
                                                    } else {
                                                        LogTools.info(
                                                            "Person Found:" + info.getString(
                                                                "name"
                                                            ) + "|gender:" + info.getString("gender")
                                                        )
                                                        messages = (
                                                                "Person Found:" + info.getString(
                                                                    "name"
                                                                ) + "|gender:" + info.getString("gender")
                                                                )
                                                    }
                                                } catch (e: JSONException) {
                                                    e.printStackTrace()
                                                } catch (e: java.lang.NullPointerException) {
                                                    e.printStackTrace()
                                                }
                                            }

                                            override fun onStatusUpdate(
                                                status: Int,
                                                data: String,
                                                extraData: String
                                            ) {
                                                LogTools.info("status$status | data:$data | extraData$extraData")
                                                messages =
                                                    ("status$status | data:$data | extraData$extraData")
                                            }
                                        })
                                }
                            } else {
                                LogTools.info("Can not found best face picture")
                                messages = ("Can not found best face picture")
                            }
                        } catch (e: JSONException) {
                            e.printStackTrace()
                        } catch (e: java.lang.NullPointerException) {
                            e.printStackTrace()
                        }
                    }
                })
            reqID++
        }
    }

    private fun stopFocusFollow() {
        RobotApi.getInstance().stopFocusFollow(0)
    }

    private fun startFocusFollow() {
        val person = PersonApi.getInstance().focusPerson

        if (person != null)
            RobotApi.getInstance()
                .startFocusFollow(0, person.id, 120, 4F, mFocusListener)
    }

    private fun registerPerson(person: Person) {
        //Register People, replace personName to your own person name or guid
        //注册人脸，把personName字段设置成应该设置的名字，或者GUID
        RobotApi.getInstance()
            .startRegister(reqID, "Person$reqID", 20000, 5, 2, object : ActionListener() {
                @Throws(RemoteException::class)
                override fun onResult(status: Int, response: String) {
                    if (Definition.RESULT_OK != status) {
                        //Register failed
                        //注册失败
                        LogTools.info("Register failed:$status|$response")
                        messages = ("Register failed:$status|$response")
                        return
                    }
                    try {
                        val json = JSONObject(response)
                        val remoteType = json.optString(Definition.REGISTER_REMOTE_TYPE)
                        val remoteName = json.optString(Definition.REGISTER_REMOTE_NAME)
                        if (Definition.REGISTER_REMOTE_SERVER_EXIST == remoteType) {
                            //user exists
                            //当前用户已存在
                            LogTools.info("Register failed:user exists")
                            messages = ("Register failed:user exists")
                        } else if (Definition.REGISTER_REMOTE_SERVER_NEW == remoteType) {
                            //register success
                            messages = ("Register success")
                            //新注册用户成功
                        }
                    } catch (e: JSONException) {
                        e.printStackTrace()
                    }
                }
            })
    }

    private var cruiseListener: ActionListener = object : ActionListener() {
        val  resultMethodName:String="cruiseResultEvent"
        @Throws(RemoteException::class)
        override fun onResult(status: Int, responseString: String) {
            LogTools.info("startCruise onResult : $status || $responseString")
            sendNavigationResult("success",status,"$status", resultMethodName)

            when (status) {
                Definition.RESULT_OK -> {}
                Definition.ACTION_RESPONSE_STOP_SUCCESS -> {}
            }
        }

        @Throws(RemoteException::class)
        override fun onStatusUpdate(status: Int, data: String) {
            LogTools.info("startCruise onStatusUpdate : $status || $data")
            messages = ("startCruise onStatusUpdate : $status || $data")
            sendNavigationResult("success",status,"$status", resultMethodName)

            when (status) {
                Definition.STATUS_NAVI_OUT_MAP -> {
                }
                Definition.STATUS_START_CRUISE -> {}
                Definition.STATUS_CRUISE_REACH_POINT -> {
                    messages = "${data.toInt()}"
                }
                Definition.STATUS_NAVI_AVOID -> {}
                Definition.STATUS_NAVI_AVOID_END -> {}
            }
        }

        @Throws(RemoteException::class)
        override fun onError(errorCode: Int, errorString: String) {
            LogTools.info("startCruise onError : $errorCode || $errorString")
            messages = ("startCruise onError : $errorCode || $errorString")
            sendNavigationResult("error",errorCode,"$errorString", resultMethodName)

            when (errorCode) {
                Definition.ACTION_RESPONSE_ALREADY_RUN -> {}
                Definition.ERROR_NOT_ESTIMATE -> {}
                Definition.ERROR_NAVIGATION_FAILED -> {}
                Definition.ACTION_RESPONSE_REQUEST_RES_ERROR -> {}
            }
        }
    }

    /**
     *
     */

    private fun playText(text: String) {
        if (mSkillApi != null) {
            connectApi()
            LogTools.info("text $text")
            mSkillApi!!.playText(TTSEntity("sid-1234567890", text), mTextListener)
        }
    }

    private val mTextListener: TextListener = object : TextListener() {
        val  resultMethodName:String="textListenerResultEvent"
        override fun onStart() {
            super.onStart()
            LogTools.info("onStart")
            textListenerStatus = ("onStart")
            sendNavigationResult("success",1,"onStart", resultMethodName)

        }

        override fun onStop() {
            super.onStop()
            LogTools.info("onStop")
            textListenerStatus = ("onStop")
            sendNavigationResult("success",1,"onStop", resultMethodName)

        }

        override fun onComplete() {
            super.onComplete()
            textListenerStatus = ("onComplete")
        }

        override fun onError() {
            super.onError()
            LogTools.info("onError")
            textListenerStatus=("onError")
            sendNavigationResult("success",0,"onError", resultMethodName)

        }
    }

    private fun stopTTS() {
        if (mSkillApi != null) {
            mSkillApi!!.stopTTS()
        }
    }


    private fun enableRecognizable() {
        if (mSkillApi != null) {
            mSkillApi!!.setRecognizable(true)
        }
    }

    private fun disableRecognizable() {
        if (mSkillApi != null) {
            mSkillApi!!.setRecognizable(false)
        }
    }

    private fun queryByText(text: String) {
        if (mSkillApi != null) {
            mSkillApi!!.queryByText(text)
        }
    }

    private fun connectApi() {
        mSkillApi?.connectApi(applicationContext, object : ApiListener {
            override fun handleApiDisabled() {}
            override fun handleApiConnected() {
                //Voice service connection is successful, register voice callback
                mSkillApi?.registerCallBack(mSpeechCallbackApi)
            }

            override fun handleApiDisconnected() {
                //Voice service has been disconnected
            }
        })
    }

    private fun isRobotEstimate() {
        RobotApi.getInstance().isRobotEstimate(reqId, object : CommandListener() {
            override fun onResult(result: Int, message: String) {
                val  resultMethodName:String="isRobotEstimateEvent"
                if ("true" != message) {
                    //currently not located
                    isRobotEstimateMessage=message
                    sendNavigationResult("success",1,message, resultMethodName)
                } else {
                    //currently located
                    isRobotEstimateMessage=message
                    sendNavigationResult("success",0,message, resultMethodName)
                }
            }
        })
    }

   private fun stopChargingByApp(){
       RobotApi.getInstance().stopChargingByApp()
   }
   private fun startNaviToAutoChargeAction(){

       RobotApi.getInstance()
           .startNaviToAutoChargeAction(reqId, 60, object : ActionListener() {
               val resultMethodName:String ="naviToAutoChargeResultEvent"
               @Throws(RemoteException::class)
               override fun onResult(status: Int, responseString: String) {
                   sendNavigationResult("success",status,responseString, resultMethodName)

                   when (status) {
                       Definition.RESULT_OK -> {
                       }
                       Definition.RESULT_FAILURE -> {
                       }
                   }
               }

               @Throws(RemoteException::class)
               override fun onStatusUpdate(status: Int, data: String) {
                   sendNavigationResult("success",status,data, resultMethodName)

                   when (status) {
                       Definition.STATUS_NAVI_GLOBAL_PATH_FAILED -> {

                       }
                       Definition.STATUS_NAVI_OUT_MAP -> {}
                       Definition.STATUS_NAVI_AVOID -> {}
                       Definition.STATUS_NAVI_AVOID_END -> {}
                       else -> {}
                   }
               }
           })
   }

    /**
     *
     */
    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


}
