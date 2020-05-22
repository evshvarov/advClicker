Class CatchUserUrl.UpdateDict Extends %Persistent
{

ClassMethod UpdateDict() As %Status
{
    &sql(
        truncate table CatchUserUrl.UserActRecomendDict
    )
    
    &sql(
        insert into CatchUserUrl.UserActRecomendDict (recid, recommendation)
        select 0 as recid, ' Нет переходов по рекламе' as recommendation
        union all
        select 1 as recid, ' Незначительное число переходов по рекламе' as recommendation
        union all
        select 2 as recid, ' Много переходов по рекламе' as recommendation
        union all
        select 3 as recid, ' Очень много переходов по рекламе' as recommendation
    )

    
    
    return $$$OK
}

Storage Default
{
<Data name="UpdateDictDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<DataLocation>^CatchUserUrl.UpdateDictD</DataLocation>
<DefaultData>UpdateDictDefaultData</DefaultData>
<IdLocation>^CatchUserUrl.UpdateDictD</IdLocation>
<IndexLocation>^CatchUserUrl.UpdateDictI</IndexLocation>
<StreamLocation>^CatchUserUrl.UpdateDictS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
