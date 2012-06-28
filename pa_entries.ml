
open Camlp4.PreCast
;
value implem_entries = Gram.Entry.mk "implem_entries"; Gram.Entry.clear implem_entries;
value struct_entries = Gram.Entry.mk "struct_entries"; Gram.Entry.clear struct_entries;
value struct_expr    = Gram.Entry.mk "struct_expr";    Gram.Entry.clear struct_expr
;
value make_loc n_line =  Loc.of_tuple ("pa_entries.ml",n_line,0,0,n_line,0,0,False)
;
value cons_entry name items =
  let    _loc = make_loc 11 in let decl  = <:str_item< value $lid:name$ = Gram.Entry.mk $str:name$ >>
  in let _loc = make_loc 12 in let clear = <:str_item< Gram.Entry.clear $lid:name$ >>
  in [decl;clear::items]
;
DELETE_RULE Gram Syntax.module_expr: "struct"; Syntax.str_items; "end" END
;
EXTEND Gram
  Syntax.implem: [["ENTRIES"; x = implem_entries -> x ]]
  ;
  implem_entries: [
   [ name = LIDENT; (items,status) = SELF -> (cons_entry name items, status)
   | "END"; x = Syntax.implem -> x
  ]];
  struct_entries: [
   [ name = LIDENT; items = SELF -> cons_entry name items
   | "END"; items = struct_expr -> items
  ]];
  Syntax.module_expr: LEVEL "top"
   [[ "struct"; st = struct_expr -> <:module_expr< struct $Ast.stSem_of_list st$ end >> ]]
  ;
  struct_expr: [
    ["ENTRIES"; x = struct_entries -> x
    | item = Syntax.str_item; Syntax.semi; items = SELF -> [item::items]
    | "end" -> []
  ]];

END;
