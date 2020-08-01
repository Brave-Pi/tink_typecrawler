package cases;

import haxe.macro.Expr;
import tink.unit.Assert.*;

#if macro
using tink.MacroApi;
#end
@:genericBuild(cases.Builder.run())
class TestRouter<T> {
  public function new() {}
  
  // public function test() {
  //   return assert();
  // }
  
}
