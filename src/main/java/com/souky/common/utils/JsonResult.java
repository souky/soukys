package com.souky.common.utils;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties({"hibernateLazyInitializer", "javassistLazyInitializer"})
public class JsonResult
{
  private boolean success = true;
  private String code = "";
  private String message = "";
  @SuppressWarnings({ "unchecked", "rawtypes" })
private Map<Object, Object> data = new HashMap();
  
  public JsonResult() {}
  
  public JsonResult(boolean success)
  {
    this.success = success;
  }
  
  public JsonResult(String code, String message)
  {
    this.code = code;
    this.message = message;
    this.success = false;
  }
  
  public boolean isSuccess()
  {
    return this.success;
  }
  
  public void setSuccess(boolean success)
  {
    this.success = success;
  }
  
  public String getCode()
  {
    return this.code;
  }
  
  public void setCode(String code)
  {
    this.code = code;
  }
  
  public String getMessage()
  {
    return this.message;
  }
  
  public void setMessage(String message)
  {
    this.message = message;
  }
  
  public Map<Object, Object> getData()
  {
    return this.data;
  }
  
  public void setData(Map<Object, Object> data)
  {
    this.data = data;
  }
  
  public void appendData(Object key, Object value)
  {
    this.data.put(key, value);
  }
  
  public void appendData(Map<?, ?> map)
  {
    this.data.putAll(map);
  }
}
