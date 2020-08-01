package cases;

import haxe.macro.Expr;
import tink.unit.Assert.*;

#if macro
using tink.MacroApi;
#end
@:genericBuild(cases.Builder.run())
class EnumAbstractTest<T> {
  public function new() {}
  
  // public function test() {
  //   return assert();
  // }
  
}


@:enum
abstract EnumAbstract(String) {
  var A = 'a';
  var B = 'b';
  var C = 'c';
  
  public static var i:Int;
  public static function f() {}
}