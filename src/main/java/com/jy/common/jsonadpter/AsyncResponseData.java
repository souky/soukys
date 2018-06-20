package com.jy.common.jsonadpter;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.HashMap;
import java.util.Map;

/**
 * JSON格式的返回参数
 *
 */
public final class AsyncResponseData {
    public static final int RESPONSE_STATUS_OK = 10000;              //正常
    public static final int RESPONSE_STATUS_CLIENT_ERROR = 20000;    //客户端错误
    public static final int RESPONSE_STATUS_CLIENT_LOGIC_ERROR = 30000;  //客户逻辑端错误
    public static final int RESPONSE_STATUS_REQUEST_DENIED = 50000;  //访问受限
    public static final int RESPONSE_STATUS_REQUEST_DENIED_PERMISSION = 60000;  //访问受限(无权限)
    public static final int RESPONSE_STATUS_INTERNAL_ERROR = 40000;  //服务器内部错误
    public static final int RESPONSE_STATUS_UNCHECKED_ERROR = 99999;        //未检查到的异常

    private static final String ONE_MSG_KEY = "oneErrorMsg";
    private static final String ONE_DATA_KEY = "oneSimpleData";
    private static final String REDIRECT_URL_KEY = "redirectUrl";

    private AsyncResponseData() {
    }

    public static ResultData getDenied(String errMsg) {
        return new ResultData(RESPONSE_STATUS_REQUEST_DENIED_PERMISSION, errMsg);
    }

    public static ResultData getParamError(Map<String, String> errMsgs) {
        return new ResultData(RESPONSE_STATUS_CLIENT_ERROR, errMsgs);
    }

    public static ResultData getLogicError(String errMsg) {
        return new ResultData(RESPONSE_STATUS_CLIENT_LOGIC_ERROR, errMsg);
    }

    public static ResultData getSystemError(String errMsg) {
        return new ResultData(RESPONSE_STATUS_INTERNAL_ERROR, errMsg);
    }

    public static ResultData getSessionError(String errMsg) {
        return new ResultData(RESPONSE_STATUS_REQUEST_DENIED);
    }

    public static ResultData getSuccess(Object obj) {
        ResultData data = getSuccess();
        data.setData(obj);
        return data;
    }

    public static ResultData getSuccess() {
        return new ResultData(RESPONSE_STATUS_OK);
    }

    public static class ResultData {

        private ResultData(int code) {
            this.status = code;
        }

        private ResultData(int code, String message) {
            this.status = code;
            this.messages = new HashMap<String, String>();
            this.messages.put(ONE_MSG_KEY, message);
        }

        private ResultData(int code, Map<String, String> messages) {
            this.status = code;
            this.messages = messages;
        }

        private int status;
        private Map<String, Object> data;
        private Map<String, String> messages;

        @JsonIgnore
        /**
         * 判断当前消息是否为正常状态(200)
         */
        public boolean ok() {
            return this.status == RESPONSE_STATUS_OK;
        }

        @JsonProperty("code")
        public int getStatus() {
            return status;
        }


        /**
         * 返回 简单数据类型，通过putData(Object data)放入的数据
         *
         * @return
         */
        @JsonInclude(JsonInclude.Include.NON_NULL)
        public Object getResult() {
            if (null == data || !this.ok()) {
                return null;
            }
            if (data.containsKey(ONE_DATA_KEY)) {
                return data.get(ONE_DATA_KEY);
            } else {
                if (data.containsKey(REDIRECT_URL_KEY)) {
                    Map<String, Object> map = new HashMap<>(data);
                    map.remove(REDIRECT_URL_KEY);
                    return map;
                }
                return data;
            }
        }

//        /**
//         * 当需要重向时,返回重定向请求的 url 全路径(包含http部分)
//         * @return
//         */
//        @JsonInclude(JsonInclude.Include.NON_NULL)
//        public Object getRedirect(){
//            return null == this.data ? null : this.data.get(REDIRECT_URL_KEY);
//        }

        /**
         * 简单数据类型
         *
         * @param data
         */
        public void setData(Object data) {
            if (null == this.data) {
                this.data = new HashMap<String, Object>();
            }
            this.data.put(ONE_DATA_KEY, data);
        }

        public void setStatus(int status) {
            this.status = status;
        }


        /**
         * 将所有提示信息一次性输出
         *
         * @return
         */
        @JsonInclude(JsonInclude.Include.NON_NULL)
        public Object getMessage() {
            if (null == messages) {
                switch (this.status) {
                    case RESPONSE_STATUS_OK:
                        return "system.finished";
                    case RESPONSE_STATUS_CLIENT_ERROR:
                        return "input.params.error";
                    case RESPONSE_STATUS_CLIENT_LOGIC_ERROR:
                        return "logic.error";
                    case RESPONSE_STATUS_REQUEST_DENIED:
                        return "access.unauthorized";
                    case RESPONSE_STATUS_INTERNAL_ERROR:
                        return "system.error";
                    case RESPONSE_STATUS_UNCHECKED_ERROR:
                        return "system.unchecked.error";
                    case RESPONSE_STATUS_REQUEST_DENIED_PERMISSION:
                        return "access.denied";
                    default:
                }
                return null;
            }
            if (messages.containsKey(ONE_MSG_KEY)) {
                return messages.get(ONE_MSG_KEY);
            }
            return messages;
        }


        /**
         * 一般来讲用于执行完成无错误时，向客户端追加数据使用
         * 使用setData后,再调用此方法追加的数据无效
         *
         * @param key
         * @param data
         */
        public void appendData(String key, Object data) {
            if (null == this.data) {
                this.data = new HashMap<String, Object>();
            }
            this.data.put(key, data);
        }

        /**
         * 非200状态 通知客户端错误信息的添加
         *
         * @param key
         * @param msg
         */
        public void appendMessage(String key, String msg) {
            if (RESPONSE_STATUS_OK == this.status) {
                return;
            }
            if (null == this.messages) {
                this.messages = new HashMap<String, String>();
            }
            this.messages.put(key, msg);
        }

        public void setMessages(Map<String, String> messages) {
            this.messages = messages;
        }

        public ResultData asParamError() {
            return switchStatus(RESPONSE_STATUS_CLIENT_ERROR);
        }

        public ResultData asSessionError() {
            return switchStatus(RESPONSE_STATUS_REQUEST_DENIED);
        }

        public ResultData asLogicError() {
            return switchStatus(RESPONSE_STATUS_CLIENT_LOGIC_ERROR);
        }

        public ResultData asSystemError() {
            return switchStatus(RESPONSE_STATUS_INTERNAL_ERROR);
        }

        public ResultData asUnknownError(String errMsg) {
            return switchStatus(RESPONSE_STATUS_UNCHECKED_ERROR).putOneMessage(errMsg);
        }

        public ResultData asParamError(String msg) {
            return switchStatus(RESPONSE_STATUS_CLIENT_ERROR).putOneMessage(msg);
        }

        public ResultData asLogicError(String msg) {
            return switchStatus(RESPONSE_STATUS_CLIENT_LOGIC_ERROR).putOneMessage(msg);
        }

        public ResultData asSessionError(String msg) {
            return switchStatus(RESPONSE_STATUS_REQUEST_DENIED).putOneMessage(msg);
        }

        public ResultData asSystemError(String msg) {
            return switchStatus(RESPONSE_STATUS_INTERNAL_ERROR).putOneMessage(msg);
        }

        private ResultData switchStatus(int status) {
            if (status == this.status) {
                return this;
            }
            if (RESPONSE_STATUS_OK != this.status) {
                this.messages = new HashMap<String, String>();
                this.messages.put(ONE_MSG_KEY, "不能将" + this.status + "的消息转换为" + status);
                this.status = RESPONSE_STATUS_INTERNAL_ERROR;
                return this;
            }
            this.status = status;
            return this;
        }

        private ResultData putOneMessage(String msg) {
            if (null == this.messages) {
                this.messages = new HashMap<String, String>();
            }
            if (!this.messages.containsKey(ONE_MSG_KEY)) {
                this.messages.put(ONE_MSG_KEY, msg);
            }
            return this;
        }
    }
}

