Class CatchUserUrl.SessionsHist Extends %Persistent
{

Property startsessiondt As %Decimal;

Property endsessiondt As %Decimal;

ClassMethod SaveData(requestUserObj) As %Status
{
  set result = {}
  set obj = ##class(CatchUserUrl.SessionsHist).%New()


  set obj.startsessiondt = requestUserObj.startsessiondt
  set obj.endsessiondt = requestUserObj.endsessiondt

  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  return result
}

Storage Default
{
<Data name="SessionsHistDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>startsessiondt</Value>
</Value>
<Value name="3">
<Value>endsessiondt</Value>
</Value>
</Data>
<DataLocation>^CatchUserUrl.SessionsHistD</DataLocation>
<DefaultData>SessionsHistDefaultData</DefaultData>
<IdLocation>^CatchUserUrl.SessionsHistD</IdLocation>
<IndexLocation>^CatchUserUrl.SessionsHistI</IndexLocation>
<StreamLocation>^CatchUserUrl.SessionsHistS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
