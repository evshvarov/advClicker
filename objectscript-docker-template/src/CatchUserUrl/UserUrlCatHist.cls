Class CatchUserUrl.UserUrlCatHist Extends %Persistent
{

Property userid As %Decimal;

Property sessionid As %Decimal;

Property startsessiondt As %Decimal;

Property url As %VarString;

Property urldt As %Decimal;

Property advflag As %Decimal;

ClassMethod InsUserUrlCatHist() As %Status
{
    &sql(
	 	insert into CatchUserUrl.UserUrlCatHist ( userid,
										 sessionid,
										 startsessiondt,
										 url,
										 urldt,
										 advflag) 
        select userid, sessionid, startsessiondt, url, urldt, advflag
        from CatchUserUrl.UserUrlCatHistTmp
 	)

    Return $$$OK
}

Storage Default
{
<Data name="UserUrlCatHistDefaultData">
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
<Value name="7">
<Value>advflag</Value>
</Value>
</Data>
<DataLocation>^CatchUserUrl.UserUrlCatHistD</DataLocation>
<DefaultData>UserUrlCatHistDefaultData</DefaultData>
<IdLocation>^CatchUserUrl.UserUrlCatHistD</IdLocation>
<IndexLocation>^CatchUserUrl.UserUrlCatHistI</IndexLocation>
<StreamLocation>^CatchUserUrl.UserUrlCatHistS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
