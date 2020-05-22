Class CatchUserUrl.UserActivityCalc Extends %Persistent
{

Property userid As %Decimal;

Property sessionid As %Decimal;

Property startsessiondt As %Decimal;

Property sessionperiod As %Decimal;

Property cntadv As %Decimal;

Property calccoef As %Double;

Property recommendation As %VarString;

Property cntallclicks As %Decimal;

ClassMethod CalcAndSaveData() As %Status
{
    &sql(
        select max(startsessiondt) into :mcalc
        from  CatchUserUrl.UserActivityCalc
 	)
    set maxstartsessiondtcalc = mcalc
    &sql(
        select max(startsessiondt) into :mtmp
        from  CatchUserUrl.UserUrlCatHistTmp
 	)
    set maxstartsessiondttmp = mtmp
    
    IF maxstartsessiondttmp = maxstartsessiondtcalc
    {
        &sql(
            delete from  CatchUserUrl.UserActivityCalc
            where startsessiondt in
            (select max(startsessiondt) 
             from  CatchUserUrl.UserActivityCalc)
        )
        
        set result = {}
        set obj = ##class(CatchUserUrl.UserActivityCalc).%New()
        &sql(
            select tab.calccoef, tab.cntadv, tab.cntall into :calccoef, :cntadv, :cntall
            from
            (select  t.cntall, t.cntadv, cntadv/cntall as calccoef
            from
            (select count(*) as cntall, sum(advflag) as cntadv
            from CatchUserUrl.UserUrlCatHistTmp) t) tab
        )
        set vcalccoef = calccoef
        set obj.calccoef = calccoef
        set obj.cntadv = cntadv
        set obj.cntallclicks = cntall
        &sql(
            
            select t.userid, t.sessionid, t.startsessiondt, (t.maxurldt - t.startsessiondt)
            into :userid, :sessionid, :startsessiondt, :sessionperiod
            from 
            (select userid, sessionid, startsessiondt, max(urldt) as maxurldt
            from  CatchUserUrl.UserUrlCatHistTmp
            group by userid, sessionid, startsessiondt) t
            where t.startsessiondt < t.maxurldt
        )
        set obj.userid = userid
        set obj.sessionid = sessionid
        set obj.startsessiondt = startsessiondt
        set obj.sessionperiod = sessionperiod
        
        IF vcalccoef = 0
        {
            &sql(
            select recommendation into :recommendation
            from CatchUserUrl.UserActRecomendDict where recid = 0
            )   
        }
        ELSEIF vcalccoef > 0, vcalccoef < 0.2
        {
            &sql(
            select recommendation into :recommendation
            from CatchUserUrl.UserActRecomendDict where recid = 1
            ) 
        }
        ELSEIF vcalccoef >= 0.2, vcalccoef < 0.7
        {
            &sql(
            select recommendation into :recommendation
            from CatchUserUrl.UserActRecomendDict where recid = 2
            ) 
        }
        ELSEIF vcalccoef >= 0.7, vcalccoef <= 1
        {
            &sql(
            select recommendation into :recommendation
            from CatchUserUrl.UserActRecomendDict where recid = 3
            ) 
        }

        //ELSE {
        //write "else"}

        set obj.recommendation = recommendation
        

        set saveResult = obj.%Save()
        if $$$ISOK(saveResult) set result = {"result": true}
        else  set result = {"result": false}
        set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
        set result.message = ErrorMessage
    }
    ELSEIF maxstartsessiondttmp > maxstartsessiondtcalc
    {
        
        
        set result = {}
        set obj = ##class(CatchUserUrl.UserActivityCalc).%New()
        &sql(
            select tab.calccoef, tab.cntadv, tab.cntall into :calccoef, :cntadv, :cntall
            from
            (select  t.cntall, t.cntadv, cntadv/cntall as calccoef
            from
            (select count(*) as cntall, sum(advflag) as cntadv
            from CatchUserUrl.UserUrlCatHistTmp) t) tab
        )
        set vcalccoef = calccoef
        set obj.calccoef = calccoef
        set obj.cntadv = cntadv
        set obj.cntallclicks = cntall
        &sql(
            
            select t.userid, t.sessionid, t.startsessiondt, (t.maxurldt - t.startsessiondt)
            into :userid, :sessionid, :startsessiondt, :sessionperiod
            from 
            (select userid, sessionid, startsessiondt, max(urldt) as maxurldt
            from  CatchUserUrl.UserUrlCatHistTmp
            group by userid, sessionid, startsessiondt) t
            where t.startsessiondt < t.maxurldt
        )
        set obj.userid = userid
        set obj.sessionid = sessionid
        set obj.startsessiondt = startsessiondt
        set obj.sessionperiod = sessionperiod
        
        IF vcalccoef = 0
        {
            &sql(
            select recommendation into :recommendation
            from CatchUserUrl.UserActRecomendDict where recid = 0
            )   
        }
        ELSEIF vcalccoef > 0, vcalccoef < 0.2
        {
            &sql(
            select recommendation into :recommendation
            from CatchUserUrl.UserActRecomendDict where recid = 1
            ) 
        }
        ELSEIF vcalccoef >= 0.2, vcalccoef < 0.7
        {
            &sql(
            select recommendation into :recommendation
            from CatchUserUrl.UserActRecomendDict where recid = 2
            ) 
        }
        ELSEIF vcalccoef >= 0.7, vcalccoef <= 1
        {
            &sql(
            select recommendation into :recommendation
            from CatchUserUrl.UserActRecomendDict where recid = 3
            ) 
        }

        //ELSE {
        //write "else"}

        set obj.recommendation = recommendation
        

        set saveResult = obj.%Save()
        if $$$ISOK(saveResult) set result = {"result": true}
        else  set result = {"result": false}
        set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
        set result.message = ErrorMessage
    }
    return $$$OK
}

Storage Default
{
<Data name="UserActivityCalcDefaultData">
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
<Value>sessionperiod</Value>
</Value>
<Value name="6">
<Value>cntadv</Value>
</Value>
<Value name="7">
<Value>calccoef</Value>
</Value>
<Value name="8">
<Value>recommendation</Value>
</Value>
<Value name="9">
<Value>cntallclicks</Value>
</Value>
</Data>
<DataLocation>^CatchUserUrl.UserActivityCalcD</DataLocation>
<DefaultData>UserActivityCalcDefaultData</DefaultData>
<IdLocation>^CatchUserUrl.UserActivityCalcD</IdLocation>
<IndexLocation>^CatchUserUrl.UserActivityCalcI</IndexLocation>
<StreamLocation>^CatchUserUrl.UserActivityCalcS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
