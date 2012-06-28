
value print_foo () = print_endline "foo";

ENTRIES foo bar END

module Foo = struct
  ENTRIES bar gak END
end;
