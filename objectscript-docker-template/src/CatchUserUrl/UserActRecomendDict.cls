Class CatchUserUrl.UserActRecomendDict Extends %Persistent
{

Property recid As %Decimal;

Property recommendation As %VarString;

Storage Default
{
<Data name="UserActRecomendDictDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>recid</Value>
</Value>
<Value name="3">
<Value>recommendation</Value>
</Value>
</Data>
<DataLocation>^CatchUserUrl.UserActReco3190D</DataLocation>
<DefaultData>UserActRecomendDictDefaultData</DefaultData>
<IdLocation>^CatchUserUrl.UserActReco3190D</IdLocation>
<IndexLocation>^CatchUserUrl.UserActReco3190I</IndexLocation>
<StreamLocation>^CatchUserUrl.UserActReco3190S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
