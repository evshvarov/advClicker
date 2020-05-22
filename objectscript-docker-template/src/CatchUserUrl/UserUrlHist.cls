Class CatchUserUrl.UserUrlHist Extends %Persistent
{

Property userid As %Decimal;

Property sessionid As %Decimal;

Property startsessiondt As %Decimal;

// Property endsessiondt As %Decimal;

Property url As %VarString;

Property urldt As %Decimal;

Method createRow(userid As %Numeric, sessionid As %Numeric, startsessiondt As %Numeric, endsessiondt As %Numeric, url As %String, urldt As %Numeric) As %Boolean
{
	set ##this.userid = userid
	set ##this.sessionid = sessionid
	set ##this.startsessiondt = startsessiondt
    //set ##this.endsessiondt = endsessiondt
	set ##this.url = url
	set ##this.urldt = urldt
	set result = ##this.%Save()
	quit result
}

ClassMethod SaveData(requestUserObj) As %Status
{
  set result = {}
  set obj = ##class(CatchUserUrl.UserUrlHist).%New()

  set obj.userid = requestUserObj.userid
  set obj.sessionid = requestUserObj.sessionid
  set obj.startsessiondt = requestUserObj.startsessiondt
  //set obj.endsessiondt = requestUserObj.endsessiondt
  set obj.url = requestUserObj.url
  set obj.urldt = requestUserObj.urldt

  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  return result
}

Storage Default
{
<Data name="UserUrlHistDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>userid</Value>
</Value>
<Value name="3">
<Value>sessionid</Value>
</Value>
<Value name="4">
<Value>startsessiondt</Value>
</Value>
<Value name="5">
<Value>url</Value>
</Value>
<Value name="6">
<Value>urldt</Value>
</Value>
</Data>
<DataLocation>^CatchUserUrl.UserUrlHistD</DataLocation>
<DefaultData>UserUrlHistDefaultData</DefaultData>
<IdLocation>^CatchUserUrl.UserUrlHistD</IdLocation>
<IndexLocation>^CatchUserUrl.UserUrlHistI</IndexLocation>
<StreamLocation>^CatchUserUrl.UserUrlHistS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
