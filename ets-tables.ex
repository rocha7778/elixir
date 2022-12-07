
:ets.new(:user_lookup, [:set, :protected, :named_table])
:ets.insert(:user_lookup, {"doomspork", "Sean", ["Elixir", "Ruby", "Java"]})
:ets.insert(:user_lookup, {"3100", "", ["Elixir", "Ruby", "JavaScript"]})

[{{doomspork,'_','_'},
  [],
  ['$_']}]



:ets.match(:user_lookup, {:"$1", "Sean", :_})
[["doomspork"]]


:ets.match(:user_lookup, [{{:doomspork,'_','_'},
[],
['$_']}])

:ets.match(:user_lookup, {:"$99", :"$1", :"$3"})
[["Sean", ["Elixir", "Ruby", "Java"], "doomspork"],
 ["", ["Elixir", "Ruby", "JavaScript"], "3100"]]

 fun = :ets.fun2ms(fn {username, _, langs} when length(langs) >= 3 -> username end)
 fun = :ets.fun2ms(fn {username, _, langs} when length(langs) > 2 -> username end)

 :ets.select(:user_lookup, fun)


I have been reading about ETS and I have tried to understand how select (match) works, but until moment,
I have not been able to understand very well, I have a simple example taken from  (https://elixirschool.com/en/lessons/storage/ets) Simple Matches

:ets.new(:user_lookup, [:set, :protected, :named_table])
:ets.insert(:user_lookup, {"doomspork", "Sean", ["Elixir", "Ruby", "Java"]})
:ets.insert(:user_lookup, {"3100", "", ["Elixir", "Ruby", "JavaScript"]})

:ets.match(:user_lookup, {:"$1", "Sean", :_})
[["doomspork"]]

but in the simple match, what does "$1" mean? , "Sean", and :_
according documentation is result position, but if I change "$1" by "$2", the result is the same

:ets.match(:user_lookup, {:"$2", "Sean", :_})
[["doomspork"]]
