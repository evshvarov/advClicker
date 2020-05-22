Class CatchUserUrl.PluginRestApi Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/plugindata/:arg1" Method="POST" Call="ResieveData"/>
  <Route Url="/test" Method="GET" Call="Test"/>
  <Route Url="/dbdata/:arg1" Method="GET" Call="SendData"/>
  <Route Url="/sessiondata/:arg1" Method="POST" Call="ReciveSessionData"/>
</Routes>
}

ClassMethod Test() As %Status
{
    write "this is test"
    Return $$$OK
}

ClassMethod ResieveData(arg1 As %String) As %Status
{
    set obj = {}.%FromJSON(%request.Content)
    set result = ##class(CatchUserUrl.UserUrlHist).SaveData(obj)

    
    Return result
}

ClassMethod SendData(arg1 As %String) As %Status
{
    set var1 = ##class(CatchUserUrl.UserUrlCatHistTmp).InsUserUrlCatHistTmp()
    set var2 = ##class(CatchUserUrl.UserActivityCalc).CalcAndSaveData()
    &sql(select cntadv, recommendation, cntallclicks into :cntadv, :recommendation, :cntallclicks
    from CatchUserUrl.UserActivityCalc
    where startsessiondt in (select max(startsessiondt) from CatchUserUrl.UserActivityCalc)
    )
    set vcntadv = cntadv
    set vrecommendation = recommendation
    set vcntallclicks = cntallclicks
    
    
    //set data = {"cntadv" : vcntadv, "recommendation" : vrecommendation}
    set data = {}.%Set("cntadv", vcntadv).%Set("recommendation", vrecommendation).%Set("cntallclicks", vcntallclicks)

    write data.%ToJSON()

    //write "hi"

    Return $$$OK
    
    //Quit $$$OK
}

ClassMethod ReciveSessionData(arg1 As %String) As %Status
{
    set obj = {}.%FromJSON(%request.Content)
    set result = ##class(CatchUserUrl.SessionsHist).SaveData(obj)
    Return result
}

}
