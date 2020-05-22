Class CatchUserUrl.UserUrlCatHistTmp Extends %Persistent
{

Property userid As %Decimal;

Property sessionid As %Decimal;

Property startsessiondt As %Decimal;

Property url As %VarString;

Property urldt As %Decimal;

Property advflag As %Decimal;

ClassMethod InsUserUrlCatHistTmp() As %Status
{
    &sql(
	 	delete from CatchUserUrl.UserUrlCatHistTmp
 	)

	
    &sql(
	 	insert into CatchUserUrl.UserUrlCatHistTmp ( userid,
										 sessionid,
										 startsessiondt,
										 url,
										 urldt,
										 advflag) 
        select userid, sessionid, startsessiondt, url, urldt, 1 as advflag
        from CatchUserUrl.UserUrlHist
        where (url like '%utm%' or url like '%gclid%'or url like '%yclid%' or
        url like '%ymclid%' or url like '%fbclid%') and
		startsessiondt in (select max(startsessiondt)
		 from CatchUserUrl.UserUrlHist)

 	)

    &sql(
	 	insert into CatchUserUrl.UserUrlCatHistTmp ( userid,
										 sessionid,
										 startsessiondt,
										 url,
										 urldt,
										 advflag)
        select userid, sessionid, startsessiondt, url, urldt, 0 as advflag
        from CatchUserUrl.UserUrlHist
        where url not like '%utm%' and url not like '%gclid%' and url not like '%yclid%' and
        url not like '%ymclid%' and url not like '%fbclid%' and 
		startsessiondt in (select max(startsessiondt)
		 from CatchUserUrl.UserUrlHist)
 	)
    Return $$$OK
}

Storage Default
{
<Data name="UserUrlCatHistTmpDefaultData">
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
<DataLocation>^CatchUserUrl.UserUrlCatH8CCAD</DataLocation>
<DefaultData>UserUrlCatHistTmpDefaultData</DefaultData>
<IdLocation>^CatchUserUrl.UserUrlCatH8CCAD</IdLocation>
<IndexLocation>^CatchUserUrl.UserUrlCatH8CCAI</IndexLocation>
<StreamLocation>^CatchUserUrl.UserUrlCatH8CCAS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
