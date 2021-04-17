create or replace type TtextTable is table of varchar2(4000);
/
create or replace function StringToTable(text varchar2, delimiter char) return TtextTable is
FunctionResult TtextTable;
begin
select replace(regexp_substr(text,'.[^'||delimiter||']*',1,level),',',null) a
 bulk collect into FunctionResult
from dual
connect by instr(text,delimiter,1,level-1) > 0;
return FunctionResult;
end;
/
select column_value
from table(StringToTable('11111,22222,33333,44444,55555',','));
